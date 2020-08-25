#include<stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAXCHAR 10

int main(){
   /* 2D array declaration*/
   float disp[12][2];

	FILE *fp;
   char str[MAXCHAR];
   char* filename = "samplePlot.txt";
 
   if ( (fp = fopen(filename, "r")) == NULL) {
        printf("Could not open file %s",filename);
        return 1;
   }

   int row=0;
	char *pt;
   while (fgets(str, MAXCHAR, fp) != NULL) {
		pt = strtok (str,",\n");  // split on comma
      disp[row][0] =  atof(pt);
      pt = strtok (NULL, ",\n");
      disp[row][1] =  atof(pt);
		row++;
	}  // reading lines
   fclose(fp);

   //Displaying array elements
   printf("\nTwo Dimensional array elements:\n");
   for(int i=0; i<12; i++) {
      for(int j=0;j<2;j++) {
         printf("disp[%d][%d] = :%5.1f:\n", i,j,disp[i][j]);
      }
   }
   return 0;
}
