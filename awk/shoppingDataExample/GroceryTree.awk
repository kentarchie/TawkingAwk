#!/usr/bin/gawk -f
@include "../lib/csv.awk" # from http://lorance.freeshell.org/csv/
@include "../lib/utilities.awk"

function totalMaker(arr, name,      i)
{
    for (i in arr) {
        if (isarray(arr[i]))
            totalMaker(arr[i], (name "[" i "]"))
        else
            printf("%s[%s] = %s\n", name, i, arr[i])
    }
} # totalMaker

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
		printf("Lines: lines so far (%d)\n", NR);

	num_fields = csv_parse($0, csv, ",", "\"", "\"", "\\n", 0)
	if (num_fields < 0) {
		printf("ERROR: %d (%s) -> %s\n", num_fields, csv_err(num_fields), $0);
		continue;
	}

# this will let us address data by column name
	for (t in titles) thisRow[titles[t]] = csv[t];

	thisStore = thisRow["store"];
	thisDate  = thisRow["date"];
	#printf("Lines: store=:%s:, date=:%s:, item=:%s:, price=:%s:, categories=:%s:\n", 
	#	thisRow["store"], thisRow["date"], thisRow["item"], thisRow["price"], thisRow["categories"])

	if(!isarray(TreeData[thisStore][thisDate][1])) {
		#printf("TreeData[%s][%s][1] is NOT an array\n",thisStore,thisDate);
		split("",TreeData[thisStore][thisDate]); # weird idiom for empty array
	}
	newRecord= length(TreeData[thisStore][thisDate])+1

	#printf("Lines: newRecord (%d)\n", newRecord);
	TreeData[thisStore][thisDate][newRecord]["item"]  = thisRow["item"];
	TreeData[thisStore][thisDate][newRecord]["price"]  = thisRow["price"];
	TreeData[thisStore][thisDate][newRecord]["categories"]  = thisRow["categories"];
}

END   { # run once after processing lines
		#walk_array(TreeData, "TreeData")
		for (s in TreeData) 
			for (d in TreeData[s]) 
				for (r in TreeData[s][d]) {
					#printf("index=:%d:, store=:%s:\n", r, TreeDatas][d][r]["store"]);
					totals[s] += TreeData[s][d][r]["price"];
				}
		#walk_array(totals, "totals")
		walk_array(totals, "totals");
		printf("END: processed %d data points\n",NR);
}
