die "perl $0 <info><OUT1><exon_num><OUT2>"unless(@ARGV==4);
my %hash1;
my $comm=0;
open IN1,"<$ARGV[0]"||die "$!";
open OT1,">$ARGV[1]"||die "$!";
while(<IN1>){
	chomp;
	my @aa=split /\t/;
	my @bb=split(/\(/,$aa[1]);
	my $exon1=$bb[0];
	my @cc=split(/\)/,$bb[1]);
	my $splice1=$cc[0];
	my $exon2=-$cc[1];
	my @dd=split(/\)/,$bb[2]);
	my $splice2=$dd[0];
#splice2
	my @ee=split(/\(/,$aa[3]);
	my $exon3=$ee[0];
	my @ff=split(/\)/,$ee[1]);
	my $splice3=$ff[0];
	my $exon4=-$ff[1];
	my @gg=split(/\)/,$ee[2]);
	my $splice4=$gg[0];
#trans_strand
    my $num=$aa[15];
    my $strand=$aa[17];
    if($strand=~/-/){
	   $exon1=$num-$exon1+1;
	   $exon2=$num-$exon2+1;
	   $exon3=$num-$exon3+1;
	   $exon4=$num-$exon4+1;
	}
	my $line=join("\t",@aa[4..$#aa]);
	print OT1 "$aa[0]\t$exon1\t$splice1\t$exon2\t$splice2\t$aa[2]\t$exon3\t$splice3\t$exon4\t$splice4\t$line\n";
}
close IN1;
close OT1;
open IN2,"<$ARGV[2]"||die "$!";
open OT2,">$ARGV[3]"||die "$!";
while(<IN2>){
	chomp;
	my @hh=split /\s+/;
	my @ii=split(/\./,$hh[0]);
	my $index="$ii[0]-$hh[10]";
	$hash1{$index}="$hh[4]\t$hh[5]\t$hh[6]\t$hh[7]";
	#print "$hash1{$index}\n";
}
close IN2;
open IN3,"<$ARGV[1]"||die "$!";
while(<IN3>){
    chomp;
    my @jj=split /\t/;
	my $gene=$jj[0];
	my $line=join("\t",@jj[0..$#jj]);
	my $temp1="$gene-$jj[1]";
	my $temp2="$gene-$jj[3]";
	my $temp3="$gene-$jj[6]";
	my $temp4="$gene-$jj[8]";
	#print "$gene\n";
	if(exists $hash1{$temp1} && exists $hash1{$temp2} && exists $hash1{$temp3} && exists $hash1{$temp4}){
	   print OT2 "$line\t$hash1{$temp1}\t$hash1{$temp2}\t$hash1{$temp3}\t$hash1{$temp4}\n";
	   $comm++;
	}elsif(exists $hash1{$temp1} && exists $hash1{$temp2} && exists $hash1{$temp3}){
	print OT2 "$line\t$hash1{$temp1}\t$hash1{$temp2}\t$hash1{$temp3}\t\t\t\t\t\n";
	   $comm2++;
	}elsif(exists $hash1{$temp1} && exists $hash1{$temp2} && exists $hash1{$temp4}){
	print OT2 "$line\t$hash1{$temp1}\t$hash1{$temp2}\t\t\t\t\t$hash1{$temp4}\n";
	   $comm3++;
	}elsif(exists $hash1{$temp1} && exists $hash1{$temp3} && exists $hash1{$temp4}){
	print OT2 "$line\t$hash1{$temp1}\t\t\t\t\t$hash1{$temp3}\t$hash1{$temp4}\n";
	   $comm4++;
	}elsif(exists $hash1{$temp2} && exists $hash1{$temp3} && exists $hash1{$temp4}){
	print OT2 "$line\t\t\t\t\t$hash1{$temp2}\t$hash1{$temp3}\t$hash1{$temp4}\n";
	   $comm5++;
	}elsif(exists $hash1{$temp1} && exists $hash1{$temp2}){
	print OT2 "$line\t$hash1{$temp1}\t$hash1{$temp2}\t\t\t\t\t\t\t\t\t\n";
	   $comm6++;
	}elsif(exists $hash1{$temp1} && exists $hash1{$temp3}){
	print OT2 "$line\t$hash1{$temp1}\t\t\t\t\t$hash1{$temp3}\t\t\t\t\n";
	   $comm7++;
	}elsif(exists $hash1{$temp1} && exists $hash1{$temp4}){
	print OT2 "$line\t$hash1{$temp1}\t\t\t\t\t\t\t\t\t$hash1{$temp4}\n";
	   $comm8++;
	}elsif(exists $hash1{$temp2} && exists $hash1{$temp3}){
	print OT2 "$line\t\t\t\t\t$hash1{$temp2}\t$hash1{$temp3}\t\t\t\t\t\n";
	   $comm9++;
	}elsif(exists $hash1{$temp2} && exists $hash1{$temp4}){
	print OT2 "$line\t\t\t\t\t$hash1{$temp2}\t\t\t\t\t$hash1{$temp4}\n";
	   $comm10++;
	}elsif(exists $hash1{$temp3} && exists $hash1{$temp4}){
	print OT2 "$line\t\t\t\t\t\t\t\t\t$hash1{$temp3}\t$hash1{$temp4}\n";
	   $comm11++;
	}elsif(exists $hash1{$temp1}){
	print OT2 "$line\t$hash1{$temp1}\t\t\t\t\t\t\t\t\t\t\t\t\t\n";
	   $comm12++;
	}elsif(exists $hash1{$temp2}){
	print OT2 "$line\t\t\t\t\t$hash1{$temp2}\t\t\t\t\t\t\t\t\t\n";
	   $comm13++;
	}elsif(exists $hash1{$temp3}){
	print OT2 "$line\t\t\t\t\t\t\t\t\t$hash1{$temp3}\t\t\t\t\n";
	   $comm14++;
	}elsif(exists $hash1{$temp4}){
	print OT2 "$line\t\t\t\t\t\t\t\t\t\t\t\t\t$hash1{$temp4}\n";
	   $comm15++;
	}else{
	print OT2 "$line\n";
	   $comm16++;
	}
}
close IN3;
close OT2;
print "common\tcommon2\tcommon3\tcommon4\tcommon5\tcommon6\tcommon7\tcommon8\tcommon9\tcommon10\tcommon11\tcommon12\tcommon13\tcommon14\tcommon15\tcommon16\n$comm\t$comm2\t$comm3\t$comm4\t$comm5\t$comm6\t$comm7\t$comm8\t$comm9\t$comm10\t$comm11\t$comm12\t$comm13\t$comm14\t$comm15\t$comm16\n";
