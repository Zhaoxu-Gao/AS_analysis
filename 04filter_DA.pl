die "perl $0 <result><OUT1><OUT2>"unless(@ARGV==3);
open IN1,"<$ARGV[0]"||die "$!";
open OT1,">$ARGV[1]"||die "$!";
while(<IN1>){
  chomp;
  my @aa=split /\t/;
  my $splice1=$aa[12];
  my $splice2=$aa[13];
  my $splice3=$aa[14];
  my $splice4=$aa[15];
  my $line=join("\t",@aa[0..$#aa]);
  if($splice1>=10 || $splice2>=10 || $splice3>=10 || $splice4>=10){
     print OT1 "$line\n";  
  }elsif($_=~/Gene/){
     print OT1 "$_\n";
  } 
}
close IN1;
close OT1;
open IN2,"<$ARGV[1]"||die "$!";
open OT2,">$ARGV[2]"||die "$!";
while(<IN2>){
  chomp;
  my @bb=split /\t/;
  my $Pvalue=$bb[16];
  my $line2=join("\t",@bb[0..$#bb]);
  if($Pvalue<=0.05){
     print OT2 "$line2\n";
  }elsif($_=~/Gene/){
     print OT2 "$_\n";
  }
}
close IN2;
close OT2;
