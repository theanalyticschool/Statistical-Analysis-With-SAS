libname wd '/home/xxxxx/analytics';

data wd.test;
set sashelp.baseball;
run;

proc print data=wd.test;
run;

FILENAME REFFILE '/home/xxxxx/analytics/iris.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=wd.iris;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=wd.iris; RUN;