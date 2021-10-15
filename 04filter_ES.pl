die "perl $0 <result><OUT1><OUT2>"unless(@ARGV==3);
open IN1,"<$ARGV[0]"||die "$!";
open OT1,">$ARGV[1]"||die "$!";
while(<IN1>){
  chomp;
  my @aa=split /\t/;
  my $exon1=$aa[3];
  my $exon2=$aa[4];
  my $line=join("\t",@aa[0..$#aa]);
  if($exon1>=10 || $exon2>=10){
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
  my $exon1=$bb[3];
  my $exon2=$bb[4];
  my $FC=$exon1/($exon2+0.001);
  my $line2=join("\t",@bb[0..$#bb]);
  if($FC>=1.5){
     print OT2 "$line2\n";
  }elsif($_=~/Gene/){
     print OT2 "$_\n";
  }
}
close IN2;
close OT2;
