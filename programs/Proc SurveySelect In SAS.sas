/* Mastering Sampling Strategies With Proc SurveySelect  */

data test;
set sashelp.baseball;
run;

proc contents data=test varnum nodetails ;
run;

proc print data=test (obs=10);
run;

/* Simple Random Sampling */

proc surveyselect data=test out=sample_srs
method=srs
sampsize=50
seed = 42;
id name team nhits nruns division div logsalary;
run;

proc print data=sample_srs;
run;

/* Random Sampling With Replacement */

proc surveyselect data=test out=sample_srs_replace outhits
method=urs
sampsize=50
seed=42;
id name team nhits nruns division div logsalary;
run;

proc print data=sample_srs_replace;
run;


/* Systematic Sampling */

proc surveyselect data=test out=sample_sys
method=sys
sampsize=50
seed=42;
id name team nhits nruns division div logsalary;
run;


proc print data=sample_sys;
run;


/* Stratified Random Sampling */

proc sql;
select distinct div from test;
quit;

proc sort data=test;
by div;
run;

proc surveyselect data=test out=sample_strata
method=srs
sampsize=50
seed=42;
strata div;
id name team nhits nruns division div logsalary;
run;

proc print data=sample_strata;
run;


/* Cluster Sampling */


proc surveyselect data=test out=sample_cluster
method=srs
samprate=10
seed=42;
cluster div;
id name team nhits nruns division div logsalary;
run;

proc print data=sample_cluster;
run;


/* PPS Sampling */

proc surveyselect data=test out=sample_pps
method=pps
sampsize=50
seed=42;
size nhits;
id name team nhits nruns division div logsalary;
run;

proc print data=sample_pps;
run;


/* Systematic PPS Sampling */

proc surveyselect data=test out=sample_sys_pps
method=pps_sys
sampsize=50
seed=42;
size nhits;
id name team nhits nruns division div logsalary;
run;

proc print data=sample_sys_pps;
run;













































