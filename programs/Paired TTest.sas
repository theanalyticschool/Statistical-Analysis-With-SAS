/* Paired samples t-test is used to compare the means
   of two samples when each observation in one sample can
   be paired with an observation in the other sample  */

/* Dataset For Paired TTest */

data sales;
input pre post;
datalines;
88 91
82 84
84 88
93 90
75 79
78 80
84 88
87 90
95 90
91 96
83 88
89 89
77 81
68 74
91 92
65 70
75 82
100 124
95 90
78 125
58 52
69 78
78 85
56 55
55 59
87 98
78 110
85 98
45 44
47 87
;
run;


PROC PRINT DATA=sales (OBS=10);
RUN;

/********** HYPOTHESIS **********/
/* H0: The mean pre-test and post-test sales are equal.
   HA: The mean pre-test and post-test sales are not equal. */


PROC TTEST DATA=SALES ALPHA = .05;
PAIRED PRE * POST;
RUN;
















