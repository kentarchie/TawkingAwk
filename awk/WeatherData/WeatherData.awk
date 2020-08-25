#!/usr/bin/gawk -f
@include "csv.awk" # from http://lorance.freeshell.org/csv/
@include "../lib/utilities.awk"
@include "lib.awk"

function getFiles(years,files)
{
	for (y in years) {
		thisYear = years[y];
		cmd = "ls " Path "/" thisYear "/*.csv"
		#printf("getFiles: cmd (%s)\n", cmd);
		while ( ( cmd | getline fileName ) > 0 ) {
			#printf("getFiles: fileName (%s)\n", fileName);
			push(files,fileName);
		}
		close(cmd);
	} # for years
	printf("getFiles: number of files found (%d)\n", length(files));
} # getFiles


BEGIN { #run once before processing lines
	DATE_POS = 2;
	NAME_POS = 6;
	TEMP_POS = 7;
	DEWP_POS = 9;
	STP_POS = 13;
	VISIB_POS = 15;
		  
	   fileList[0]="";
		processArgs();

		getFiles(Years,fileList);
		TotalDataPoints = 0;
	   printf("BEGIN: Going to process (%d) files\n", length(fileList));
		for (file in fileList) {
			#printf("BEGIN: fileList[%d] (%s)\n", file,fileList[file]);
			currentYear = getYear(fileList[file]);
			if(fileList[file] == "") {
				printf("BEGIN: fileList[%d] (%s) is empty\n", file,fileList[file]);
				continue;
			}
	 		#cmd = "head -2 "  fileList[file]  # tresting
	 		cmd = "cat "  fileList[file]
	 		#printf("file command: cmd (%s)\n", cmd);
			lines = 0;
    		while ( ( cmd | getline dataLine ) > 0 ) {
				if(lines++ == 0) { # skip the first line it's titles
					continue;
			 	}
				TotalDataPoints++;
				if(TotalDataPoints % 1000 == 0)
					printf("BEGIN: TotalDataPoints so far (%d)\n", TotalDataPoints);

				#printf("BEGIN: dataLine (%s)\n", dataLine);
				num_fields = csv_parse(dataLine, csv, ",", "\"", "\"", "\\n", 0)
				if (num_fields < 0) {
					printf("ERROR: %d (%s) -> %s\n", num_fields, csv_err(num_fields), $0);
		 		}
				fileName = fileList[file];
				thisDate = csv[DATE_POS];
				Data[currentYear][fileName]["name"] = csv[NAME_POS] == "" ? "Missing" : csv[NAME_POS];

				Data[currentYear][fileName][thisDate]["temp"]  = csv[TEMP_POS];
				Data[currentYear][fileName][thisDate]["dewp"]  = csv[DEWP_POS];
				Data[currentYear][fileName][thisDate]["stp"]   = csv[STP_POS];
				Data[currentYear][fileName][thisDate]["visib"] = csv[VISIB_POS];
    		} # while processing lines
			close(cmd);
		} # for files
		walk_array(Data, "Data",      i)
		exit;
} # BEGIN

END   { # run once after processing lines
		printf("END: processed %d data points\n",TotalDataPoints);
}
