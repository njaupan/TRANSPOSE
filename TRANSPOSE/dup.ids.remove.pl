use strict;
use Bio::SeqIO;
my %unique;

my $file   = shift;
my $seqio  = Bio::SeqIO->new(-file => $file, -format => "fasta");
my $outseq = Bio::SeqIO->new(-file => ">$file.uniq", -format => "fasta");

while(my $seqs = $seqio->next_seq) {
  my $id  = $seqs->display_id;
  my $seq = $seqs->seq;
  unless(exists($unique{$id})) {
    $outseq->write_seq($seqs);
    $unique{$id} +=1;
  }
}

