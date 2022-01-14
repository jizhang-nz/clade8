#!/usr/bin/env perl
#Copy (C) DSS, Biosecurity New Zealand, MPI
#Written by Ji Zhang, MD PhD

#Function
#In silico identification of the clade-8 specific SNP from E. coli O157
#It is based on that the clade 8-specific SNP found in the ECs2357 gene (open reading frame number of E coli O157:H7 Sakai strain [accession no. BA000007.2]) was C539A.

#Revision notes
#version: 1.0.0
#Created at 14.1.2022

#Options: 
#perl clade8.pl list.genome.txt


use strict;
my $list = $ARGV[0];
################### 
foreach(<IN>){
	chomp;
	my @bases = split("", $_);
	foreach(@bases){
		print OUT "\t$_";
	}
	print OUT "\n";
}
close IN;
close OUT;
################### 
open(OUT, ">ECs2357.temp");
print OUT ">ECs2357\natgaacaaacacaccgaacatgatactcgcgaacatctcctggcgacgggcgagcaactttgcctgcaacgtggattcaccgggatggggctaagcgaattactaaaaaccgctgaagtgccgaaagggtccttctatcactactttcgctctaaagaagcgtttggcgttgccatgcttgagcgccattacgccacatatcaccaacgactgactgagttgctgcaatccggcgaaggtaactaccgcgaccgcatactggcttattaccagcaaacactgaaccagttttgccaacatggaaccatcagtggttgcctgacagtaaaactctctgccgaagtgtgcgatctgtcagaagatatgcgtagcgcgatggataaaggcgctcgcggcgtgatcgccctgctctcgcaggctctggaaaatggccgtgatagccattgtttaaccttttgtggcgaaccgctgcaacaggcacaagtgctttacgcactatggctgggtgcgaatctgcaggccaaaatttcgcgcaattccgagccactggaaaacgcgctggcacatgtaaaaaccattattgcgacgcctgccgtttag\n";
#rc
#print OUT ">ECs2357\nctaaacggcaggcgtcgcaataatggtttttacatgtgccagcgcgttttccagtggctcggaattgcgcgaaattttggcctgcagattcgcacccagccatagtgcgtaaagcacttgtgcctgttgcagcggttcgccacaaaaggttaaacaatggctatcacggccattttccagagcctgcgagagcagggcgatcacgccgcgagcgcctttatccatcgcgctacgcatatcttctgacagatcgcacacttcggcagagagttttactgtcaggcaaccactgatggttccatgttggcaaaactggttcagtgtttgctggtaataagccagtatgcggtcgcggtagttaccttcgccggattgcagcaactcagtcagtcgttggtgatatgtggcgtaatggcgctcaagcatggcaacgccaaacgcttctttagagcgaaagtagtgatagaaggaccctttcggcacttcagcggtttttagtaattcgcttagccccatcccggtgaatccacgttgcaggcaaagttgctcgcccgtcgccaggagatgttcgcgagtatcatgttcggtgtgtttgttcat\n";

close OUT;
###################
my ($genome, $seq, $counter, $spacer);
open(LIST, "<$list");
my $basename = $list;
$basename =~ s/\..*//g;
open(REPORT, ">$basename.xls");
print REPORT "genome\tECs2357_539_Sakai\tECs2357_539_test\tclade\n";
while(<LIST>){
	chomp;
	$genome = $_;
	open(SEQIN, "<$genome") or die "Cannot open genome sequence $genome!";
	print("concatinating $genome ...\n");
	open(OUT, ">>$genome.combined.tmp");
	$/=">";
	print OUT ">", "$genome\n";
	my $seq_genome;
	while(<SEQIN>){
		$spacer = "NNNNNNNNNNNNNNNNNNNN";
		$counter = 0;
		if($_ =~ /^>/){
			next;
		}else{
			my $seq = $_;
			$seq =~ s/.*\n//;
			$seq =~ s/>//;
			$seq =~ s/\s//g;
			$seq =~ s/N/n/g;
			print OUT "$seq", "\n$spacer\n";
			$seq_genome = "$seq_genome"."$seq"."$spacer";
		}
	}
	close OUT;
	close SEQIN;
	$/="\n";
	system("makeblastdb -in $genome.combined.tmp -dbtype nucl -logfile makeblastdb.tmp");
	my @blastn = readpipe("blastn -db $genome.combined.tmp -query ECs2357.temp -num_threads 4 -outfmt 6");
	open (BLAST, ">>blast.tmp");
	unless(@blastn){
		print "$genome:\t no hit\n";
		print REPORT "$genome\tno hit\n";
	}else{
		my $strand = "PLUS";
		foreach(@blastn){
			chomp;
			print BLAST "$_\n";
			my @inline = split (/\t/, $_);
			my $identity = $inline[2];
			my $q_start = $inline[6];
			my $q_end = $inline[7];
			my $s_start = $inline[8];
			my $s_end = $inline[9];
			if($s_start > $s_end){
				$strand = "MINUS";
			}
			my $q_len = abs($q_end - $q_start) + 1;
			my $allele_len = 600;
			my $coverage_q = $q_len/$allele_len*100;
			if($coverage_q eq 100 && $identity eq 100){
				print "$genome:\tC\tC\tclade unknown\n";
				print REPORT "$genome\tC\tC\tclade unknown\n";
				last;
			}elsif($coverage_q <= 0 && $identity <= 80){
				print "$genome:\t no hit\n";
				print REPORT "$genome\tno hit\n";
				last;
			}else{
				if($strand eq "MINUS"){
					$seq_genome = reverse($seq_genome);
					$seq_genome =~ tr/ABCDGHMNRSTUVWXYabcdghmnrstuvwxy/TVGHCDKNYSAABWXRtvghcdknysaabwxr/;
					open(OUT, ">$genome.combined.tmp");
					print OUT ">$genome.rc\n$seq_genome\n";
					close OUT;
					system("makeblastdb -in $genome.combined.tmp -dbtype nucl -logfile makeblastdb.tmp");
				}

				my $open = "NO";
				my ($ref_start, $ref_end, $ref_539);
				my @blastn = readpipe("blastn -db $genome.combined.tmp -query ECs2357.temp -num_threads 4 -outfmt 4");
				foreach(@blastn){
					chomp;
					print BLAST "$_\n";
					my $inline = $_;
					if($inline =~ m/^Query_1 /){
						$ref_start = $_;
						$ref_end = $_;
						$ref_start =~ s/Query_1 +//;
						$ref_start =~ s/ .*//g;
						$ref_end =~ s/.* //g;
						if($ref_start < 539 && $ref_end >= 539){
							$open = "YES";
							$ref_539 = 539 - $ref_start + 1;
						}
						next;
					}
					if($open eq "YES"){
						my $hit_start = $inline;
						my $hit_end = $inline;
						$hit_start =~ s/^0 +//;
						$hit_start =~ s/ .*//g;
						$hit_end =~ s/.* //g;
						my $hit_539 = $hit_start + $ref_539 - 1;
						my $extract_start = $hit_539 - 1;
						my $base_539 = substr $seq_genome, $extract_start, 1;
						if($base_539 =~ m/a/i){
							print "$genome:\tC\t$base_539\tclade8-associated SNP exists\n";
							print REPORT "$genome\tC\t$base_539\tclade8-associated SNP exists\n";
						}else{
							print "$genome:\tC\t$base_539\tclade unknown\n";
							print REPORT "$genome\tC\tC\tclade unknown\n";
						}
						last;
					}
				}
				if($open eq "NO"){
					print "$genome:\t no hit\n";
					print REPORT "$genome\tno hit\n";
				}
			}
		}
	}
	system("rm -f *.tmp");
	system("rm -f *.tmp.*");
}
close LIST;
system("rm -f ECs2357.temp");








