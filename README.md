For this assignment the dataset 'Human Activity Recognition Using Smartphones' was used.

In the reposatory the following files can be found:

**CodeBook.rmd** which is the code book that describes the data that was used, how it was gathered and what alterations 
that was made to make a tidy data set.

**run_analysis.R** which is the script that prepares data to make the tidy data set. 

It downloads the data.

It assigns the data frames.

It merges the the two data sets training test sets to make one data set.

It extracts the measurements on the mean and standard deviation for each measurement in the subject and code columns.

It renames code with the Uses descriptive activity names to name the activities in the data set

It renames labels to something that is more easy to understand. 

It makes a new data set from the previous made data set showing the average of each activity, variable and subject. 

**FinalData.txt** which is a text file that shows the final data after having gone through the process as described in the
run_analysis.R script.
