#!/usr/bin/perl
use IO::Handle;
STDOUT->autoflush(1);
$inputFile = '<should parameterise this but havent yet>';
$outputFile = 'postgres.sql';

open(PGDUMP,$inputFile) or die("Could not open file: $inputFile");
#You'll need perl 5.6 or later to do file handles this way
open $filehandle,">",$outputFile or die("Couldn't open the output file : $1");

while($line = <PGDUMP>)
{
        #look for the /connect line in the file to trigger new files
	if($line =~ m/\\connect\s+\"*(\w+)\"*/ )
	{
		$outputFile = "$1.sql";	
		close $filehandle;
		open $filehandle,">",$outputFile or die("Couldn't open the output file : $outputFile");
		print "$line - using database name $1\n";
	}
	print $filehandle $line;	
}
close $filehandle;
