#!usr/bin/perl -w -s 
@ARGV=<*.SSDA.info.xls>;
foreach(@ARGV)
{
	if(/(.*)\.SSDA.info.xls/)
	{
		system "perl 03chuli_DA.pl $_ $1.SSDA.info.out1 exon-info-num.txt $1.SSDA.info.out2 &"
	}
}
######
@ARGV=<*.SSES.info.xls>;
foreach(@ARGV)
{
	if(/(.*)\.SSES.info.xls/)
	{
		system "perl 03chuli_ES.pl $_ $1.SSES.info.out1 exon-info-num.txt $1.SSES.info.out2 &"
	}
}
######
@ARGV=<*.SSIR.info.xls>;
foreach(@ARGV)
{
	if(/(.*)\.SSIR.info.xls/)
	{
		system "perl 03chuli_IR.pl $_ $1.SSIR.info.out1 intron-info-num.txt $1.SSIR.info.out2 &"
	}
}