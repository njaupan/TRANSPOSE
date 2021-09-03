#!/usr/bin/perl 
## WARNING YOU NEED TIGR_rrna_gene.centroid_FAM000025.fasta.con file
use strict;
use warnings;
use Bio::SearchIO;
use Bio::DB::Fasta;
use Bio::PrimarySeq;
use Bio::SeqIO;
my $sequence;
my $id;
my $reference=shift;
my @files=shift;

foreach my $file (@files){
my $retro_sens  = Bio::SeqIO->new(-file => ">$file.sens", -format => "fasta");
chomp($file);
# Open the retro fasta files and write each elements in an independant file
my $seqio_obj = Bio::SeqIO->new(-file => "$file", -format => "Fasta" );
#my $copy_number=qx(grep -c ">" $file);
#chomp($copy_number);
 # if ($copy_number>1){
        # Get the first retro from the multifasta file#
        system("makeblastdb -in  $reference -dbtype nucl");
        #Blast each genomic copy against the first sequence and correct the sens
        while(my $seq = $seqio_obj->next_seq()) {
	my $id = $seq->display_id;
        my $sequence = $seq->seq ; 
        my $retro_fasta = Bio::PrimarySeq->new (-id => $id, -seq => $sequence);
	my $outseq  = Bio::SeqIO->new(-file => ">retro.fasta", -format => "fasta");
	$outseq ->write_seq($retro_fasta);
       # Blast the files against TE family copy good sens

       system("blastn -task blastn -num_threads 12 -db $reference -query retro.fasta -out retro.bl -evalue 1e-50");
       # parse the blast reslut
        my $hitfound=qx(grep "No hits found" retro.bl);
      next if ($hitfound ne '');
  	my $blast_io = Bio::SearchIO->new(-file => "retro.bl", -format => 'blast');
    	 my $result = $blast_io->next_result; 
          my $hit = $result->next_hit;
           my $hsp = $hit->next_hsp;
            my $strand = $hsp->	strand('hit');
              if ($strand eq "-1") {
               my $revseq = reverse $sequence;   
               $revseq =~ tr/ACGTacgt/TGCAtgca/;           
               my $retro_fasta2 = Bio::PrimarySeq->new (-id => $id,-seq => $revseq);
               # my $outseq2  = Bio::SeqIO->new(-file => ">$id.fasta", -format => "fasta");
               $retro_sens ->write_seq($retro_fasta2);
               }
               else {
               my $retro_fasta2 = Bio::PrimarySeq->new (-id => $id, -seq => $sequence);
               #my $outseq2  = Bio::SeqIO->new(-file => ">$id.fasta", -format => "fasta");
	       $retro_sens ->write_seq($retro_fasta2);
	       }
        system("rm retro.bl");
        }
#  }
  #else{
  #system("cp $file /data/moaine/Methyl_Spread/sens/$name");
  #}
}#foreach
