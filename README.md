# Getting-and-Cleaning-Data-
Files from the Coursera Course Getting and Cleaning Data Course

**The original data is from the:**

Human Activity Recognition Using Smartphones Dataset
Version 1.0
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.

*This README concerns the transformations and analyses made by João Victor Pildervasser to the original data.*

## Description

In the run_analysis.R script is described the 5 steps that I took to transform the Human Activity Recognition Using Smartphone Dataset (HARU SD) raw data to the tidy data format. The steps were not followed in the course order but rather in the most convenient order for me (see code comments). I will briefly describe each step while indicating the course designated order:

## 1) Manipulation and preperation of the full raw data (Course steps 1, 3 and 4)

In this first part the data from the test and train experiments are read and appropriately named following the original. I also added a new column that keeps track of the origin of the data ("origin" column). The final action of this part consists in mergin the two two data sets into a final one. Eu amo meu mamousse.

## 2) Subsetitng the data (Course step 2)

In this part only the variables that have either mean() or sd() at the end of its name is selected. 

## 3) Data analysis and final formatting (Course step 5)

The first step to get the mean of the variables selected in the previous part is by changing the class of the 'subjects' and 'activity' variables to factors in order to use them to split the data. Then, we get the mean of each variable for each combination of 'subject' + 'activity' by means of the colMean function applying the lapply function. Since the output is a list of means, the result is transformed back to a data frame and the 'subjects' and 'activity' identification are added - they are both in ascending order being the 'activity' label the first one to order the data. Lastly the final tidy data is exported.
