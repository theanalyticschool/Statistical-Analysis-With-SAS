/********** CHI-SQUARE TEST IN SAS **********/
/* Association Between Categorical Variables  */


/* Analyzing The Dataset  */
proc print data = email (obs = 10);
var campaign conversion;
run;


/* Conducting Chi-Square Test */
proc freq data = email;
 tables conversion * campaign / chisq expect cmh agree noprint;
run;