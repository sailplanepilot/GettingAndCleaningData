# Project notes
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#
#
setwd("~/coursera/3-Data_prep/project")
library(dplyr)
#
# We don't need most of the columns in X_train.txt, only the ones with mean and std
# Start by reading in the features.txt
features<-read.table("./Dataset/features.txt")
# and getting the ones that have mean or std in them
keepcols<-grep("mean|std",features$V2)
# keepcols is a vector of indecies to the cols we want to keep
#
# We are going to use it to set all the other col classes to "NULL"
# which will be skipped when we read in X_train/test
#
# Grab a sample of 5 rows from X_train and find the class of each col
xtrain<-read.table("./Dataset/train/X_train.txt",nrows=5)
classes <- sapply(xtrain, class)
#
# Now we want to set each class that we do not want to read in to "NULL"
# Start by setting a vector placeholder with NULLs
mycols <- rep("NULL", length(xtrain)) 
# and then copy the classes over that we want to keep
# (Yes - they are all numeric in this case, but I don't want to assume that, so we 
#  will use the original values. This keeps the code more generic)
mycols[keepcols]<-classes[keepcols]
#
# Now I can read in the whole X_train table and skip over the cols I don't need
# xtrain will load about 3x faster now
xtrain<-read.table("./Dataset/train/X_train.txt",colClasses=mycols,comment.char="")
# 
# Since the participants we dividedinto "train" and "test" groups, I can read test in
# and append it to the train table
xtest<-read.table("./Dataset/test/X_test.txt",colClasses=mycols,comment.char="")
# (x isn't very descriptive, but that's what's in the original data)
x<-rbind(xtrain,xtest)
#
# We now need to subjects and actions, and add them to x_df
sub_train<-read.table("./Dataset/train/subject_train.txt")
sub_test<-read.table("./Dataset/test/subject_test.txt")
subjects<-rbind(sub_train,sub_test)
y_train<-read.table("./Dataset/train/y_train.txt")
y_test<-read.table("./Dataset/test/y_test.txt")
activities<-rbind(y_train,y_test)
#
# I want to change the activities from numbers to something readable
act_labels<-read.table("./Dataset/activity_labels.txt",colClasses=c("NULL","character"))
# (A better way?)
for (i in 1:nrow(act_labels)) {
    activities<-replace(activities,activities==i,act_labels[i,])
}
# a quick (optional) check to confirm equal number of rows
# nrow(x) == nrow(subjects) & nrow(x) == nrow(activities)
#
# Join into one DF and make a little easier to work with using dplyr
mytable<-tbl_df(cbind(subjects,activities,x))
#
# Let's give the cols meaningful names while we're at it
names(mytable)<-c("Subject","Activity",grep("mean|std",features$V2,value=TRUE))
#
#
# From the data set above (mytable), creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
subs<-group_by(mytable,Subject,Activity)
tidy<-summarise_each(subs,funs(mean))
write.table(tidy,file="./tidy_data.txt",row.name=FALSE)