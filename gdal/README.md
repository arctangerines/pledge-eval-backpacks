# GDAL: Global Mosaic
This backpack uses the GDAL toolkit to create virtual mosaics of earth
containing geospatial data.

The final mosaics generated are different combinations of 
elevation, precipitation, solar radiation, maximum temperature and minimum temperature, 
at different resolutions.

## Executing
Run the backpack with:
```
floability execute --backpack . --manager-ports 9129:9800
```

You can also indicate the batch system:
```
floability execute --backpack . --manager-ports 9129:9800 --batch-type condor
```

If you wish to run it locally:
```
floability execute --backpack . --entrypoint gdal_local.sh --no-worker
```

## GDAL Reference
`GDAL/OGR contributors. Geospatial Data Abstraction software Library. https://gdal.org, 2026`
