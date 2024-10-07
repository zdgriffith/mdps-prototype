#!/usr/bin/env python3
import logging
import os
import shutil
import subprocess
from dataclasses import asdict, dataclass
from datetime import datetime, timedelta
from pathlib import Path

import fnmeta

LOG = logging.getLogger("mvcm_l2")


def run(*args, **kwds):
    LOG.info("runninng: %s", " ".join([str(s) for s in args[0]]))
    return subprocess.run(*args, **kwds)


def oisst2bin(oisst: Path, gdas: Path):
    swdir = "/software/oisst2bin"
    output = oisst.with_name(f"oisst.{oisst.name[19:27]}")
    run(
        [
            f"{swdir}/source/oisst_nc2bin.py",
            str(oisst),
            str(gdas),
            f"{swdir}/dist/inland_water.nc",
            str(oisst),
        ],
        check=True,
        env={
            **os.environ,
            "ECCODES_DEFINITION_PATH": f"{swdir}/dist/env/share/eccodes/definitions",
        },
    )
    return output


def viirsmend(l1b: Path, geo: Path) -> Path:
    """(L1B, GEO) -> Mended L1B"""
    output = l1b.with_name(l1b.name.replace(".nc", "mended.nc"))
    shutil.copy(l1b, output)
    run(
        [
            "python3",
            "-m",
            "viirsmend.l1mend",
            str(output),
            str(geo),
        ],
        check=True,
    )
    return output


def l1bscale(satellite: str, l1b: Path) -> Path:
    """L1B -> Scaled L1B"""
    swdir = "/software/l1bscale"
    if satellite == "snpp":
        satellite = "npp"
    scale_factors = f"{swdir}/{satellite}_scale_factors.txt"
    run(
        [f"{swdir}/bin/VIIRS_L1BSCALE.exe", str(l1b), scale_factors],
        check=True,
    )
    return l1b


def create_iff_filename(prefix, platform, dt, output_type="HDF4"):
    origin = "ssec"
    domain = "dev"
    suffix = {"HDF4": ".hdf", "NETCDF": ".nc"}

    begin_date = dt.strftime("d%Y%m%d")
    begin_time = dt.strftime("t%H%M%S")
    processed_time = datetime.now().strftime("c%Y%m%d%H%M%S")

    fn = "%s%s" % (
        "_".join(
            [prefix, platform, begin_date, begin_time, processed_time, origin, domain]
        ),
        suffix[output_type],
    )
    return fn


def iff(
    satellite: str,
    granule: datetime,
    l1b: Path,
    geo: Path,
    output_type: str = "hdf",
    band_type: str = "M",
) -> Path:
    output = Path(
        create_iff_filename(
            ("IFF" + {"M": "SVM", "I": "SVI", "DNB": "DNB"}[band_type]),
            satellite,
            granule,
            output_type,
        )
    )
    cmd = [
        "python",
        "-m",
        "iff2.iff2",
        "-o",
        str(output),
        "--hdf4" if output_type == "HDF4" else "",
        satellite,
        "viirs-nasa",
        band_type,
        f"{granule:%Y%m%d}",
        f"{granule:%H%M%S}",
        f"{granule + timedelta(minutes=6, seconds=-1):%H%M%S}",
        str(l1b),
        str(geo),
    ]
    run(cmd, check=True)
    return output


def mvcm(
    satellite: str,
    granule: datetime,
    iffsvm: Path,
    nise: Path,
    gdas: tuple[Path, Path],
    sst: Path,
) -> Path:
    created = datetime.utcnow()
    output = Path(
        f"CLDMSK_L2_VIIRS_SNPP.{granule:A%Y%j.%H%M}.001.{created:%Y%j%H%M%S}.nc"
    )
    run(
        [
            "/software/mvcm/run.py",
            "--out",
            str(output),
            satellite,
            granule.strftime("%Y-%j %H:%M:%S"),
            str(iffsvm),
            str(nise),
            str(sst),
            str(gdas[0]),
            str(gdas[1]),
        ],
        check=True,
    )
    return output


@dataclass
class Inputs:
    l1b: Path
    geo: Path
    sst: Path
    nise: Path
    gdas1: Path
    gdas2: Path


def pipeline(inputs: Inputs):
    meta = fnmeta.identify(inputs.l1b.name)
    if not meta:
        raise ValueError(f"Failed to identify {inputs.l1b}")
    granule = meta["begin_time"]
    satellite = meta["satellite"]["name"]
    LOG.info(f"parsed {satellite=} {granule=}")

    l1b = viirsmend(inputs.l1b, inputs.geo)
    l1b = l1bscale(satellite, l1b)
    iffsvm = iff(satellite, granule, l1b, inputs.geo)
    sst = oisst2bin(inputs.sst, inputs.gdas1)

    mvcm(
        satellite,
        granule,
        iffsvm,
        inputs.nise,
        (inputs.gdas1, inputs.gdas2),
        sst,
    )


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("--l1b")
    parser.add_argument("--geo")
    parser.add_argument("--gdas1")
    parser.add_argument("--gdas2")
    parser.add_argument("--sst")
    args = parser.parse_args()

    inputs = Inputs(
        **{k: getattr(args, k) for k in ["l1b", "geo", "sst", "gdas1", "gdas2"]}
    )

    for k, v in asdict(inputs).items():
        LOG.info("input %s -> %s", k, v.abspath())

    pipeline(inputs)
