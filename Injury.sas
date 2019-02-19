/*
Client: [Redacted]
Affiliation: Boonshoft School of Medicine
Meeting Date: 09/17/2018, 1.30pm - 2.30pm
*/

/*Data Import*/
PROC IMPORT DATAFILE='/folders/myfolders/MarieWalters-InjuryData.csv'
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

data injury;
set work.import (rename=(Timepoint=Time));
if Condition = "sham" then Group=1;
if Condition = "crush" and Time = "acute" then Group=2;
if Condition = "crush" and Time = "regen" then Group = 3;
if Condition = "crush" and Time = "heale" then Group =4;
if Condition = "cut" and Time = "acute" then Group =5;
if Condition = "cut" and Time = "regen" then Group =6;
if Condition = "cut" and Time = "heale" then Group =7;
if Time = "acute" then Timepoint=1;
if Time = "regen" then Timepoint=2;
if Time = "heale" then Timepoint=3;
run;

proc means data=injury mean median stddev min max; /*Descriptive Statistics*/
class Group;
var RiseTime;
run;

proc format;
value Timepointfmt 1="Acute" 2="Regeneration" 3="Healed";
run;


proc sgplot data=injury; /*Plot to display non-linear relationship*/
vline Timepoint / response=RiseTime stat=mean group=Condition;
format Timepoint Timepointfmt.;
title 'Relationship Between Timepoints for Each Condition';
run;
title;


proc mixed data=injury plots=all; /*Analysis with interaction term and plots*/
class Animal_ID Sex Group;
model RiseTime = Group|Sex /ddfm=kr solution;
random int / subject=Animal_ID type=vc ; 
store content;
run;

proc mixed data=injury; /*Analysis w/o interaction term*/
class Animal_ID Sex Group;
model RiseTime = Group Sex  /ddfm=kr solution;
random int / subject=Animal_ID type=vc ; 
run;

proc glimmix data=injury; /*Pairwise Comparisons*/
class Animal_ID Sex Group;
model RiseTime = Group|Sex / ddfm=kr;
random int / subject=Animal_ID type=vc;
lsmestimate Group   "Crush Acute - Sham" -1 1 0 0 0 0 0,
					"Crush Regeneration - Sham" -1 0 1 0 0 0 0 ,
					"Crush Healed - Sham" -1 0 0 1 0 0 0 ,
					"Cut Acute - Sham" -1 0 0 0 1 0 0 ,
					"Cut Regeneration - Sham" -1 0 0 0 0 1 0 ,
					"Cut Healed - Sham" -1 0 0 0 0 0 1,
					"Cut Acute - Crush Acute" 0 -1 0 0 1 0 0 ,
					"Cut Regeneration - Crush Regeneration" 0 0 -1 0 0 1 0,
					"Cut Healed - Crush Healed" 0 0 0 -1 0 0 1
/adjust=bon stepdown adjdfe=row cl alpha=0.01;
run;
quit;







