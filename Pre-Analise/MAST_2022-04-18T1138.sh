#!/bin/bash
#
# Requires bash version >= 4
# 
# The script uses the command line tool 'curl' for querying
# the MAST Download service for public and protected data. 
#

type -P curl >&/dev/null || { echo "This script requires curl. Exiting." >&2; exit 1; }



# Check for existing Download Folder
# prompt user for overwrite, if found
let EXTENSION=0
FOLDER=MAST_2022-04-18T1138
DOWNLOAD_FOLDER=$FOLDER
if [ -d $DOWNLOAD_FOLDER ]
then
  echo -n "Download folder ${DOWNLOAD_FOLDER} found, (C)ontinue writing to existing folder or use (N)ew folder? [N]> "
  read -n1 ans
  if [ "$ans" = "c" -o "$ans" = "C" ]
  then
    echo ""
    echo "Downloading to existing folder: ${DOWNLOAD_FOLDER}"
    CONT="-C -"
  else
    while [ -d $DOWNLOAD_FOLDER ]
    do
      ((EXTENSION++))
      DOWNLOAD_FOLDER="${FOLDER}-${EXTENSION}"
    done

    echo ""
    echo "Downloading to new folder: ${DOWNLOAD_FOLDER}"
  fi
fi

# mkdir if it doesn't exist and download files there. 
mkdir -p ${DOWNLOAD_FOLDER}

cat >${DOWNLOAD_FOLDER}/MANIFEST.HTML<<EOT
<!DOCTYPE html>
<html>
    <head>
        <title>MAST_2022-04-18T1138</title>
    </head>
    <body>
        <h2>Manifest for File: MAST_2022-04-18T1138</h2>
        <h3>Total Files: 104</h3>
        <table cellspacing="0" cellpadding="4" rules="all" style="border-width:5px; border-style:solid; border-collapse:collapse;">
            <tr>
                <td><b>URI</b></td>
                <td><b>File</b></td>
                <td><b>Access</b></td>
                <td><b>Status</b></td>
                <td><b>Logged In User</b></td>
            </tr>
            
            <tr>
                <td>mast:HLSP/qlp/s0005/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.txt</td>
                <td>HLSP/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.txt</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/pbcd/SPITZER_I1_39987968_0000_2_E11549374_maic.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/pbcd/SPITZER_I1_39987968_0000_2_E11549374_maic.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/diamante/0000/0002/1934/5200/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_dv.pdf</td>
                <td>HLSP/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_dv.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018292093539-s0004-s0004-0000000219345200-00407_dvm.pdf</td>
                <td>TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093539-s0004-s0004-0000000219345200-00407_dvm.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018206190142-s0001-s0006-0000000219345200-00196_dvt.fits</td>
                <td>TESS/tess2018206190142-s0001-s0006-0000000219345200/tess2018206190142-s0001-s0006-0000000219345200-00196_dvt.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-flags.fits.gz</td>
                <td>GALEX/6385658111545311232/AIS_419_sg97-nd-flags.fits.gz</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0005/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_lc.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2020294194027-s0031-0000000219345200-0198-s_tp.fits</td>
                <td>TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020294194027-s0031-0000000219345200-0198-s_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0006/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_lc.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/pbcd/SPITZER_I2_39987968_0000_2_E11553171_maic.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/pbcd/SPITZER_I2_39987968_0000_2_E11553171_maic.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0006/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-rrhr.fits.gz</td>
                <td>GALEX/6385658111545311232/AIS_419_sg97-nd-rrhr.fits.gz</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-skybg.fits.gz</td>
                <td>GALEX/6385658111545311232/AIS_419_sg97-nd-skybg.fits.gz</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018206190142-s0001-s0036-0000000219345200-00471_dvm.pdf</td>
                <td>TESS/tess2018206190142-s0001-s0036-0000000219345200/tess2018206190142-s0001-s0036-0000000219345200-00471_dvm.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018319095959-s0005-0000000219345200-0125-s_tp.fits</td>
                <td>TESS/tess2018319095959-s0005-0000000219345200-0125-s/tess2018319095959-s0005-0000000219345200-0125-s_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018206190142-s0001-s0036-0000000219345200-01-00471_dvs.pdf</td>
                <td>TESS/tess2018206190142-s0001-s0036-0000000219345200/tess2018206190142-s0001-s0036-0000000219345200-01-00471_dvs.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0004/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018206190142-s0001-s0036-0000000219345200-00471_dvt.fits</td>
                <td>TESS/tess2018206190142-s0001-s0036-0000000219345200/tess2018206190142-s0001-s0036-0000000219345200-00471_dvt.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/qlp/s0004/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.txt</td>
                <td>HLSP/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.txt</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/diamante/0000/0002/1934/5200/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.fits</td>
                <td>HLSP/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/diamante/0000/0002/1934/5200/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.txt</td>
                <td>HLSP/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.txt</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_bkg.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_bkg.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0004/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_lc.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-skybg.fits.gz</td>
                <td>GALEX/6385658111545311232/AIS_419_sg97-fd-skybg.fits.gz</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4_tess_v2_pm.txt</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-0118-0916_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4_tess_v2_pm.txt</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_bkg.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_bkg.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018292093540-s0004-s0004-0000000219345200-00135_dvt.fits</td>
                <td>TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093540-s0004-s0004-0000000219345200-00135_dvt.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0005/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/qlp/s0006/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.txt</td>
                <td>HLSP/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.txt</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_bkg.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_bkg.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-int.fits.gz</td>
                <td>GALEX/6385658111545311232/AIS_419_sg97-nd-int.fits.gz</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/qlp/s0004/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.fits</td>
                <td>HLSP/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018292093539-s0004-s0004-0000000219345200-01-00407_dvs.pdf</td>
                <td>TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093539-s0004-s0004-0000000219345200-01-00407_dvs.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-xd-mcat.fits.gz</td>
                <td>GALEX/6385658111545311232/AIS_419_sg97-xd-mcat.fits.gz</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_bkg.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_bkg.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2020296001112-s0031-s0031-0000000219345200-00411_dvm.pdf</td>
                <td>TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020296001112-s0031-s0031-0000000219345200-00411_dvm.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0032/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_lc.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018292093540-s0004-s0004-0000000219345200-01-00135_dvs.pdf</td>
                <td>TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093540-s0004-s0004-0000000219345200-01-00135_dvs.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/qlp/s0005/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.fits</td>
                <td>HLSP/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_bkg.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_bkg.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018319095959-s0005-0000000219345200-0125-s_lc.fits</td>
                <td>TESS/tess2018319095959-s0005-0000000219345200-0125-s/tess2018319095959-s0005-0000000219345200-0125-s_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-int.fits.gz</td>
                <td>GALEX/6385658111545311232/AIS_419_sg97-fd-int.fits.gz</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018292093540-s0004-s0004-0000000219345200-00135_dvm.pdf</td>
                <td>TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093540-s0004-s0004-0000000219345200-00135_dvm.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/qlp/s0006/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.fits</td>
                <td>HLSP/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-rrhr.fits.gz</td>
                <td>GALEX/6385658111545311232/AIS_419_sg97-fd-rrhr.fits.gz</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2020296001112-s0031-s0031-0000000219345200-00411_dvt.fits</td>
                <td>TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020296001112-s0031-s0031-0000000219345200-00411_dvt.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/qlp/s0032/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0032-0000000219345200_tess_v01_llc.fits</td>
                <td>HLSP/hlsp_qlp_tess_ffi_s0032-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0032-0000000219345200_tess_v01_llc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0032/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3_tess_v2_pm.txt</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-0804-1726_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3_tess_v2_pm.txt</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_bkg.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_bkg.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2020324010417-s0032-0000000219345200-0200-s_tp.fits</td>
                <td>TESS/tess2020324010417-s0032-0000000219345200-0200-s/tess2020324010417-s0032-0000000219345200-0200-s_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2019114105919-s0001-s0006-0000000219345200-00196_dvm.pdf</td>
                <td>TESS/tess2018206190142-s0001-s0006-0000000219345200/tess2019114105919-s0001-s0006-0000000219345200-00196_dvm.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_bkg.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_bkg.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_bkg.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_bkg.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018292075959-s0004-0000000219345200-0124-s_tp.fits</td>
                <td>TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292075959-s0004-0000000219345200-0124-s_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3_tess_v2_pm.txt</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-1980-0106_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3_tess_v2_pm.txt</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2020324010417-s0032-0000000219345200-0200-s_lc.fits</td>
                <td>TESS/tess2020324010417-s0032-0000000219345200-0200-s/tess2020324010417-s0032-0000000219345200-0200-s_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0031/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018292075959-s0004-0000000219345200-0124-s_lc.fits</td>
                <td>TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292075959-s0004-0000000219345200-0124-s_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018349182500-s0006-0000000219345200-0126-s_tp.fits</td>
                <td>TESS/tess2018349182500-s0006-0000000219345200-0126-s/tess2018349182500-s0006-0000000219345200-0126-s_tp.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/qlp/s0031/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0031-0000000219345200_tess_v01_llc.fits</td>
                <td>HLSP/hlsp_qlp_tess_ffi_s0031-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0031-0000000219345200_tess_v01_llc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-flags.fits.gz</td>
                <td>GALEX/6385658111545311232/AIS_419_sg97-fd-flags.fits.gz</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_cbcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_cbcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2020296001112-s0031-s0031-0000000219345200-01-00411_dvs.pdf</td>
                <td>TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020296001112-s0031-s0031-0000000219345200-01-00411_dvs.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018206190142-s0001-s0006-0000000219345200-01-00196_dvs.pdf</td>
                <td>TESS/tess2018206190142-s0001-s0006-0000000219345200/tess2018206190142-s0001-s0006-0000000219345200-01-00196_dvs.pdf</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018349182500-s0006-0000000219345200-0126-s_lc.fits</td>
                <td>TESS/tess2018349182500-s0006-0000000219345200-0126-s/tess2018349182500-s0006-0000000219345200-0126-s_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/tess-spoc/s0031/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_lc.fits</td>
                <td>HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2018292093539-s0004-s0004-0000000219345200-00407_dvt.fits</td>
                <td>TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093539-s0004-s0004-0000000219345200-00407_dvt.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:TESS/product/tess2020294194027-s0031-0000000219345200-0198-s_lc.fits</td>
                <td>TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020294194027-s0031-0000000219345200-0198-s_lc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_bcd.fits</td>
                <td>SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_bcd.fits</td>
                <td>PUBLIC</td>
                <td>REMOTE</td>
                <td>anonymous</td>
            </tr>
            
            <tr>
                <td>mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc.fits</td>
                <td>HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc.fits</td>
                <td>PUBLIC</td>
                <td>OK</td>
                <td>anonymous</td>
            </tr>
            
        </table>
    </body>
</html>

EOT

# Download Product Files:



cat <<EOT
<<< Downloading File: mast:HLSP/qlp/s0005/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.txt
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.txt
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.txt' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/qlp/s0005/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.txt'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/pbcd/SPITZER_I1_39987968_0000_2_E11549374_maic.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/pbcd/SPITZER_I1_39987968_0000_2_E11549374_maic.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/pbcd/SPITZER_I1_39987968_0000_2_E11549374_maic.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/pbcd/SPITZER_I1_39987968_0000_2_E11549374_maic.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/diamante/0000/0002/1934/5200/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_dv.pdf
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_dv.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_dv.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/diamante/0000/0002/1934/5200/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_dv.pdf'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018292093539-s0004-s0004-0000000219345200-00407_dvm.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093539-s0004-s0004-0000000219345200-00407_dvm.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093539-s0004-s0004-0000000219345200-00407_dvm.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018292093539-s0004-s0004-0000000219345200-00407_dvm.pdf'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018206190142-s0001-s0006-0000000219345200-00196_dvt.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018206190142-s0001-s0006-0000000219345200/tess2018206190142-s0001-s0006-0000000219345200-00196_dvt.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018206190142-s0001-s0006-0000000219345200/tess2018206190142-s0001-s0006-0000000219345200-00196_dvt.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018206190142-s0001-s0006-0000000219345200-00196_dvt.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-flags.fits.gz
                  To: ${DOWNLOAD_FOLDER}/GALEX/6385658111545311232/AIS_419_sg97-nd-flags.fits.gz
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/GALEX/6385658111545311232/AIS_419_sg97-nd-flags.fits.gz' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-flags.fits.gz'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0005/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_lc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0005/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_lc.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2020294194027-s0031-0000000219345200-0198-s_tp.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020294194027-s0031-0000000219345200-0198-s_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020294194027-s0031-0000000219345200-0198-s_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2020294194027-s0031-0000000219345200-0198-s_tp.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0006/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_lc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0006/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_lc.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/pbcd/SPITZER_I2_39987968_0000_2_E11553171_maic.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/pbcd/SPITZER_I2_39987968_0000_2_E11553171_maic.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/pbcd/SPITZER_I2_39987968_0000_2_E11553171_maic.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/pbcd/SPITZER_I2_39987968_0000_2_E11553171_maic.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0006/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0006/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0006_tess_v1_tp.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc.fits'





cat <<EOT
<<< Downloading File: mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-rrhr.fits.gz
                  To: ${DOWNLOAD_FOLDER}/GALEX/6385658111545311232/AIS_419_sg97-nd-rrhr.fits.gz
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/GALEX/6385658111545311232/AIS_419_sg97-nd-rrhr.fits.gz' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-rrhr.fits.gz'





cat <<EOT
<<< Downloading File: mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-skybg.fits.gz
                  To: ${DOWNLOAD_FOLDER}/GALEX/6385658111545311232/AIS_419_sg97-nd-skybg.fits.gz
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/GALEX/6385658111545311232/AIS_419_sg97-nd-skybg.fits.gz' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-skybg.fits.gz'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018206190142-s0001-s0036-0000000219345200-00471_dvm.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018206190142-s0001-s0036-0000000219345200/tess2018206190142-s0001-s0036-0000000219345200-00471_dvm.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018206190142-s0001-s0036-0000000219345200/tess2018206190142-s0001-s0036-0000000219345200-00471_dvm.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018206190142-s0001-s0036-0000000219345200-00471_dvm.pdf'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018319095959-s0005-0000000219345200-0125-s_tp.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018319095959-s0005-0000000219345200-0125-s/tess2018319095959-s0005-0000000219345200-0125-s_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018319095959-s0005-0000000219345200-0125-s/tess2018319095959-s0005-0000000219345200-0125-s_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018319095959-s0005-0000000219345200-0125-s_tp.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018206190142-s0001-s0036-0000000219345200-01-00471_dvs.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018206190142-s0001-s0036-0000000219345200/tess2018206190142-s0001-s0036-0000000219345200-01-00471_dvs.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018206190142-s0001-s0036-0000000219345200/tess2018206190142-s0001-s0036-0000000219345200-01-00471_dvs.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018206190142-s0001-s0036-0000000219345200-01-00471_dvs.pdf'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0004/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0004/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018206190142-s0001-s0036-0000000219345200-00471_dvt.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018206190142-s0001-s0036-0000000219345200/tess2018206190142-s0001-s0036-0000000219345200-00471_dvt.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018206190142-s0001-s0036-0000000219345200/tess2018206190142-s0001-s0036-0000000219345200-00471_dvt.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018206190142-s0001-s0036-0000000219345200-00471_dvt.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/qlp/s0004/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.txt
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.txt
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.txt' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/qlp/s0004/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.txt'





cat <<EOT
<<< Downloading File: mast:HLSP/diamante/0000/0002/1934/5200/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/diamante/0000/0002/1934/5200/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/diamante/0000/0002/1934/5200/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.txt
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.txt
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.txt' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/diamante/0000/0002/1934/5200/hlsp_diamante_tess_lightcurve_tic-0000000219345200_tess_v1_llc.txt'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0001_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_bkg.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_bkg.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_bkg.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0646_tess_v2_bkg.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0004/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_lc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0004/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0004_tess_v1_lc.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0005_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-skybg.fits.gz
                  To: ${DOWNLOAD_FOLDER}/GALEX/6385658111545311232/AIS_419_sg97-fd-skybg.fits.gz
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/GALEX/6385658111545311232/AIS_419_sg97-fd-skybg.fits.gz' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-skybg.fits.gz'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0002_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4_tess_v2_pm.txt
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-0118-0916_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4_tess_v2_pm.txt
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-0118-0916_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4_tess_v2_pm.txt' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4_tess_v2_pm.txt'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_bkg.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_bkg.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_bkg.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_bkg.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018292093540-s0004-s0004-0000000219345200-00135_dvt.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093540-s0004-s0004-0000000219345200-00135_dvt.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093540-s0004-s0004-0000000219345200-00135_dvt.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018292093540-s0004-s0004-0000000219345200-00135_dvt.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0006_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0005/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0005/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0005_tess_v1_tp.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/qlp/s0006/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.txt
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.txt
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.txt' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/qlp/s0006/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.txt'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_bkg.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_bkg.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_bkg.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0314-0592_tess_v2_bkg.fits'





cat <<EOT
<<< Downloading File: mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-int.fits.gz
                  To: ${DOWNLOAD_FOLDER}/GALEX/6385658111545311232/AIS_419_sg97-nd-int.fits.gz
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/GALEX/6385658111545311232/AIS_419_sg97-nd-int.fits.gz' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-nd-int.fits.gz'





cat <<EOT
<<< Downloading File: mast:HLSP/qlp/s0004/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/qlp/s0004/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0004-0000000219345200_tess_v01_llc.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018292093539-s0004-s0004-0000000219345200-01-00407_dvs.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093539-s0004-s0004-0000000219345200-01-00407_dvs.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093539-s0004-s0004-0000000219345200-01-00407_dvs.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018292093539-s0004-s0004-0000000219345200-01-00407_dvs.pdf'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-xd-mcat.fits.gz
                  To: ${DOWNLOAD_FOLDER}/GALEX/6385658111545311232/AIS_419_sg97-xd-mcat.fits.gz
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/GALEX/6385658111545311232/AIS_419_sg97-xd-mcat.fits.gz' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-xd-mcat.fits.gz'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_bkg.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_bkg.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_bkg.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1132_tess_v2_bkg.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0003_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2020296001112-s0031-s0031-0000000219345200-00411_dvm.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020296001112-s0031-s0031-0000000219345200-00411_dvm.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020296001112-s0031-s0031-0000000219345200-00411_dvm.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2020296001112-s0031-s0031-0000000219345200-00411_dvm.pdf'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0032/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_lc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0032/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_lc.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018292093540-s0004-s0004-0000000219345200-01-00135_dvs.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093540-s0004-s0004-0000000219345200-01-00135_dvs.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093540-s0004-s0004-0000000219345200-01-00135_dvs.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018292093540-s0004-s0004-0000000219345200-01-00135_dvs.pdf'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/qlp/s0005/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/qlp/s0005/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0005-0000000219345200_tess_v01_llc.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_bkg.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_bkg.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_bkg.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_bkg.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018319095959-s0005-0000000219345200-0125-s_lc.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018319095959-s0005-0000000219345200-0125-s/tess2018319095959-s0005-0000000219345200-0125-s_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018319095959-s0005-0000000219345200-0125-s/tess2018319095959-s0005-0000000219345200-0125-s_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018319095959-s0005-0000000219345200-0125-s_lc.fits'





cat <<EOT
<<< Downloading File: mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-int.fits.gz
                  To: ${DOWNLOAD_FOLDER}/GALEX/6385658111545311232/AIS_419_sg97-fd-int.fits.gz
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/GALEX/6385658111545311232/AIS_419_sg97-fd-int.fits.gz' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-int.fits.gz'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018292093540-s0004-s0004-0000000219345200-00135_dvm.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093540-s0004-s0004-0000000219345200-00135_dvm.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093540-s0004-s0004-0000000219345200-00135_dvm.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018292093540-s0004-s0004-0000000219345200-00135_dvm.pdf'





cat <<EOT
<<< Downloading File: mast:HLSP/qlp/s0006/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/qlp/s0006/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0006-0000000219345200_tess_v01_llc.fits'





cat <<EOT
<<< Downloading File: mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-rrhr.fits.gz
                  To: ${DOWNLOAD_FOLDER}/GALEX/6385658111545311232/AIS_419_sg97-fd-rrhr.fits.gz
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/GALEX/6385658111545311232/AIS_419_sg97-fd-rrhr.fits.gz' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-rrhr.fits.gz'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0004_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2020296001112-s0031-s0031-0000000219345200-00411_dvt.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020296001112-s0031-s0031-0000000219345200-00411_dvt.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020296001112-s0031-s0031-0000000219345200-00411_dvt.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2020296001112-s0031-s0031-0000000219345200-00411_dvt.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/qlp/s0032/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0032-0000000219345200_tess_v01_llc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_qlp_tess_ffi_s0032-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0032-0000000219345200_tess_v01_llc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_qlp_tess_ffi_s0032-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0032-0000000219345200_tess_v01_llc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/qlp/s0032/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0032-0000000219345200_tess_v01_llc.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0002_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0004_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0032/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0032/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0032_tess_v1_tp.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3_tess_v2_pm.txt
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-0804-1726_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3_tess_v2_pm.txt
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-0804-1726_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3_tess_v2_pm.txt' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3_tess_v2_pm.txt'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0005_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_bkg.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_bkg.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_bkg.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_bkg.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2020324010417-s0032-0000000219345200-0200-s_tp.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2020324010417-s0032-0000000219345200-0200-s/tess2020324010417-s0032-0000000219345200-0200-s_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2020324010417-s0032-0000000219345200-0200-s/tess2020324010417-s0032-0000000219345200-0200-s_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2020324010417-s0032-0000000219345200-0200-s_tp.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0006_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2019114105919-s0001-s0006-0000000219345200-00196_dvm.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018206190142-s0001-s0006-0000000219345200/tess2019114105919-s0001-s0006-0000000219345200-00196_dvm.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018206190142-s0001-s0006-0000000219345200/tess2019114105919-s0001-s0006-0000000219345200-00196_dvm.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2019114105919-s0001-s0006-0000000219345200-00196_dvm.pdf'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_bkg.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_bkg.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_bkg.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-1024_tess_v2_bkg.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_bkg.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_bkg.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_bkg.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0005/3-3/hlsp_eleanor_tess_ffi_postcard-s0005-3-3-cal-1686-1186_tess_v2_bkg.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018292075959-s0004-0000000219345200-0124-s_tp.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292075959-s0004-0000000219345200-0124-s_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292075959-s0004-0000000219345200-0124-s_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018292075959-s0004-0000000219345200-0124-s_tp.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3_tess_v2_pm.txt
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-1980-0106_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3_tess_v2_pm.txt
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-1980-0106_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3_tess_v2_pm.txt' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3_tess_v2_pm.txt'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2020324010417-s0032-0000000219345200-0200-s_lc.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2020324010417-s0032-0000000219345200-0200-s/tess2020324010417-s0032-0000000219345200-0200-s_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2020324010417-s0032-0000000219345200-0200-s/tess2020324010417-s0032-0000000219345200-0200-s_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2020324010417-s0032-0000000219345200-0200-s_lc.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0031/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0031/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018292075959-s0004-0000000219345200-0124-s_lc.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292075959-s0004-0000000219345200-0124-s_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292075959-s0004-0000000219345200-0124-s_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018292075959-s0004-0000000219345200-0124-s_lc.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018349182500-s0006-0000000219345200-0126-s_tp.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018349182500-s0006-0000000219345200-0126-s/tess2018349182500-s0006-0000000219345200-0126-s_tp.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018349182500-s0006-0000000219345200-0126-s/tess2018349182500-s0006-0000000219345200-0126-s_tp.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018349182500-s0006-0000000219345200-0126-s_tp.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/qlp/s0031/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0031-0000000219345200_tess_v01_llc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_qlp_tess_ffi_s0031-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0031-0000000219345200_tess_v01_llc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_qlp_tess_ffi_s0031-0000000219345200_tess_v01_llc/hlsp_qlp_tess_ffi_s0031-0000000219345200_tess_v01_llc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/qlp/s0031/0000/0002/1934/5200/hlsp_qlp_tess_ffi_s0031-0000000219345200_tess_v01_llc.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0001_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch1/bcd/SPITZER_I1_39987968_0000_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-flags.fits.gz
                  To: ${DOWNLOAD_FOLDER}/GALEX/6385658111545311232/AIS_419_sg97-fd-flags.fits.gz
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/GALEX/6385658111545311232/AIS_419_sg97-fd-flags.fits.gz' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:GALEX/url/data/GR6/pipe/02-vsn/50419-AIS_419/d/01-main/0001-img/07-try/AIS_419_sg97-fd-flags.fits.gz'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_cbcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_cbcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_cbcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0003_0000_2_cbcd.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2020296001112-s0031-s0031-0000000219345200-01-00411_dvs.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020296001112-s0031-s0031-0000000219345200-01-00411_dvs.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020296001112-s0031-s0031-0000000219345200-01-00411_dvs.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2020296001112-s0031-s0031-0000000219345200-01-00411_dvs.pdf'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018206190142-s0001-s0006-0000000219345200-01-00196_dvs.pdf
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018206190142-s0001-s0006-0000000219345200/tess2018206190142-s0001-s0006-0000000219345200-01-00196_dvs.pdf
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018206190142-s0001-s0006-0000000219345200/tess2018206190142-s0001-s0006-0000000219345200-01-00196_dvs.pdf' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018206190142-s0001-s0006-0000000219345200-01-00196_dvs.pdf'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018349182500-s0006-0000000219345200-0126-s_lc.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018349182500-s0006-0000000219345200-0126-s/tess2018349182500-s0006-0000000219345200-0126-s_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018349182500-s0006-0000000219345200-0126-s/tess2018349182500-s0006-0000000219345200-0126-s_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018349182500-s0006-0000000219345200-0126-s_lc.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/tess-spoc/s0031/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_lc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_tp/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/tess-spoc/s0031/target/0000/0002/1934/5200/hlsp_tess-spoc_tess_phot_0000000219345200-s0031_tess_v1_lc.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2018292093539-s0004-s0004-0000000219345200-00407_dvt.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093539-s0004-s0004-0000000219345200-00407_dvt.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2018292075959-s0004-0000000219345200-0124-s/tess2018292093539-s0004-s0004-0000000219345200-00407_dvt.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2018292093539-s0004-s0004-0000000219345200-00407_dvt.fits'





cat <<EOT
<<< Downloading File: mast:TESS/product/tess2020294194027-s0031-0000000219345200-0198-s_lc.fits
                  To: ${DOWNLOAD_FOLDER}/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020294194027-s0031-0000000219345200-0198-s_lc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/TESS/tess2020294194027-s0031-0000000219345200-0198-s/tess2020294194027-s0031-0000000219345200-0198-s_lc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:TESS/product/tess2020294194027-s0031-0000000219345200-0198-s_lc.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0646_tess_v2_pc.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0006/3-3/hlsp_eleanor_tess_ffi_postcard-s0006-3-3-cal-0216-0592_tess_v2_pc.fits'





cat <<EOT
<<< Downloading File: https://irsa.ipac.caltech.edu/data/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_bcd.fits
                  To: ${DOWNLOAD_FOLDER}/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_bcd.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/SPITZER_SHA/000002622B00/SPITZER/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_bcd.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:SPITZER/url/SHA/archive/proc/IRAC026000/r39987968/ch2/bcd/SPITZER_I2_39987968_0000_0000_2_bcd.fits'





cat <<EOT
<<< Downloading File: mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc.fits
                  To: ${DOWNLOAD_FOLDER}/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc.fits
EOT

curl --globoff --location-trusted -f --progress-bar --create-dirs $CONT --output ./${DOWNLOAD_FOLDER}'/HLSP/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc.fits' 'https://mast.stsci.edu/api/v0.1/Download/file?bundle_name=MAST_2022-04-18T1138.sh&uri=mast:HLSP/eleanor/postcards/s0004/3-4/hlsp_eleanor_tess_ffi_postcard-s0004-3-4-cal-1000-0970_tess_v2_pc.fits'




exit 0
