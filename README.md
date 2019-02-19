**Background**

Change in fluorescence over time in mice with 3 different types of injuries (conditions) are measured: sham 
surgery (control), crush injury (more severe), cut injury (most severe). Measurements are taken in 3 time 
points: 2 days (acute stage), 10 days (regenerative stage), 60 days (healed stage). Change in fluorescence 
is measured with an examination of neurons and obtaining five different measurements: Rise Time, Peak 
Amplitude, Slope, DT1, DT2. Analysis for rise time is included in this report. Other measurements can be 
analyzed in the same manner. 

**Data**

There are 45 animals in total. Observation 468 (Cut, Healed) was removed due to missing data. Each animal 
can only be used for one time point of each condition, and therefore each animal is assigned a Condition and 
a Time Point. For each animal, at the assigned time point, multiple measurements are taken. Number of 
measurements can vary from 7 to 20 and are considered pseudo replications since they are done on the same 
animal. Condition, Time Point, and Sex are considered independent variables. Random effect is included for 
Animal ID to account for the multiple observations per experimental unit at each time point.

The data appears to follow a non-linear trend going from Acute to Regeneration to Healed state in all three 
conditions. Because of the difficulty in producing a robust non-linear model with 3 categorical time points, 
all Sham time points are combined into a single group. This is possible because according to the client, 
there is no time effect in the Sham category. Time Point and Condition are also combined for Crush and Cut 
conditions to make one variable. In summary, Condition and Time Point are grouped together into a new 
independent variable called Group, with 7 levels:

Sham  
Crush Acute  
Crush Regeneration  
Crush Healed  
Cut Acute  
Cut Regeneration  
Cut Healed  	

**Method**

Overall alpha level of 0.05 was used for five models (from 5 variables) and Bonferroni correction was applied 
to the five models and an alpha level of 0.01 was used for each analysis. Proc Mixed procedure in SAS was 
utilized to carry out analysis to allow for correlation in data and non-constant variance. Random scatter of 
data points in the residual plot and the approximate linear relationship in the normal probability plot for 
Rise Time allow for the approximation of normality in data. 

Bonferroni stepdown procedure in Proc Glimmix was utilized to make pairwise comparisons on mean rise time for 
the following Group combinations: 

Crush Acute - Sham  
Crush Regeneration - Sham  
Crush Healed - Sham  
Cut Acute - Sham  
Cut Regeneration - Sham  
Cut Healed - Sham  
Cut Acute - Crush Acute  
Cut Regeneration - Crush Regeneration  
Cut Healed - Crush Healed  

**Results**

Initial analysis with Proc Mixed revealed that interaction between Group and Sex are statistically 
insignificant at significance level 0.01. 

The model was reanalyzed without the interaction and the results are shown in Table 3. Group is still 
statistically significant in determining Rise Time with a p-value of 0.0002. Sex is still statistically 
insignificant at significance level 0.01. 

Parameter estimates for Group and Sex are shown in Table 4. It is important to note here that estimates 
for Group 7(Cut Healed) and Sex Male are set to zero. There is only one statistically significant parameter 
estimate at alpha level 0.01: The intercept (1.4652) estimates the mean Rise Time for Males in Group 7
(Cut Healed). The p-value (<0.0001) is from a test that this mean equals zero. Since p-value is <0.01, mean 
Rise Time for Males in Cut Healed group is significant. 



