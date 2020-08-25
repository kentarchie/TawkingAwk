#!/usr/bin/gawk -f
@include "../lib/csv.awk" # from http://lorance.freeshell.org/csv/
@include "../lib/utilities.awk"

BEGIN { #run once before processing lines
	FS=",";
} # BEGIN

# first line are the titles
FNR == 1 {
	num_titles = csv_parse($0, titles, ",", "\"", "\"", "\\n", 1)

	if (num_titles < 0) {
		printf("ERROR: %d (%s) -> %s\n", num_titles, csv_err(num_fields), $0);
		exit;
	}
} # first line

FNR != 1 {
	if(NR % 100 == 0)
		printf("lines so far (%d)\n", NR);

	num_fields = csv_parse($0, csv, ",", "\"", "\"", "\\n", 0)
	if (num_fields < 0) {
		printf("ERROR: %d (%s) -> %s\n", num_fields, csv_err(num_fields), $0);
		continue;
	}

	for (t in titles)
		Data[titles[t]] = csv[t];
	printf("store=:%s:, date=:%s:, item=:%s:, price=:%s:, categories=:%s:\n", 
		Data["store"], Data["date"], Data["item"], Data["price"], Data["categories"]);
}

END   { # run once after processing lines
		printf("END: processed %d data points\n",NR);
}
