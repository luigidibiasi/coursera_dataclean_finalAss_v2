#Coursera assignemt
#Author: Luigi Di Biasi
#Date: 18th March 2022


##### do not use this on openlab due to download.zip issues. test it on local R 

library(dplyr) #use dplyr
if(!file.exists("./dataset")){dir.create("./dataset")} #prepare directory and download the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./dataset/Dataset.zip")
unzip(zipfile="./dataset/Dataset.zip",exdir="./dataset") #extract the UCI dataset

#load each subdataset from UCI dataset 
#as first load 'features' that contains cols name
features <- read.table("./dataset/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
# load the subsets
x_train <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./dataset/UCI HAR Dataset/train/y_train.txt", col.names = "code")
x_test <- read.table("./dataset/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./dataset/UCI HAR Dataset/test/y_test.txt", col.names = "code")
activities <- read.table("./dataset/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("./dataset/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

# merge TRAINING aND TEST SET into one single DATASET 

X <- rbind(x_train, x_test) #merge  X train ad test
Y <- rbind(y_train, y_test) #merge Y train and test
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#Extracts only the measurements on the mean and standard deviation for each measurement
Cleaned <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


####
#from now there are only cleaning operation on the data to made data more clean to human
####

Cleaned$code <- activities[Cleaned$code, 2]


#STEP 4- Use GSUB to made col names more human 

names(Cleaned)[2] = "activity"
names(Cleaned)<-gsub("Acc", "Accelerometer", names(Cleaned))
names(Cleaned)<-gsub("Gyro", "Gyroscope", names(Cleaned))
names(Cleaned)<-gsub("BodyBody", "Body", names(Cleaned))
names(Cleaned)<-gsub("Mag", "Magnit.", names(Cleaned))
names(Cleaned)<-gsub("^t", "Time", names(Cleaned))
names(Cleaned)<-gsub("^f", "Hz", names(Cleaned))
names(Cleaned)<-gsub("tBody", "TimeBody", names(Cleaned))
names(Cleaned)<-gsub("-mean()", "Mean", names(Cleaned), ignore.case = TRUE)
names(Cleaned)<-gsub("-std()", "SD", names(Cleaned), ignore.case = TRUE)
names(Cleaned)<-gsub("-freq()", "Hz", names(Cleaned), ignore.case = TRUE)
names(Cleaned)<-gsub("angle", "Angle", names(Cleaned))
names(Cleaned)<-gsub("gravity", "Gravity", names(Cleaned))


#STEP5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

FinalData <- Cleaned %>%  
group_by(subject, activity) %>%  
summarise_all(funs(mean))

# store final output
write.table(FinalData, "FinalData.txt", row.name=FALSE)