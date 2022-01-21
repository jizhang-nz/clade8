# clade8
_In silico_ identification of the clade-8 specific SNP from _E. coli_ O157.

## Introduction

In a study published in 2008, 528 of _Escherichia coli_ O157 strains were divided into nine clades according to a panel of 48 SNP loci. Strains that were isolated from patients suffering from Hemolytic Uremic Syndrome (HUS) were found frequently belonging to the clade-8 (Manning, Motiwala et al. 2008). 

This correlation was confirmed later in a few independent studies (Iyoda, Manning et al. 2014, Soderlund, Jernberg et al. 2014, Tarr, Shringi et al. 2018), although the nature of the phenomenon has not been completely understood.

To facilitate the study of _E. coli_ O157 strains, I developed this tool to identify _in silico_ clade-8 strains by analizing WGS data.

The program is based on a PCR assay to detect a SNP (C539A at ECs2357 in strain Sakai) that is unique to clade-8 strains (Iyoda, Manning et al. 2014).

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
_Comparative Genomics of Shiga Toxin-Producing Escherichia coli (STEC) strains from Pediatric Patients with and without Haemolytic Uremic Syndrome (HUS)_
