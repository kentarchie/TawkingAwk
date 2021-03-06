ls -l | gawk '
# get the extension part of a file name
function getExtension(file) 
{
   n = split(file, a, "."); # split the file name into parts
   return(a[n]);  # last element of the array
} # getExtension

BEGIN { 
	print "File\tType";
}

/^-/ { 
	type = getExtension($9);
	types[type] += 1;
}

END { 
	for (t in types) {
		printf("%s\t%d\n", t,types[t]);
	}
	print " - DONE -" 
}
'
