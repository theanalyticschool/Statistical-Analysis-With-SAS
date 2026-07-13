LIBNAME wd '/home/xxxxx/analytics';

FILENAME REFFILE '/home/xxxxx/analytics/iris.xlsx';

PROC IMPORT DATAFILE=REFFILE
    OUT=wd.iris
    DBMS=XLSX
    REPLACE;
    SHEET="Sheet1";  /* optional: specify sheet name */
    GETNAMES=YES;
RUN;

proc contents data=wd.iris;
run;

proc print data=wd.iris;
run;