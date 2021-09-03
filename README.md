# TRANSPOSE
Transposable elements annotation for large genomes

perl '/media/panpan/P2/TEanno_sensi/Moaine.Tutoriel/TRANSPOSE/transpose.v1.0.pl' -h


TE_grab

usage: perl transpose.v1.0.pl  -genome genome.fasta -TEprot name of TE protein fasta file 



	-genome        (mandatory)
	 		   	  reference genome sequence in fasta format
		
	-TEprot       (mandatory)
			  	  TE protein sequences in fasta format (single or multiple)

	-cpu          (optional)
				  minimum number of threads used for mapping and blast (default : -cpu 8)

	-h --help
				  print this menu


WARNING : reference genome, TEprot fasta are required. Please type : 'perl transpose.v1.0.pl -h' for help 
