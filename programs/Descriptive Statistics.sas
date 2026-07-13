/* Importing an excel file*/
PROC IMPORT DATAFILE='../data/dataset1.xlsx'
	DBMS=XLSX
	OUT=WORK.OUTDATA;
	GETNAMES=YES;
RUN;

/* PROC MEANS - SAMPLE CODE */
PROC MEANS DATA = OUTDATA;
VAR MONTHLYINCOME;
RUN;

/* PROC MEANS - MEAN, MEDIAN, STDEV */
PROC MEANS DATA = OUTDATA MEAN MEDIAN STD;
VAR MONTHLYINCOME;
RUN;

/* SUMMARY by Department */
PROC MEANS DATA = OUTDATA MEAN MEDIAN STD;
VAR MONTHLYINCOME;
CLASS Department;
RUN;

/* Store result in SAS dataset format */
PROC MEANS DATA = OUTDATA NOPRINT;
VAR MONTHLYINCOME;
CLASS Department;
OUTPUT OUT=Mystats MEAN=income_mean MEDIAN=income_median STD=income_std ;
RUN;

/* Removing overall level score */
PROC MEANS DATA = OUTDATA NWAY NOPRINT;
VAR MONTHLYINCOME;
CLASS Department;
OUTPUT OUT=Mystats MEAN=income_mean MEDIAN=income_median STD=income_std ;
RUN;

/* Automatic Variable Name*/
PROC MEANS DATA = OUTDATA MEAN MEDIAN STD NOPRINT;
VAR MONTHLYINCOME;
CLASS Department;
OUTPUT OUT=Mystats MEAN= MEDIAN= STD= / AUTONAME;
RUN;

/* PROC MEANS - Summary Statistics */
PROC MEANS DATA = OUTDATA N NMISS STDDEV MIN P1 P5 P25 
P50 P75 P95 P99 MAX;
VAR MONTHLYINCOME;
CLASS Department;
RUN;

/* OUTPUT to SAS Data */
ods output summary = temp;
proc means data = OUTDATA n nmiss stddev min P1 P5 P10 P25 
P50 P75 P95 P99 max;
var MONTHLYINCOME;
CLASS Department;
run;
ods output close;

*Custom Percentiles;
proc univariate data = OUTDATA noprint;
var MONTHLYINCOME;
CLASS Department;
output out = temp pctlpts = 97.5 , 99.5 pctlpre = p_;
run;

/* More than 1 variable */
ods output summary = temp;
proc means data = OUTDATA n nmiss stddev min P1 P5 P10 P25 
P50 P75 P95 P99 max;
var MONTHLYINCOME Age;
CLASS Department;
run;
ods output close;

/*Format Output - More than 1 variable */
ods output summary = temp;
proc means data = OUTDATA STACKODS n nmiss stddev min P1 P5 P10 P25 
P50 P75 P95 P99 max;
var MONTHLYINCOME Age;
CLASS Department;
run;
ods output close;

*Selecting variables having zero variance;
ods output summary = temp;
proc means data = OUTDATA STACKODS stddev;
var _numeric_;
run;
ods output close;

data zerostdev;
set temp;
where StdDev = 0; 
run;

/* Normal Distribution */
data xyz;
input var1;
datalines;
3
6
9
12
15
18
21
24
27
;
run;

/* Histogram */
proc univariate data = xyz noprint;
histogram / NORMAL;
run;

/* Customize Bin Size */
proc univariate data = xyz noprint;
histogram / normal midpoints=(3 to 27 by 9)  odstitle=title;
run;

/* Box Plot */
ods select Plots SSPlots;
proc univariate data=xyz plot;
var var1;
run;

/* If a box plot has equal proportions around the median, we can say  */
/* distribution is symmetric or normal.  */

/* Method 2 : */
/* If skewness > -0.5 and  <  0.5, the distribution is approximately symmetric or normal. */
/* If skewness < -1 or > +1, the distribution is highly skewed. */
/* If skewness is between -1 and -0.5 or between 0.5 and +1, the distribution is moderately skewed. */

proc univariate data = OUTDATA noprint;
histogram MONTHLYINCOME / NORMAL;
run;

/*Frequency Distribution */
proc format;
value range
1='Below College'
2='College'
3='Bachelor'
4='Master'
5='Doctor';
run;

proc freq data = OUTDATA;
tables Education / out= result;
format Education range.;
run;

/* Cross Tabulation */
proc freq data = OUTDATA;
tables Education * JobSatisfaction / list;
run;

/* Number of categories */
ods output nlevels = charlevels;
proc freq data=OUTDATA nlevels;
tables EnvironmentSatisfaction JobInvolvement / nopercent nocol nocum nofreq noprint;
run;
ods output close;