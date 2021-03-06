#Download and unzip data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="DatasetCourseProject.zip",method="curl")
unzip(zipfile="DatasetCourseProject.zip")


##################################################################
# 1. Merges the training and the test sets to create one data set.
##################################################################

x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
x <- rbind(x_train, x_test)

subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
subject <- rbind(subject_train, subject_test)

y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
y <- rbind(y_train, y_test)

#################################################################
#2. Extracts only the measurements on the mean and standard deviation
#for each measurement. 
##################################################################

features <- read.table('./UCI HAR Dataset/features.txt')
mean.sd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x.mean.sd <- x[, mean.sd]


#################################################################
#3.Uses descriptive activity names to name the activities in the data set
##################################################################

names(x.mean.sd) <- features[mean.sd, 2]
names(x.mean.sd) <- tolower(names(x.mean.sd)) 
names(x.mean.sd) <- gsub("\\(|\\)", "", names(x.mean.sd))

activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')
activity_labels[, 2] <- tolower(as.character(activity_labels[, 2]))
activity_labels[, 2] <- gsub("_", "", activity_labels[, 2])

y[, 1] = activity_labels[y[, 1], 2]
colnames(y) <- 'activity'
colnames(subject) <- 'subject'


#################################################################
#4. Appropriately labels the data set with descriptive variable names. 
##################################################################
data <- cbind(subject, x.mean.sd, y)
str(data)
write.table(data, './merged.txt', row.names = F)



#################################################################
#5. From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each 
#activity and each subject.
##################################################################
average.df <- aggregate(x=data, by=list(activities=data$activity, subj=data$subject), FUN=mean)
average.df <- average.df[, !(colnames(average.df) %in% c("subj", "activity"))]
str(average.df)
write.table(average.df, 'tidy_data_set.txt', row.names = F)

