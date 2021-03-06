#!/usr/bin/gawk -f
@include "../lib/csv.awk" # from http://lorance.freeshell.org/csv/
@include "../lib/utilities.awk"

BEGIN { #run once before processing lines
	FS=",";
} # BEGIN

FNR == 1 {next}   # skip first line

{
	if(NR % 100 == 0) printf("Lines so far (%d)\n", NR);

	num_fields = csv_parse($0, csv, ",", "\"", "\"", "\\n", 0)
	if (num_fields < 0) {
		printf("ERROR: %d (%s) -> %s\n", num_fields, csv_err(num_fields), $0);
		continue;
	}

	printf("Lines: store=:%s:, date=:%s:, item=:%s:, price=:%s:, label=:%s:\n", 
		csv[1], csv[2], csv[3], csv[4], csv[5]);
} # for each line

END   { # run once after processing lines
		printf("END: processed %d data points\n",NR);
} # END
