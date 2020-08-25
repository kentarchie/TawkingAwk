gawk '
BEGIN { 
	arr[5] = 5;
	arr[1] = 1;
	arr[6] = 6;
	arr["six"] = "six";
	for(i in arr) print i, arr[i];
}
'
