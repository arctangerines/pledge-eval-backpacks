# Ligo-PyCBC
This application analyzes gravitational wave data from
two LIGO detectors, identifying candidates and finding coincidences by considering
the data from both detectors.

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
floability execute --backpack . --entrypoint ligo_pycbc_local.sh --no-worker
```
