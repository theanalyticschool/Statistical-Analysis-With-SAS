/*********** PROC TTEST ***********/

/* ONE SAMPLE TTest Hypotheses:
	H0: μ = m0
	H1: μ ≠ m0 (two-tailed)
	H1: μ > m0 (upper-tailed)
	H1: μ < m0 (lower-tailed)   */
	
/* ASSUMPTIONS  
   1. The dependent variable must be continuous (interval/ratio).
   2. The observations are independent of one another.
   3. The dependent variable should be approximately normally distributed.
   4. The dependent variable should not contain any outliers. 			   */
  
  
/********** ANALYZE GAPMINDER DATASET **********/
PROC CONTENTS DATA=GAPMINDER ORDER=VARNUM NODETAILS;
RUN;

PROC PRINT DATA=GAPMINDER (OBS = 5) NOOBS;
RUN;


/********** DESCRIPTIVE ANALYSIS **********/
PROC UNIVARIATE DATA=GAPMINDER;
VAR ALCCONSUMPTION;
HISTOGRAM ALCCONSUMPTION / NORMAL(MU=EST SIGMA=EST) KERNEL;
INSET SKEWNESS KURTOSIS / POSITION=NE;
PROBPLOT ALCCONSUMPTION / NORMAL(MU=EST SIGMA=EST);
INSET SKEWNESS KURTOSIS;
TITLE 'DESCRIPTIVE ANALYSIS ON ALCOHOL CONSUMPTION';
RUN;


/********** TTest On Alcohol Consumption **********

/* H0: μ = 7
   H1: μ ≠ 7 (two-tailed) */
PROC TTEST DATA=GAPMINDER ALPHA=.05 H0=7 PLOTS(SHOWNULL) = INTERVAL SIDE=2;
VAR ALCCONSUMPTION;
TITLE 'TESTING WHETHER THE MEAN OF ALCOHOL CONSUMPTION = 7';
RUN;


/* H0: μ < 7
   H1: μ > 7 (upper-tailed) */
PROC TTEST DATA=GAPMINDER ALPHA=.05 H0=7 PLOTS(SHOWNULL) = INTERVAL SIDE=U;
VAR ALCCONSUMPTION;
TITLE 'TESTING WHETHER THE MEAN OF ALCOHOL CONSUMPTION = 7';
RUN;



/* H0: μ > 7
   H1: μ < 7 (lower-tailed) */

PROC TTEST DATA=GAPMINDER ALPHA=.05 H0=7 PLOTS(SHOWNULL) = INTERVAL SIDE=L;
VAR ALCCONSUMPTION;
TITLE 'TESTING WHETHER THE MEAN OF ALCOHOL CONSUMPTION = 7';
RUN;





















	
