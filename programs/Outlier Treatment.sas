/*Import Data*/
proc import datafile= "../data/dataset2.xlsx"
out= dataset
dbms = XLSX
replace;
run;

/*Get variable names*/
proc contents data=mylib.dataset out=varlist;
run;

ods output summary = temp;
proc means data= dataset stackods MIN P25 P50 P75 P95 P99 max; 
var _ALL_;
run;
ods output close;

/* Extract the upper and lower acceptable limit*/
data temp;
set temp;
lower = P25 - 3 * (P75 - P25);
upper = P75 + 3 * (P75 - P25);
run;

/*99th Percentile Capping*/
data dataset2;
set dataset;
if (age > 59) then age = 59;
run;

/*Check whether capping has been applied correctly*/
proc means data= dataset2 P99 max; 
var age;
run;

/*************************************************
Percentile Capping / Winsorize macro
*input = dataset to winsorize;
*output = dataset to output with winsorized values;
*class = grouping variables to winsorize;
* Specify "none" in class for no grouping variable;
*vars = Specify variable(s) in which you want values to be capped;
*pctl = define lower and upper percentile - acceptable range;
**************************************************/

%macro pctlcap(input=, output=, class=none, vars=, pctl=1 99);

%if &output = %then %let output = &input;
  
%let varL=;
%let varH=;
%let xn=1;

%do %until (%scan(&vars,&xn)= );
%let token = %scan(&vars,&xn);
%let varL = &varL &token.L;
%let varH = &varH &token.H;
%let xn=%EVAL(&xn + 1);
%end;

%let xn=%eval(&xn-1);

data xtemp;
set &input;
run;

%if &class = none %then %do;

data xtemp;
set xtemp;
xclass = 1;
run;

%let class = xclass;
%end;

proc sort data = xtemp;
by &class;
run;

proc univariate data = xtemp noprint;
by &class;
var &vars;
output out = xtemp_pctl PCTLPTS = &pctl PCTLPRE = &vars PCTLNAME = L H;
run;

data &output;
merge xtemp xtemp_pctl;
by &class;
array trimvars{&xn} &vars;
array trimvarl{&xn} &varL;
array trimvarh{&xn} &varH;

do xi = 1 to dim(trimvars);
if not missing(trimvars{xi}) then do;
if (trimvars{xi} < trimvarl{xi}) then trimvars{xi} = trimvarl{xi};
if (trimvars{xi} > trimvarh{xi}) then trimvars{xi} = trimvarh{xi};
end;
end;
drop &varL &varH xclass xi;
run;

%mend pctlcap;

/*proc contents data=mylib.dataset out=varlist (keep=name);*/
/*run;*/

%pctlcap(input= 
dataset, 
output=result, 
class=none, 
vars = Age
Avg_Balance_6months
Tenure_with_Bank_Months, 
pctl=1 99);

proc means data= result P99 max; 
var _all_;
run;

/*Outliers : Standard Deviation Method*/
data sample;
input var1;
cards;
1
3
4
6
8
10
15
20
26
1500
;
run;

proc means data=sample noprint;
var var1;
output out=test mean=Xbar std=stdev ;
run;

data test;
set test;
lower = Xbar - 3*stdev;
upper = Xbar + 3*stdev;
run;

data test;
input values;
cards;
90.6
86.4
87.2
88.1
84.1
86.9
83.3
91.1
86.9
87
;
run;

/*Check whether Population Mean is different than 90*/
proc ttest data=test alpha=0.05  h0=90;
var values;
run;

/* If p-value < 0.05 , reject null hypothesis at 5% level */
/* If p-value > 0.05 , do not reject null hypothesis at 5% level */

/*Check whether Population Mean is less than or equal to 90*/
proc ttest data=test alpha=0.05  sides=l  h0=90;
var values;
run;

/*Check whether Population Mean is greater than or equal to 90*/
proc ttest data=test alpha=0.05  sides=u  h0=90;
var values;
run;

/* Check Normality */
ods select TestsforNormality;
proc univariate data = test normal;
var values;
run;

proc import datafile= "../data/dataset1.xlsx"
out= dataset2
dbms = XLSX
replace;
run;

proc ttest data=dataset2 alpha=0.05 h0=6500;
var monthlyincome;
run;

ods select TestsforNormality;
proc univariate data = dataset2 normal;
var monthlyincome;
run;
