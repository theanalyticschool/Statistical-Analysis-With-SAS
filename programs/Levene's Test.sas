/***************** LEVENE'S TEST *****************/
/* Stattistica Test such as Anova Analysis 
make the assumption that the variance 
among several groups is equal. To formally test 
this assumption is to use Levene’s Test, 
which tests whether or not the variance among 
two or more groups is equal.                    */


/* Levene's TTest Hypotheses:
	H0: The variance among the group is equal
	H1: The variance among the group is not equal   */
	

LIBNAME wd '/home/xxxxx/analytics';

PROC PRINT DATA = wd.iris (OBS = 10);
RUN;

proc contents data=wd.iris details;
run;

/* Descriptive Analysis  */

proc sql;
select 
		species,
		min(petal_length) as min_petal_length,
		avg(petal_length) as avg_petal_length,
		std(petal_length) as std_petal_length,
		max(petal_length) as max_petal_length
		
From wd.iris
group by species;
quit;

proc univariate data= wd.iris;
	var petal_length;
	histogram petal_length/ normal (mu =est sigma =est) kernel;
	title 'Descriptive Analysis of Petal Length';
run;

/* Levenes Test - Proc GLM */

proc glm data = wd.iris;
	class species;
	model petal_length = species;
	means species / hovtest=levene;
run;






















































