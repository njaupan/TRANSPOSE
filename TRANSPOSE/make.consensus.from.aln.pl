#!/usr/bin/perl 
use strict;
use warnings;
use Bio::SearchIO;
use Bio::DB::Fasta;
use Bio::PrimarySeq;
use Bio::SeqIO;
use Bio::AlignIO;
use List::Util qw/shuffle/;
use Statistics::Descriptive;

my $sequence;
my $id;
my $file=shift;
my $per=shift;

open (CON, ">$file.con");
my  $str = Bio::AlignIO->new(-file => "$file", -format => 'fasta');
my  $aln = $str->next_aln();
print CON ">$file\n"; 
print CON $aln->consensus_string($per); 
print CON "\n";
