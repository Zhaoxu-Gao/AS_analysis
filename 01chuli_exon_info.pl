#perl 01chuli_exon_info.pl exon-num-strand.out exon.info exon-info-num.txt
die "perl $0 <exon_num><transcript><OUT>"unless(@ARGV==3);
my %hash1;
my $comm=0;
open IN1,"<$ARGV[0]"||die "$!";
open OT,">$ARGV[2]"||die "$!";
while(<IN1>){
	chomp;
	my @aa=split /\t/;
	$hash1{$aa[1]}=$_;
}
close IN1;
open IN2,"<$ARGV[1]"||die "$!";
while(<IN2>){
    chomp;
    my @bb=split /\t/;
	my @cc=split(/\./,$bb[5]);
	my $gene=$cc[0];
	my @dd=split(/-/,$bb[6]);
	my $exon=$dd[1];
	my $line="$bb[5]-$exon";
	#print "$line\n";
	if(exists $hash1{$bb[5]}){
	   print OT "$bb[5]\t$hash1{$bb[5]}\t$bb[0]\t$bb[1]\t$bb[2]\t$bb[3]\t$bb[4]\t$line\t$bb[5]\t$gene\t$exon\n";
	   $comm++;
	}else{
		$unpair++;
	}
}
close IN2;
close OT;
print "common\tunpair\n$comm\t$unpair\n";
