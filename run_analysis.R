#download data
if(!file.exists("./data")) {
  dir.create("./data")
}
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipPath <- "./data/UCI HAR Dataset.zip"
download.file(zipURL, zipPath, method = "curl")
unzip(zipPath, exdir = "./data")

#read each file
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#assign descriptive column names
colnames(x_train) <- features[, 2]
colnames(y_train) <- "ActivityID"
colnames(subject_train) <- "SubjectID"
colnames(x_test) <- features[, 2]
colnames(y_test) <- "ActivityID"
colnames(subject_test) <- "SubjectID"
colnames(activity_labels) <- c("ActivityID", "Activity")

#merge data
train <- cbind(y_train, subject_train, x_train)
test <- cbind(y_test, subject_test, x_test)
data <- rbind(train, test)

#extract the measurements on the mean and standard deviation for each measurement
#read col names
dataColNames <- colnames(data)
#define ID, mean, and standard deviation columns
meanAndStd <- grepl("ActivityID", dataColNames) |
              grepl("SubjectID", dataColNames) |
              grepl("mean..", dataColNames) |
              grepl("std..", dataColNames)
#select mean and standard deviation data
meanAndStdData <- data[, meanAndStd == TRUE]
#add activity labels 
dataWithActivityLabels <- merge(activity_labels, meanAndStdData, by="ActivityID", all.x = TRUE)

#create tidy data set with the average of each variable for each activity and each subject
meanData <- aggregate(. ~SubjectID + ActivityID, dataWithActivityLabels, mean)
meanData <- meanData[order(meanData$SubjectID, meanData$ActivityID), ]

#write tidy data set to a text file
write.table(meanData, "meanData.txt", row.name = FALSE)

