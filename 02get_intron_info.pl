#perl 02get_exon_info.pl intron-info-num.txt ../00file_result/ABA_EtOH_0-5H.SSIR.xls ABA_EtOH_0-5H.SSIR.info.xls
die "perl $0 <intron_info><AS><OUT>"unless(@ARGV==3);
my %hash1;
my $comm=0;
open IN1,"<$ARGV[0]"||die "$!";
open OT,">$ARGV[2]"||die "$!";
while(<IN1>){
	chomp;
	my @aa=split /\s+/;
	my @cc=split(/\./,$aa[0]);
	$hash1{$cc[0]}="$aa[0]\t$aa[1]\t$aa[2]\t$aa[3]";
	#print "$hash1{$cc[0]}\n";
}
close IN1;
open IN2,"<$ARGV[1]"||die "$!";
while(<IN2>){
    chomp;
    my @bb=split /\t/;
	my $gene=$bb[0];
	my $line=join("\t",@bb[0..$#bb]);
	#print "$gene\n";
	if(exists $hash1{$gene}){
	   print OT "$line\t$hash1{$gene}\n";
	   $comm++;
	}else{
	print OT "$line\n";
	   $unpair++;
	}
}
close IN2;
close OT;
print "common\tunpair\n$comm\t$unpair\n";