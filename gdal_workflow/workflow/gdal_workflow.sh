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

makeflow --jx ./gdal.sh.jx -T vine -p 9129
