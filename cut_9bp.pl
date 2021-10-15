die "usage: perl $0 <in.fq><out.fq>\n" unless (@ARGV==2);
open IN,"<$ARGV[0]"||die "$!";
open OUT,">$ARGV[1]"||die "$!";

while($name=<IN>){
    $seq=<IN>;
    $third=<IN>;
    $q=<IN>;
    chomp($name);
    chomp($seq);
    chomp($third);
    chomp($q);
    $new_seq = substr($seq,9,142);
    $new_q = substr($q,9,142);
    print OUT "$name\n$new_seq\n$third\n$new_q\n";
} 