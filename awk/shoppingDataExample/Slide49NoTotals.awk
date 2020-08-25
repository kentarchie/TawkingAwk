#!/usr/bin/gawk -f
@include "../lib/csv.awk" # from http://lorance.freeshell.org/csv/
@include "../lib/utilities.awk"

BEGIN { #run once before processing lines
	FS=",";
	split("",Data); # weird idiom for empty array
	recordCount = 1;
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

	for (t in titles) {
		Data[recordCount][titles[t]] = csv[t];
	}
	#printf("store=:%s:, date=:%s:, item=:%s:, price=:%s:, categories=:%s:\n", 
	#	Data[recordCount]["store"], Data[recordCount]["date"], Data[recordCount]["item"], Data[recordCount]["price"], Data[recordCount]["categories"]);
	recordCount++;
}

END   { # run once after processing lines
		#walk_array(Data, "Data", i);
		printf("END: processed %d data points\n",NR);
}
