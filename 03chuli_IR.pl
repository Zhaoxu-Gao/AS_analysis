die "perl $0 <info><OUT1><intron_num><OUT2>"unless(@ARGV==4);
my %hash1;
my $comm=0;
open IN1,"<$ARGV[0]"||die "$!";
open OT1,">$ARGV[1]"||die "$!";
while(<IN1>){
   chomp;
   my @aa=split /\t/;
   my $gene=$aa[0];
   my $intron=$aa[1];
#trans_strand
   my $num=$aa[15];
   my $strand=$aa[17];
   if($strand=~/-/){
      $intron=$num-$intron+1;   
   }
   my $line=join("\t",@aa[2..$#aa]);
   print OT1 "$aa[0]\t$intron\t$line\n";
}
close IN1;
close OT1;
open IN2,"<$ARGV[2]"||die "$!";
open OT2,">$ARGV[3]"||die "$!";
while(<IN2>){
   chomp;
   my @bb=split /\s+/;
   my @cc=split(/\./,$bb[0]);
   my $index="$cc[0]-$bb[10]";
   #print "$index\n";
   $hash1{$index}="$bb[4]\t$bb[5]\t$bb[6]\t$bb[7]";  
}
close IN2;
open IN3,"<$ARGV[1]"||die "$!";
while(<IN3>){
   chomp;
   my @dd=split /\t/;
   my $gene=$dd[0];
   my $line2=join("\t",@dd[0..$#dd]);
   my $temp="$gene-$dd[1]";
   if(exists $hash1{$temp}){
      print OT2 "$line2\t$hash1{$temp}\n";
      $comm++;  
   }else{
      print OT2 "$line2\n";
	  $comm2++;
   }
}
close IN3;
close OT2;
print "common\tcommon2\n$comm\t$comm2\n";
