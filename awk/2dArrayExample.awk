BEGIN {
	FS=","
	row = 1;
}

{
	data[row][1] = $1;
	data[row++][2] = $2;
}

END {
	print("\nlooping print\n");
	for( i in data)
		for( j in data[i])
			printf("data[%d][%d] = :%5.1f\n",
    			i,j,data[i][j]);
}
