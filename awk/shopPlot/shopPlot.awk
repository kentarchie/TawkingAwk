#!/usr/bin/gawk -f
@include "../lib/csv.awk" # from http://lorance.freeshell.org/csv/
@include "../lib/utilities.awk"

BEGIN { #run once before processing lines
 	FS=",";
} # BEGIN

FNR == 1 {next} # skip first line

FNR != 1 {
 if(NR % 100 == 0) printf("Lines so far (%d)\n", NR);
 
 num_fields = csv_parse($0, csv, ",", "\"", "\"", "\\n", 0)
 if (num_fields < 0) {
 	printf("ERROR: %d (%s) -> %s\n", num_fields, csv_err(num_fields), $0);
 	continue;
 }
 totals[csv[1]] += csv[4];
 
 } # for each line
 
 END { # run once after processing lines
 	walk_array(totals, "totals", I);
 	printf("END: processed %d data points\n",NR);

	system("rm -f shopPlot.dat");

	printf("Store\tTotal\n") > "shopPlot.dat"

	for(t in totals) {
		printf("\"%s\" %f\n",t,totals[t]) >> "shopPlot.dat"
	}

	system("gnuplot -c testPlot.txt 2>&1");
 } # END
