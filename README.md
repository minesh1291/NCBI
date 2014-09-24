NCBI
====

NCBI API

This is a perl script to get gene coordinate from given protein fasta file.

Requirements
===========

1.  Perl
2.  EUtilities package of BioPerl

To Run
======

perl GENE_Co_NCBI.pl input_AA_fasta output_file

Output Format
=============

Tab-delimited file

column 1 : Genome Accession 
column 2 : Gene start coordinate
column 3 : Gene end coordinate
column 4 : strand no. on which gene is located ( 1 for positive, 2 for negative)

Help
====
contact: minesh.1291@gmail.com
