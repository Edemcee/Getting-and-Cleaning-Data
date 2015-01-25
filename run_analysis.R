## The data used for the project represent data collected from the accelerometers from the Samsung                
## Galaxy S smartphone.A full description is available at the site where the data was obtained: 

## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Datase.zip



## Set the project working directory

setwd("C:/Users/Edem/Documents/Academic/Data Science/Get & Clean Data")
getwd()



## 1. Merge the training and the test sets to create one data set.


## merge X_test.txt and X_train.txt
x_test <- read.table("X_test.txt", sep = "")
x_train <- read.table("X_train.txt", sep = "")

X_data <- rbind(x_test, x_train)



## merge y_test.txt and y_train.txt
y_test <- read.table("y_test.txt", sep = "")
y_train <- read.table("y_train.txt", sep = "")

Y_data <- rbind(y_test, y_train)


## merge subject_test.txt and subject_train.txt
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")

Subject_data <- rbind(subject_test, subject_train)



## 2. Extract only the measurements on the mean and standard deviation for each measurement.

Features <- read.table("features.txt", sep = "")
index <- grep("-mean\\(\\)|-std\\(\\)", Features[, 2])
X_data <- X_data[, index]
names(X_data) <- Features[index, 2]
names(X_data) <- gsub("\\(|\\)", "", names(X_data))
names(X_data) <- tolower(names(X_data))


## 3. Use descriptive activity names to name the activities in the data set.

label <- read.table("activity_labels.txt")
label[, 2] = gsub("_", "", tolower(as.character(label[, 2])))
Y_data[,1] = label[Y_data[,1], 2]
names(Y_data) <- "activity"



## 4. Appropriately label the data set with descriptive variable names.

names(Subject_data) <- "subject"
combined <- cbind(Subject_data, Y_data, X_data)
write.table(combined, "all_data_combined.txt")


## 5. Create a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

distinctSubjects = unique(Subject_data)[,1]
numSubjects = length(unique(Subject_data)[,1])
numActivities = length(label[,1])
numCols = dim(combined)[2]
result = combined[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = distinctSubjects[s]
    result[row, 2] = label[a, 2]
    tmp <- combined[combined$subject==s & combined$activity==label[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "dataset_averages.txt", row.names = FALSE)
