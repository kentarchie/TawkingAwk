#127.0.0.1 - - [15/Aug/2020:15:14:30 -0500] "GET /kent/ HTTP/1.1" 200 1385 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:79.0) Gecko/20100101 Firefox/79.0"
#127.0.0.1 - - [15/Aug/2020:15:14:30 -0500] "GET /icons/blank.gif HTTP/1.1" 200 431 "http://localhost/kent/" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:79.0) Gecko/20100101 Firefox/79.0"

BEGIN { FS="[ \"]+" }
match($7,/kent*/) { ipcount[$1]++ }
END { 
	for (i in ipcount) {
		printf("%15s - %d\n", i, ipcount[i])
	} 
}
