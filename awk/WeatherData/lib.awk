#!/usr/bin/awk -f

# cut out the year section from the file path
# ../data/WeatherData/1939/10320099999
function getYear(fileName)
{
	split(fileName,parts,"/");
	year =  parts[length(parts) - 1]
   #printf("getYear: \tyear = :%s:\n", year);
	return year;
} # getYear

function processArgs()
{
		# -v year=1939
		# -v year=1939,1954
      printf("processArgs: \tyear = :%s:\n", year);
		if(year == "") {
			printf("ERROR: need year parameter\n");
			exit 1;
		}
		split(year,Years,",");
		if(length(Years) == 0) {
			printf("ERROR: need year parameter\n");
			exit 1;
		}
      printf("processArgs: \tYears length = :%d:\n", length(Years));
		for (y in Years) {
      	printf("processArgs: \tYears[%s] = :%s:\n", y,Years[y]);
			#Data[Years[y]]="";
		}

		# -v path=../data/WeatherData/1939/10320099999
      printf("processArgs: \tpath = :%s:\n", path);
		if(path == "") {
			printf("ERROR: need path parameter\n");
			exit 1;
		}
		Path=path;
} #processArgs
