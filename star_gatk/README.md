# Star-GATK
This workflow performs a variant search using STAR and GATK.
It uses STAR to perform RNA sequence alignment and GATK to find
variants in four fasta files containing sample DNA sequences from the human genome.

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
floability execute --backpack . --entrypoint star_gatk_local.sh --no-worker
```

## STAR reference
`Alexander Dobin, Carrie A. Davis, Felix Schlesinger, Jorg Drenkow, Chris Zaleski, Sonali Jha, Philippe Batut, Mark Chaisson, and Thomas R. Gingeras. Star: ultrafast universal rna-seq aligner. Bioinformatics, 29(1):15–21, 01 2013.`

## GATK reference
`Geraldine van der Auwera and Brian D O’Connor. Genomics in the cloud. O’Reilly Media, Sebastopol, CA, April 2020.`
