## Data
The data set being analyzed is Human Activity Recognition Using Smartphones.
The data was obtained [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The data itself can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
Information about the contents of the data set can be found in the README.txt of the package.

## Variables
* `x_train`, `y_train`, `subject_train`, `x_test`, `y_test`, and `subject_test` contain the corresponding training and test data from the data set. 
* `features` contains the column names of the `x_train` and `x_test` data.
* `activity_labels` contains the column names for `activity ID` and `activity type`.
* `train`, `test` contain the above variables column-merged.
* `data` contains the above data row-merged.
* `dataColNames` contains all of the the column names of `data`.
* `meanAndStd` contains the pattern matching search to match for mean and standard deviation columns.
* `meanAndStdData` contains the mean and standard deviation data.
* `dataWithActivityLabels` contains the mean and standard deviation data with the Activity type column.
* `meanData` contains the tidy data set with the average of each variable for each activity and each subject.

## Process
1. Merge the training and test sets to create one data set.
  a. Download and unzip the data.
  b. Read each file and store in individual variables.
  c. Assign descriptive column names to each variable.
  d. Column bind all train data into `train` and all test data into `test`. Row bind `train` and `test` into `data`.
2. Extract the measurements on the mean and standard deviation for each measurement.
  a. Read the column names of `data`
  b. Define the column names to be extracted: ActivityID, SubjectID, and columns containing "mean" or "std".
  c. Store mean and standard deviation data in its own variable `meanAndStdData`.
3. Use descriptive activity names to name the activities in the data set.
  a. Merge `activity_labels` and `meanAndStdData` into `dataWithActivityLabels` by using `ActivityID` as key
4. Appropriately labels the data set with descriptive variable names. (see step 1.c.)
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
  a. Aggregate mean and standard deviation data by SubjectID and ActivityID, and store the mean of each variable in `meanData`. 
  b. Write `meanData` into `meanData.txt`.