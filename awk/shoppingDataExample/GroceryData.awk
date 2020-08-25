#!/usr/bin/gawk -f
@include ../lib/"csv.awk" # from http://lorance.freeshell.org/csv/

function push(A,B) { A[length(A)+1] = B }

function walk_array(arr, name,      i)
{
    for (i in arr) {
        if (isarray(arr[i]))
            walk_array(arr[i], (name "[" i "]"))
        else
            printf("%s[%s] = %s\n", name, i, arr[i])
    }
} # walk_array

BEGIN { #run once before processing lines
	FS=",";
	STORE_POS = 1;
	DATE_POS = 2;
	ITEM_POS = 3;
	PRICE_POS = 4;
	LABEL_POS = 5;
		  
#Data["-"]["-"]["item"]="";
} # BEGIN

FNR == 1 {next}   # skip first line

{
	if(NR % 100 == 0)
		printf("Lines: lines so far (%d)\n", NR);

	num_fields = csv_parse($0, csv, ",", "\"", "\"", "\\n", 0)
	if (num_fields < 0) {
		printf("ERROR: %d (%s) -> %s\n", num_fields, csv_err(num_fields), $0);
		continue;
	}

	thisStore = csv[STORE_POS];
	thisDate  = csv[DATE_POS];
	thisItem  = csv[ITEM_POS];
	thisPrice = csv[PRICE_POS];
	thisLabel = csv[LABEL_POS];
	#printf("Lines: store=:%s:, date=:%s:, item=:%s:, price=:%s:, label=:%s:\n", thisStore, thisDate, thisItem, thisPrice, thisLabel)


	if(!isarray(Data[thisStore][thisDate][1])) {
		printf("Data[%s][%s][1] is NOT an array\n",thisStore,thisDate);
		split("",Data[thisStore][thisDate]); # weird idion for empty array
	}
	newRecord= length(Data[thisStore][thisDate])+1

	#printf("Lines: newRecord (%d)\n", newRecord);
	Data[thisStore][thisDate][newRecord]["item"]  = thisItem;
	Data[thisStore][thisDate][newRecord]["price"]  = thisPrice;
	Data[thisStore][thisDate][newRecord]["label"]  = thisLabel;
}

END   { # run once after processing lines
		walk_array(Data, "Data",      i)
		printf("END: processed %d data points\n",NR);
}
