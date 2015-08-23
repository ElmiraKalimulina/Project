#Download and unzip data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/DatasetCourseProject.zip",method="curl")
unzip(zipfile="./data/DatasetCourseProject.zip",exdir="./data")


##################################################################
# 1. Merges the training and the test sets to create one data set.
##################################################################

x_train <- read.table('./data/UCI HAR Dataset/train/X_train.txt')
x_test <- read.table('./data/UCI HAR Dataset/test/X_test.txt')
x <- rbind(x_train, x_test)

subject_train <- read.table('./data/UCI HAR Dataset/train/subject_train.txt')
subject_test <- read.table('./data/UCI HAR Dataset/test/subject_test.txt')
subject <- rbind(subject_train, subject_test)

y_train <- read.table('./data/UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('./data/UCI HAR Dataset/test/y_test.txt')
y <- rbind(y_train, y_test)

#################################################################
#2. Extracts only the measurements on the mean and standard deviation
#for each measurement. 
##################################################################

features <- read.table('./data/UCI HAR Dataset/features.txt')
mean.sd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x.mean.sd <- x[, mean.sd]


#################################################################
#3.Uses descriptive activity names to name the activities in the data set
##################################################################

names(x.mean.sd) <- features[mean.sd, 2]
names(x.mean.sd) <- tolower(names(x.mean.sd)) 
names(x.mean.sd) <- gsub("\\(|\\)", "", names(x.mean.sd))

activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')
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
write.table(data, './data/merged.txt', row.names = F)



#################################################################
#5. From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each 
#activity and each subject.
##################################################################
average.df <- aggregate(x=data, by=list(activities=data$activity, subj=data$subject), FUN=mean)
average.df <- average.df[, !(colnames(average.df) %in% c("subj", "activity"))]
str(average.df)
write.table(average.df, './data/average.txt', row.names = F)












#Names before
head(str(dataTable),2)
     
     
     names(dataTable)<-gsub("std()", "SD", names(dataTable))
     names(dataTable)<-gsub("mean()", "MEAN", names(dataTable))
     names(dataTable)<-gsub("^t", "time", names(dataTable))
     names(dataTable)<-gsub("^f", "frequency", names(dataTable))
     names(dataTable)<-gsub("Acc", "Accelerometer", names(dataTable))
     names(dataTable)<-gsub("Gyro", "Gyroscope", names(dataTable))
     names(dataTable)<-gsub("Mag", "Magnitude", names(dataTable))
     names(dataTable)<-gsub("BodyBody", "Body", names(dataTable))
     # Names after
     head(str(dataTable),6)
     
     
     ##write to text file on disk
     write.table(dataTable, "TidyData.txt", row.name=FALSE)


