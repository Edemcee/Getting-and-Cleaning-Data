Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The run_analysis.R script cleans up the data by:

1. Merging the training dataset namely X_train, y_train, subject_train to their corresponding X_test, y_test,    subject_test in the test datasets to create one seamless data set. Thus
   * X_train.txt is merged with X_test.txt
   * y_train.txt is merged with y_test.txt
   * subject_train.txt is merged with subject-test.txt
   using the rbind() function


2. Extracting the measurements on the mean and standard deviation for each measurement from the       features.txt 


3. Applying the appropriate descriptive activity names extracted from the activity_labels.txt dataset to the      respective    activities in the activities dataset. The descriptive names are:
   * walking
   * walkingupstairs
   * walkingdownstairs
   * sitting
   * standing
   * laying
   The labels are converted to lower case while underscores and paranthesis are removed



4. Labelling the dataset with the appropriate descriptive names and then merging all 3 datasets namely    Subject_data,         Y_data and X_data into a single data frame.


5. Creating a 2nd, independent tidy data set with the average of each measurement for each activity and each    subject. 
The resultant data is save as dataset_averages using the write.table() function with       row.name=FALSE option. 
