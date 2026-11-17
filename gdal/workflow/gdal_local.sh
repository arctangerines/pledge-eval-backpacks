#! /bin/bash
#set -e
set -o pipefail

WCdataPrefix=("wc2.1_2.5m" "wc2.1_5m" "wc2.1_10m")
WCdata=("wc2.1_2.5m_bio" "wc2.1_2.5m_elev" "wc2.1_2.5m_prec" "wc2.1_2.5m_srad" "wc2.1_2.5m_tavg" "wc2.1_2.5m_tmax" "wc2.1_2.5m_tmin" "wc2.1_2.5m_vapr" "wc2.1_2.5m_wind" 
"wc2.1_5m_bio" "wc2.1_5m_elev" "wc2.1_5m_prec" "wc2.1_5m_srad" "wc2.1_5m_tavg" "wc2.1_5m_tmax" "wc2.1_5m_tmin" "wc2.1_5m_vapr" "wc2.1_5m_wind" 
"wc2.1_10m_bio" "wc2.1_10m_elev" "wc2.1_10m_prec" "wc2.1_10m_srad" "wc2.1_10m_tavg" "wc2.1_10m_tmax" "wc2.1_10m_tmin" "wc2.1_10m_vapr" "wc2.1_10m_wind")

WCdataPrefixLarge=("wc2.1_30s")
WCdataLarge=("wc2.1_30s_elev" "wc2.1_30s_prec" "wc2.1_30s_srad" "wc2.1_30s_tavg" "wc2.1_30s_tmax" "wc2.1_30s_tmin" "wc2.1_30s_vapr" "wc2.1_30s_wind")


Geodata=("${WCdata[@]}" "${WCdataLarge[@]}")
GeodataPrefixes=("${WCdataPrefix[@]}" "${WCdataPrefixLarge[@]}")

for gt in ${Geodata[@]}; do
    echo $gt
    unzip $gt.zip -d $gt
done
for gt in ${WCdata[@]}; do
    echo $gt
    gdalbuildvrt $gt.vrt $PWD/$gt/*.tif
done

for wc in ${WCdataPrefix[@]}; do
    gdalwarp -of GTiff -r bilinear -multi "$(pwd)/${wc}_prec.vrt" "$(pwd)/${wc}_srad.vrt" "$(pwd)/${wc}_elev.vrt" "$(pwd)/${wc}_elev_prec_srad.tif"
    gdalwarp -of GTiff -r bilinear -multi "$(pwd)/${wc}_tavg.vrt" "$(pwd)/${wc}_srad.vrt" "$(pwd)/${wc}_elev.vrt" "$(pwd)/${wc}_elev_tavg_srad.tif"
    gdalwarp -of GTiff -r bilinear -multi "$(pwd)/${wc}_tmax.vrt" "$(pwd)/${wc}_tmin.vrt" "$(pwd)/${wc}_vapr.vrt" "$(pwd)/${wc}_elev.vrt" "$(pwd)/${wc}_elev_tmax_tmin_vapr.tif"
    gdalwarp -of GTiff -r bilinear -multi "$(pwd)/${wc}_prec.vrt" "$(pwd)/${wc}_vapr.vrt" "$(pwd)/${wc}_tavg.vrt" "$(pwd)/${wc}_elev.vrt" "$(pwd)/${wc}_elev_prec_vapr_tavg.tif"
    gdalwarp -of GTiff -r bilinear -multi "$(pwd)/${wc}_prec.vrt" "$(pwd)/${wc}_srad.vrt" "$(pwd)/${wc}_vapr.vrt" "$(pwd)/${wc}_elev.vrt" "$(pwd)/${wc}_elev_prec_srad_vapr.tif"
done

for gt in ${WCdataLarge[@]}; do
    echo $gt
    gdalbuildvrt $gt.vrt $PWD/$gt/*.tif
done

for wc in ${WCdataPrefixLarge[@]}; do
    gdalwarp -of GTiff -r bilinear -multi "$(pwd)/${wc}_prec.vrt" "$(pwd)/${wc}_srad.vrt" "$(pwd)/${wc}_elev.vrt" "$(pwd)/${wc}_elev_prec_srad.tif"
    gdalwarp -of GTiff -r bilinear -multi "$(pwd)/${wc}_prec.vrt" "$(pwd)/${wc}_vapr.vrt" "$(pwd)/${wc}_elev.vrt" "$(pwd)/${wc}_elev_prec_vapr.tif"
    gdalwarp -of GTiff -r bilinear -multi "$(pwd)/${wc}_prec.vrt" "$(pwd)/${wc}_wind.vrt" "$(pwd)/${wc}_elev.vrt" "$(pwd)/${wc}_elev_wind_prec.tif"
done
