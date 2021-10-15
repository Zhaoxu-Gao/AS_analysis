die "perl $0 <info><OUT1><exon_num><OUT2>"unless(@ARGV==4);
my %hash1;
my $comm=0;
open IN1,"<$ARGV[0]"||die "$!";
open OT1,">$ARGV[1]"||die "$!";
while(<IN1>){
   chomp;
   my @aa=split /\t/;
   my @bb=split(/<=>/,$aa[1]);
   my $exon1=$bb[0];
   my $exon2=$bb[1];
   my $line=join("\t",@aa[2..$#aa]);
#trans_strand
   my $num=$aa[11];
   my $strand=$aa[13];
   if($strand=~/-/){
	   $exon1=$num-$exon1+1;
	   $exon2=$num-$exon2+1;
    }
   print OT1 "$aa[0]\t$exon1\t$exon2\t$line\n";
}
close IN1;
close OT1;
open IN2,"<$ARGV[2]"||die "$!";
open OT2,">$ARGV[3]"||die "$!";
while(<IN2>){
   chomp;
   my @cc=split /\s+/;
   my @dd=split(/\./,$cc[0]);
   my $index="$dd[0]-$cc[10]";
   #print "$index\n";
   $hash1{$index}="$cc[4]\t$cc[5]\t$cc[6]\t$cc[7]";
   #print "$hash1{$index}\n";
}
close IN2;
open IN3,"<$ARGV[1]"||die "$!";
while(<IN3>){
   chomp;
   my @ee=split /\t/;
   my $gene=$ee[0];
   my $line2=join("\t",@ee[0..$#ee]);
   my $temp1="$gene-$ee[1]";
   my $temp2="$gene-$ee[2]";
   #print "$temp2\n";
   if(exists $hash1{$temp1} && exists $hash1{$temp2}){
      print OT2 "$line2\t$hash1{$temp1}\t$hash1{$temp2}\n";
	  $comm++;
   }elsif(exists $hash1{$temp1}){
      print OT2 "$line2\t$hash1{$temp1}\t\t\t\t\n";
	  $comm2++;
   }elsif(exists $hash1{$temp2}){
      print OT2 "$line2\t\t\t\t\t$hash1{$temp2}\n";
      $comm3++;
   }else{
      print OT2 "$line2\n";
	  $comm4++;
   }
}
close IN3;
close OT2;
print "common\tcommon2\tcommon3\tcommon4\n$comm\t$comm2\t$comm3\t$comm4\n";
