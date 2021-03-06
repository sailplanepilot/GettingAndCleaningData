README
======

### run\_analysis.R

### Getting and Cleaning Data, Coursera getdata-007

Purpose
-------

This README explains how the `run_analysis.R` script works and how the
process flows. This script demonstrates gathering and preparing a data
set for later analysis. See the `CodeBook` for a detailed description of
the data produced by the this R script.

Data
----

The original data was retrieved on 5 September 2014 from *Human Activity
Recognition Using Smartphones Data Set* [at this web
page.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Overview of the Original Data

The experiments were carried out with a group of 30 volunteers within an
age bracket of 19-48 years. Each person performed six activities
(WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING,
LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using
its embedded accelerometer and gyroscope, the researchers captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The obtained dataset was randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

### Refined Data

The refined data, the output of the R script *run\_analysis.R,* consists
of a subject identifier number, one of six activities, and 79 calculated
values of the means and standard deviations of the collected time and
frequency domain variables: 3-axial linear acceleration and 3-axial
angular velocities. The original training data and test data were
concatenated to form a single data set, since the original data was
simply randomly assigned to either of the groups. The activity numbers
were replaced with the appropriate label, and labels created for the
collected time and frequency domain variables.

run\_analysis.R
===============

Overview
--------

The process flow of the script reads in and parses the meta-data to set
the stage for reading in the original raw data. Since this data set is
quite large, the script will only read in the required data, mean and
standard deviation measurements, to save time and space. The data
resides as both a training set and a test set. Since these sets are just
randomly partitioned by the originator, we will combine them into a
single set.

The variable lables will be assigned to the data, and the activities
translated from an identifying number to an intuitive and readable
label. The data set is grouped by subject and activity, and written to a
text file, `tidy.txt`.

Code
----

Set up the working directory and load the necessary libraries. We use
the dplyr library to simplify handling the data.

    setwd("~/coursera/3-Data_prep/project")
    library(dplyr)

We don't need most of the columns in original data set (X\_train.txt and
X\_test.txt), so we will read only the columns with mean or standard
deviation in the variable name. This information is gleaned from the
file `features.txt`. We start by reading in the `features.txt` and use
*grep* to create a vector of indecies to the columns we want to keep.

    features<-read.table("./Dataset/features.txt")
    keepcols<-grep("mean|std",features$V2)

We are going to use the *keepcols* vector as a mask by setting all the
data column classes to "NULL" and then resetting the ones we want to
keep. We grab a sample of 5 rows from X\_train and find the class of
each column.

    xtrain<-read.table("./Dataset/train/X_train.txt",nrows=5)
    classes <- sapply(xtrain, class)

Now we want to set each class that we do not want to read in to "NULL"
by setting a vector placeholder with NULLs and then copying the classes
over that we want to keep. In this case, all the original data classes
are numeric, but we should not assume that, so we will use the original
values. This keeps the code more generic.

    mycols <- rep("NULL", length(xtrain)) 
    mycols[keepcols]<-classes[keepcols]

Now we read in the whole X\_train table and skip over the columns we
don't need. This helps xtrain load about 3 times faster. There are no
comments in the raw data, so we can also speed things up by setting the
comment.char = "". Since the participants we divided into "train" and
"test" groups, I can read `X_test.txt` in and append it to the xtrain
table. (x isn't very descriptive for the combined table, but that's
what's in the original data and is temporary anyway).

    xtrain<-read.table("./Dataset/train/X_train.txt",colClasses=mycols,comment.char="")
    xtest<-read.table("./Dataset/test/X_test.txt",colClasses=mycols,comment.char="")
    x<-rbind(xtrain,xtest)

We need need to read in the subjects and actions from both the training
and test sets, similarly.

    sub_train<-read.table("./Dataset/train/subject_train.txt")
    sub_test<-read.table("./Dataset/test/subject_test.txt")
    subjects<-rbind(sub_train,sub_test)

    y_train<-read.table("./Dataset/train/y_train.txt")
    y_test<-read.table("./Dataset/test/y_test.txt")
    activities<-rbind(y_train,y_test)

We want to change the activities from numbers to something readable. We
read in the `activity_labels.txt` and create a vector with the labels.
Then loop through **activities** replacing the activity number with the
activity label.

    act_labels<-read.table("./Dataset/activity_labels.txt",colClasses=c("NULL","character"))
    for (i in 1:nrow(act_labels)) {
            activities<-replace(activities,activities==i,act_labels[i,])
    }

At this point, we can conduct a quick check to confirm an equal number
of rows by entering the following at the console. It should return a
value of **TRUE**. It is commented out in the script since it is
optional.

    # nrow(x) == nrow(subjects) & nrow(x) == nrow(activities)

We join the the **subjects** and **activities** with the data (**x**)
into one DF using *cbind* and make a little easier to work with using
dplyr's *tbl\_df* at the same time.

    mytable<-tbl_df(cbind(subjects,activities,x))

We want to give the columns meaningful names while we're at it. We use
*grep* again, but insead of returning indicies into the vector, we
return the actual values using *value=TRUE*, and assign that to the
names of **mytable** along with "Subject" and "Activity".

    names(mytable)<-c("Subject","Activity",grep("mean|std",features$V2,value=TRUE))

From the data set above (**mytable**), we create a second, independent
tidy data set with the average of each variable and grouped by each
activity for each subject. We use the *summarise\_each* function to
reduce each group to a single row, mutating the columns to find the mean
of each activity in the process. We then write the tidied data file
results to `tidy.txt`.

    subs<-group_by(mytable,Subject,Activity)
    tidy<-summarise_each(subs,funs(mean))
    write.table(tidy,file="./tidy_data.txt",row.name=FALSE)

Summary of Refined Data
-----------------------

The refined data, **tidy,** is a [180 x 81] data frame grouped by
**Subject** and sub-grouped by **Activity,** and each entry followed by
a vector of 79 mean and standard deviation Time and Frequency domain
averages.

A small section of the *tidy* data is shown below:

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
