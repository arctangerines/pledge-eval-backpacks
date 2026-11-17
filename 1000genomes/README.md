# 1000 Genomes backpack
This is a smaller version of the 1000 Genomes benchmark, 
which is used to measure the frequency of generic features
and find the similarities across populations.

## Executing
Run the backpack with:
```
floability execute --backpack . --measure-performance --manager-ports 9129:9800
```
If you wish to run it locally:
```
floability execute --backpack . --entrypoint workflow/1000genomes_local.sh
```

## 1000Genomes reference
`Clarke L, Zheng-Bradley X, Smith R, Kulesha E, Xiao C, Toneva I, Vaughan B, Preuss D, Leinonen R, Shumway M, Sherry S, and Flicek P. The 1000 genomes project: data management and community access, 2012. Nature Methods.`
`Pegasus Project. 1000 Genomes Repository. https://github.com/pegasus-isi/1000genome-workflow.`
