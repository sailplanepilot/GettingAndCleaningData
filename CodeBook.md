<!---
---
title: "Getting and Cleaning Data"
#date: "September 13, 2014"
output: html_document
---
-->

# Getting and Cleaning Data
###Code Book
###Coursera getdata-007

## Purpose
This Code Book describes the data produced by the author's R script to demonstrate gathering and preparing a data set for later analysis.

## Original Data
The original data was retrieved on 5 September 2014 from *Human Activity Recognition Using Smartphones Data Set* [at this web page.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) [1] 

### Description of Original Data
The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

###Original Data Summary###
**Data Set Characteristics:** Multivariate, Time-Series

**Number of Instances:** 10299

**Number of Attributes:** 561

**Date Donated:** 2012-12-10

**Missing Values:** N/A

#Refined Data
The refined data, the output of the R script *run_analysis.R,* consists of a subject identifier number, one of six activities, and 79 calculated values of the means and standard deviations of the collected time and frequency domain variables: 3-axial linear acceleration and 3-axial angular velocities. The original training data and test data were concatenated to form a single data set, since the original data was simply randomly assigned to either of the groups. The activity numbers were replaced with the appropriate label, and labels created for the collected time and frequency domain variables.

##Variables
###Subject
The **Subject** variable identifies the participant in the study and can range from 1 to 30. While the variable class is *numeric,* it is a nominal value and only used to identify the participant.

###Activity
There are six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) that each subject performed while wearing the recoding device. These activities are identified by the numerals 1 through 6 corresponding to the activity list above in the original data. While the variable class is *numeric,* it is a nominal value and only used to identify the activity.

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

###Time and Frequency Domain Variables
While the original data set has 561 variables, we are collecting only the 79 measurements of the mean and standard deviation for the accelerometer (tAcc-XYZ) and gyroscope (tGyro-XYZ) 3-axial raw signals. The acceleration signal is in standard gravity units 'g', and the gyroscope units are radians/second.

1. tBodyAcc-mean()-X
2. tBodyAcc-mean()-Y
3. tBodyAcc-mean()-Z
4. tBodyAcc-std()-X
5. tBodyAcc-std()-Y
6. tBodyAcc-std()-Z
7. tGravityAcc-mean()-X
8. tGravityAcc-mean()-Y
9. tGravityAcc-mean()-Z
10. tGravityAcc-std()-X
11. tGravityAcc-std()-Y
12. tGravityAcc-std()-Z
13. tBodyAccJerk-mean()-X
14. tBodyAccJerk-mean()-Y
15. tBodyAccJerk-mean()-Z
16. tBodyAccJerk-std()-X
17. tBodyAccJerk-std()-Y
18. tBodyAccJerk-std()-Z
19. tBodyGyro-mean()-X
20. tBodyGyro-mean()-Y
21. tBodyGyro-mean()-Z
22. tBodyGyro-std()-X
23. tBodyGyro-std()-Y
24. tBodyGyro-std()-Z
25. tBodyGyroJerk-mean()-X
26. tBodyGyroJerk-mean()-Y
27. tBodyGyroJerk-mean()-Z
28. tBodyGyroJerk-std()-X
29. tBodyGyroJerk-std()-Y
30. tBodyGyroJerk-std()-Z
31. tBodyAccMag-mean()
32. tBodyAccMag-std()
33. tGravityAccMag-mean()
34. tGravityAccMag-std()
35. tBodyAccJerkMag-mean()
36. tBodyAccJerkMag-std()
37. tBodyGyroMag-mean()
38. tBodyGyroMag-std()
39. tBodyGyroJerkMag-mean()
40. tBodyGyroJerkMag-std()
41. fBodyAcc-mean()-X
42. fBodyAcc-mean()-Y
43. fBodyAcc-mean()-Z
44. fBodyAcc-std()-X
45. fBodyAcc-std()-Y
46. fBodyAcc-std()-Z
47. fBodyAcc-meanFreq()-X
48. fBodyAcc-meanFreq()-Y
49. fBodyAcc-meanFreq()-Z
50. fBodyAccJerk-mean()-X
51. fBodyAccJerk-mean()-Y
52. fBodyAccJerk-mean()-Z
53. fBodyAccJerk-std()-X
54. fBodyAccJerk-std()-Y
55. fBodyAccJerk-std()-Z
56. fBodyAccJerk-meanFreq()-X
57. fBodyAccJerk-meanFreq()-Y
58. fBodyAccJerk-meanFreq()-Z
59. fBodyGyro-mean()-X
60. fBodyGyro-mean()-Y
61. fBodyGyro-mean()-Z
62. fBodyGyro-std()-X
63. fBodyGyro-std()-Y
64. fBodyGyro-std()-Z
65. fBodyGyro-meanFreq()-X
66. fBodyGyro-meanFreq()-Y
67. fBodyGyro-meanFreq()-Z
68. fBodyAccMag-mean()
69. fBodyAccMag-std()
70. fBodyAccMag-meanFreq()
71. fBodyBodyAccJerkMag-mean()
72. fBodyBodyAccJerkMag-std()
73. fBodyBodyAccJerkMag-meanFreq()
74. fBodyBodyGyroMag-mean()
75. fBodyBodyGyroMag-std()
76. fBodyBodyGyroMag-meanFreq()
77. fBodyBodyGyroJerkMag-mean()
78. fBodyBodyGyroJerkMag-std()
79. fBodyBodyGyroJerkMag-meanFreq()

##Summary of Refined Data
The refined data, **tidy,** is a  [180 x 81] data frame grouped by **Subject** and sub-grouped by **Activity,** and each entry followed by a vector of 79 mean and standard deviation Time and Frequency domain variables.

a small section  of the *tidy* data is shown below:

~~~
   Subject           Activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z

1        1             LAYING         0.2215982      -0.040513953        -0.1132036

2        1            SITTING         0.2612376      -0.001308288        -0.1045442

3        1           STANDING         0.2789176      -0.016137590        -0.1106018

4        1            WALKING         0.2773308      -0.017383819        -0.1111481

5        1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662

6        1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020

7        2             LAYING         0.2813734      -0.018158740        -0.1072456

8        2            SITTING         0.2770874      -0.015687994        -0.1092183

9        2           STANDING         0.2779115      -0.018420827        -0.1059085

10       2            WALKING         0.2764266      -0.018594920        -0.1055004
~~~


###Notes
#####[1] Citation:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

