# clade8
_In silico_ identification of the clade-8 specific SNP from _E. coli_ O157.

## Introduction

In a 2008 study, 528 _Escherichia coli_ O157 isolates were classified into nine clades using a panel of 48 SNP loci. Isolates from patients with hemolytic uremic syndrome (HUS) frequently belonged to clade 8 (Manning, Motiwala et al. 2008). This association was subsequently corroborated by independent studies (Iyoda, Manning et al. 2014; Soderlund, Jernberg et al. 2014; Tarr, Shringi et al. 2018), although the underlying mechanism remains not fully understood.

To facilitate the study of _E. coli_ O157 strains, I developed this tool to identify clade-8–specific SNPs from whole-genome sequences. The program is based on a PCR assay detecting the SNP C539A in ECs2357 of strain Sakai, which is unique to clade 8 (Iyoda, Manning et al. 2014).

## Prerequisite
Before start, you need to make sure the following program is fully functional in your system:
   * [BLAST+](https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/)

## Usage
First one would need to generate a list of WGS assembly files to be analyzed, e.g.

    ls *.fasta >list.fasta.txt

Then one could put `clade8.pl`, `list.fasta.txt` alongside the WGS assemblies files, and run command like:

    perl clade8.pl list.fasta.txt

The program will start to work and write the result into a report file `list.fasta.xls` in the same directory.

## Citation
[_Comparative Genomics of Shiga Toxin-Producing Escherichia coli Strains Isolated from Pediatric Patients with and without Hemolytic Uremic Syndrome from 2000 to 2016 in Finland_](https://journals.asm.org/doi/full/10.1128/spectrum.00660-22)
