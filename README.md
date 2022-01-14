# clade8
_In silico_ identification of the clade-8 specific SNP from E. coli O157

## Introduction

In a study published in 2008, 528 of _Escherichia coli_ O157 strains were into divided into nine clades according to a panel 48 SNP loci. Strains that isolated from patients  of Hemolytic Uremic Syndrome (HUS) were found frequently belonging to the clade-8 (Manning, Motiwala et al. 2008). 

This correlation were confirmed later in a few independent studies (Iyoda, Manning et al. 2014, Soderlund, Jernberg et al. 2014, Tarr, Shringi et al. 2018), although the nature of the correlation have not been completely understood.

To facilitate the study of _E. coli_ O157 strain, I developed this tool to identify _in silico_ clade-8 specific SNP (ECs2357, C539A) from the WGS assembly of a _E. coli_ O157:H7 strain.

## Prerequisite
Before start, you need to make sure the following three programs were full functional in your system:
   * [BLAST+](https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/)

## Usage
First one would want to generate a list of WGS assemblies files, e.g.

    ls *.fasta >list.fasta.txt

Then one could put `clade8.pl`, `list.fasta.txt` and the other WGS assemblies files into the same folder, and run command like:

    perl clade8.pl list.fasta.txt

The program will start to work and generate a report (`list.fasta.xls`) in the same folder.

## Citation
_to be completed_


