/************** Anova Analysis **************/

/* 
   One way Anova tests whether the means of three
   or more groups are significantly different. Three versions:
   - Classic Parametric F-Test
   - The Welch Anova for unequal variances
   - The non-parametric Kruskal-Wallis Test for unequal varainces and non-normal data
*/


/*  Hypothesis
	H0 - All Species Have The Same Mean Weight
	H1 - At Least One Species Mean Differs
*/


/* 
   Will be working on sashelp.fish data
   - Independent Variable : Species (Categorical Variable)
   - Response Variable : Weight (Numerical Variable)
*/

proc print data=sashelp.fish (obs=10);
run;

proc univariate data=sashelp.fish;
	var weight;
	histogram weight / Normal (mu=est sigma = est) kernel;
	title 'Distribution of Weight var';
run;

proc means data=sashelp.fish;
	class species;
	var weight;
run;


/********** Assumptions for Parametric Anova **********
	- Normality: Data for each group must be approximately normally distributed.
	- Homogeneity of variance: Variances from which the samples are drawn should be equal across all groups.
	- Independence: Observations within and between groups must be independent of one another.
	- Continuous data: The dependent variable should be continuous (interval or ratio data). 
*/

proc glm data=sashelp.fish;
	class species;
	model weight = species;
	means species / tukey cldiff;
run;


/********** Welch Anova  **********/

proc glm data=sashelp.fish;
	class species;
	model weight = species;
	means species / welch;
run;

/*Levenes Test - Homogenity of Variances  */

proc glm data=sashelp.fish;
	class species;
	model weight = species;
	means species / hovtest=levene;
run;

proc univariate data=sashelp.fish;
	var weight;
	histogram weight / Normal (mu=est sigma = est) kernel;
	title 'Distribution of Weight var';
run;

proc npar1way data=sashelp.fish wilcoxon;
	class species;
	var weight;
run;











