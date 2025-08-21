proc univariate data=sashelp.cars;
   var horsepower;
run;


proc univariate data=sashelp.cars;
   var mpg_highway;
   histogram / normal;
run;

/*Test for normality  */
ods select TestsForNormality;
proc univariate data=sashelp.cars normal;
   var weight;
run;

/* small p value */
/* The data does not follow a normal distribution */
/*  */
/* The deviation is statistically significant */
/*  */
/* You should not assume normality for parametric tests  */
/* like t-tests or ANOVA unless you transform the  */
/* data or use robust alternatives */

/*1st difference: Custom percentile   */
proc means data=sashelp.cars noprint; 
var mpg_city mpg_highway;
output out=MeansWidePctls P5= P25= P75= P95= / autoname;
run; 
proc print data=MeansWidePctls noobs; run;

proc univariate data=sashelp.cars noprint;
var mpg_city mpg_highway;
output out=UniWidePctls pctlpre=CityP_ HwyP_ pctlpts=2.5,15,65,97.5; 
run;  
proc print data=UniWidePctls noobs; run;

/*2.Extreme value check  */
proc univariate data=sashelp.cars;
var mpg_city mpg_highway;
run; 
 proc MEANS data=sashelp.cars
                   MAX MIN;
var mpg_city mpg_highway;
run; 

/*A Quantile-Quantile (Q-Q) plot compares the quantiles of the data to those of a theoretical distribution—in this case,
 the normal distribution.*/
PROC UNIVARIATE DATA=sashelp.cars  PLOT;
VAR mpg_city;
QQPLOT mpg_city /NORMAL(MU=EST SIGMA=EST COLOR=RED L=1);
RUN; 

PROC UNIVARIATE DATA=sashelp.cars  PLOT;
VAR mpg_city;
QQPLOT mpg_city /NORMAL(MU=EST SIGMA=EST COLOR=RED L=1);
RUN; 

/*check whether lipid levels follow a normal distribution  */
proc univariate data=candy.lipid;
   var Triglycerides HDL LDL;
   histogram / normal;
   inset mean std skewness kurtosis / position=ne;
run;
/*Postion: North East Corner of the plot. 
Skewness checks for the symmetry and 
Kutosis for peak or flatness*/



/* Generates a Q-Q plot comparing the 
sample distribution to a normal distribution;
 mu=est and sigma=est estimate the mean 
and standard deviation from the data */

proc univariate data=candy.lipid;
   var Triglycerides;
   qqplot / normal(mu=est sigma=est);
run;


/*  */
/* Normality test: Includes Shapiro-Wilk, Kolmogorov-Smirnov, Anderson-Darling,  */
/* and Cramer-von Mises tests. */
ods select TestsForNormality;
proc univariate data=sashelp.cars normal;
   var weight;
run;

/* display messages in the log */
ods trace on;
proc univariate data=sashelp.cars;
   var mpg_city;
run;
ods trace off;

/*This saves the Quantiles table to a dataset called quant_data  */
ods output Quantiles=quant_data;
proc univariate data=sashelp.cars;
   var mpg_city;
run;


ods trace on;
ods output Moments=moments_data;
proc univariate data=sashelp.cars;
   var mpg_city;
run;
ods trace off;


ods select Quantiles;
proc univariate data = sashelp.shoes;
var sales;
class region;
run;
Select multiple tables
ods select Moments Quantiles ExtremeObs;
proc univariate data=sashelp.shoes;
   var sales;
run;


