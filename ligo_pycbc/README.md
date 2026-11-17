# Ligo-PyCBC
This application analyzes gravitational wave data from
two LIGO detectors, identifying candidates and finding coincidences by considering
the data from both detectors.

## Executing
Run the backpack with:
```
floability execute --backpack . --measure-performance --manager-ports 9129:9800
```
If you wish to run it locally:
```
floability execute --backpack . --entrypoint ligo_pycbc_local.sh
```
