/* NWay & Two Way Anova in SAS  */


libname wd '/home/xxxxx/analytics';

proc print data=wd.marketing (obs = 10);
run;

proc freq data=wd.marketing;
	tables adtype segment platform;
run;

proc freq data=wd.marketing;
	tables adtype*segment*platform / nocol norow nopercent;
run;

proc means data=wd.marketing mean std maxdec=2;
	class adtype segment platform;
	var conversions;
run;

proc glm data=wd.marketing;
	class adtype segment platform;
	model conversions = adtype|segment|platform / ss3;
	lsmeans adtype*platform / slice=platform plot=meanplot;
run;


proc glm data=wd.marketing;
	class adtype platform;
	model conversions = adtype|platform / ss3;
run;

/* When to use Type I, II, III and IV SS
   Type I:
   		- Order of Factors Matters
   		- Data is Balanced
   		- You want incremental contributions
   Not recommended for interaction heavy Anova. 
   Generally, no one use it until and unless you are 100% confident about the order
   
   Type II:
   		- Your model has no interaction terms
   		- Comparing main effects only
   If interaction exist --> Don't use Type II
   
   Type III:
   		- Your model has interactions
   		- Data is unbalanced
   		- You want effects adjusted for all others
   This is correct 95% of time. Start Anova analysis with ss3 if you have interaction features.
   
   Type IV:
   		- Missing Data
   		- Some factor combinations never occured
   Rare, but important for incomplete designs. */


proc glm data=wd.marketing;
	class adtype segment platform;
	model conversions = adtype segment platform / ss2;
run;   
   
   
   
   































































