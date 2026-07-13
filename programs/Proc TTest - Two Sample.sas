/* TTest For Independent Samples */
/* TTest - The ttest for independent samples
 (or unpaired ttest) tests whether two independet
 groups are significantly different. */

PROC CONTENTS DATA=SASHELP.BWEIGHT ORDER=VARNUM NODETAILS;
RUN;

PROC PRINT DATA=SASHELP.BWEIGHT (OBS=10);
RUN;

/********** Assumptions **********/

/* Parametric TTest (Student T-Test):
   -- Two Groups Or Samples Must Be Independent
   -- Dependent Variable Must Be Continuous
   -- Variables Must Be Normally Distributed
   -- Homogenity Of Variance 					*/
/* H0: μ1 = μ2
   H1: μ1 ≠ μ2 */
  
PROC TTEST DATA=SASHELP.BWEIGHT ALPHA=.05;
CLASS MARRIED;
VAR WEIGHT;
RUN;


  
/* Non-Parametric TTest (Welch): */
/* H0: μ1 = μ2
   H1: μ1 ≠ μ2 */ 
  
PROC TTEST DATA=SASHELP.BWEIGHT ALPHA=.05;
CLASS MOMSMOKE;
VAR WEIGHT;
RUN;  
  

/* Non-Parametric TTest (Mann Whitney U): */
/* H0: μ1 = μ2 (Median)
   H1: μ1 ≠ μ2 		   */
  
PROC NPAR1WAY DATA=SASHELP.BWEIGHT WILCOXON;
CLASS MARRIED;
VAR WEIGHT;
TITLE 'TESTING WHETHER THE MEDIAN INFANT WEIGHT OF MARRIED AND UNMARRIED WOMEN IS THE SAME OR NOT';
RUN;











  
