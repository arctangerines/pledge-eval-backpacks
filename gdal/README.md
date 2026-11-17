# GDAL: Global Mosaic
This backpack uses the GDAL toolkit to create virtual mosaics of earth
containing geospatial data.

The final mosaics generated are different combinations of 
elevation, precipitation, solar radiation, maximum temperature and minimum temperature, 
at different resolutions.

## Executing
Run the backpack with:
```
floability execute --backpack . --measure-performance --manager-ports 9129:9800
```
If you wish to run it locally:
```
floability execute --backpack . --entry-point workflow/gdal_local.sh
```

## GDAL Reference
`GDAL/OGR contributors. Geospatial Data Abstraction software Library. https://gdal.org, 2026`
