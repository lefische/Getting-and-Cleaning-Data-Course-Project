Readme
================
Leo Fischer
05 03 2021

## Analyse wearable computing data

In this script i analyzed wearable computing data from the Samsung
Galaxy S smartphone.
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

we proceeded in the following way:

-   Read files
    -   read test and training data
-   Merges the training and the test sets to create one data set.
    -   merge and combine all dataframes
-   Extracts only the measurements on the mean and standard deviation
    for each measurement.
    -   filter the data with dplyr select
-   Uses descriptive activity names to name the activities in the data
    set
    -   change column names and change order
-   Appropriately labels the data set with descriptive variable names.
    -   rename columns
-   create a second, independent tidy data set with the average of each
    variable for each activity and each subject.
    -   group\_by activity and subject
