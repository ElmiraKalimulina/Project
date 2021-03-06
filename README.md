Getting and Cleaning Data 
=======================================

### Assessment Directions
You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
The first step in my procedure is to download the data. The process will check
to see if the zip file exists and if so it will give the user a warning message.
If not it will download the zip file.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### Background
Read Article - http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/

#### Data
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

####Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Description
#### Downloading Data
The first thing you have to do is downloading ```zip``` file

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

with command

`download.file()`

#### Merge test and train datasets
The second step is unzipping it into the main directory being the working directory of my code by command

`unzip(zipfile="DatasetCourseProject.zip")`


Then I read data from 'train' and 'test' directory separately, for example, for "X" data

`x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')`

`x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')`

and merged them  using ```rbind()```.


###Extracts only the measurements on the mean and standard deviation for each measurement. 

`features <- read.table('./UCI HAR Dataset/features.txt')`

`mean.sd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])`

`x.mean.sd <- x[, mean.sd]`


###Uses descriptive activity names to name the activities in the data set


`names(x.mean.sd) <- features[mean.sd, 2]`

`names(x.mean.sd) <- tolower(names(x.mean.sd)) `

`names(x.mean.sd) <- gsub("\\(|\\)", "", names(x.mean.sd))`


#### Tidy Data Output
I used ```write.table()``` and save my results in ```tidy_data_set.txt```.

#####For more details see comments in a source file ``run_analysis.R``.



