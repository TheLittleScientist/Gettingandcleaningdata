## First load dplyr as it is used to help working with data frames and have many useful features as
## arrange, filter, select and rename. 
library(dplyr)

## Then the dataset is downloaded.

filename <- "Coursera_DS3_Final.zip"

## Then check if archieve already exists. If it does not the date gets loaded into the archive.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

## In the newly created "Coursera_DS3_Final.zip"file a folder called "UCI HAR Dataset" can be found. 
## A check to see if the dataset exist is made.
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## Then the data frames that now can be found in the "UCI HAR Dataset" are all assigned. Information about the files can be found in the
## README file

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## The training and test datasets are merged by first combining x train and test, then y train and test
## and finally subject train and test. These are merged using rbind as this function combines the sets as rows.
## All three are then combined using the cbind command that combines vectors as columns.

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

## To get only the measurements an the mean and standard diviation the select function is used
## and contains to chose mean and std (standart diviation).

TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

## Code is renamed with witch the activities described in the data set. 

TidyData$code <- activities[TidyData$code, 2]

## A tidy dataset should have names that are easy to understand and thus more understanderble names are choosen. 

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

## A textfile is created by using write.table and group_by is used to group the data by subject and activity. 
## The average is then made by using the mean function. 

FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
