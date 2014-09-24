#!/usr/bin/env perl       

use strict;
use warnings;
use Bio::DB::EUtilities;


#	1.get	PID
#	2.get	geneID
#	3.get	genesummary

if(@ARGV < 2){ print "\n USAGE :\n $0 \t infile(fasta) outfile(gene coordinate)\n"; exit;}

my$infile=$ARGV[0];
my$outfile=$ARGV[1];

#1

open(FH,$infile) or die "\n $infile not found \n";
my@cont=<FH>;
close(FH);

my@PIDs;

#open(FH,">".$outfile)or die "\n $outfile cannot write \n";;
foreach my$line(@cont){
	
	if($line=~/^>.*?\|(.*?)\|/){    #collecting PIDs from fasta header
		#print FH $1,"\n";
		push(@PIDs,$1);
		}
	}
#close(FH);

#print "@PIDs";


#2
print "\n ID conversion...\n";
my@GIDs;
connect_get_gids(@PIDs);
print scalar @GIDs;


#3
print "\n Getting gene coordinates...\n";

open(FH,">>".$outfile);
my@word=split('/',$infile);

print FH $word[$#word],"\n";
connect_get_sum(@GIDs);
close(FH);

exit;

sub connect_get_sum{    
	
    my @ids =@_;
   
	my $eutil   = Bio::DB::EUtilities->new(-eutil => 'esummary',
                                       -email => 'minesh.1291@gmail.com',
                                       -db    => 'gene',
                                       -id    => \@ids);

	while (my $docsum = $eutil->next_DocSum) {
		
		my ($item) = $docsum->get_Items_by_name('GenomicInfoType');
			next unless $item;
 
		my ($acc, $start, $end) = ($item->get_contents_by_name('ChrAccVer'),
                               $item->get_contents_by_name('ChrStart'),
                               $item->get_contents_by_name('ChrStop'));
 
		my $strand = $start > $end ? 2 : 1;

		print FH "$acc \t$start \t$end \t$strand \n";

		}

}


sub connect_get_gids{    

    my @uids =@_;

my$factory= Bio::DB::EUtilities->new(-eutil => 'elink',
                           -db    => 'gene',
                           -dbfrom => 'protein',
                           -id     => \@uids,
                           );

while (my $ds = $factory->next_LinkSet) {
    push(@GIDs,$ds->get_ids);
}

}



