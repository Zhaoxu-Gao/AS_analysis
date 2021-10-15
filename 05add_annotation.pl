#perl get_annotation.pl /sdc2/users/gaozhaoxu/00Reference/00Arabidopsis/TAIR10.cdna.info list out
die "Usage:perl $0 <ann> <list> <out>\n"unless @ARGV==3;
open IN1,"<$ARGV[0]"||die "$!";
open OT1,">$ARGV[2]"||die "$!";
my %hash;
my ($name,$ann);
while(<IN1>){
   chomp($_);
   @aa=split(/\t/,$_);
   $name=substr($aa[5],0,9);
   $ann=$aa[6];
   $hash{$name}=$ann;
   #print "$ann\n";
}
close IN1;
open IN2,"<$ARGV[1]"||die "$!";  
while(<IN2>){
   chomp($_);
   @bb=split(/\t/,$_);
   $gene=substr($bb[0],0,9);
   $line=join('*',@bb[0..$#bb]);
   #print "$line\n";
   if(exists $hash{$gene}){ 
     print OT1 "$line\t$hash{$gene}\n";
   }else{
     print OT1 "$line\t\n";
   }
}
close IN2;
close OT1;