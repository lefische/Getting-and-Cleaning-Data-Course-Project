
# The submitted data set is tidy. 
# The Github repo contains the required scripts.
# GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, 
# along with units, and any other relevant information.
# The README that explains the analysis files is clear and understandable.
# The work submitted for this project is the work of the student who submitted it.


# You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
library(stringr)


# read files
activity_labels  <- read.csv("./UCI\ HAR\ Dataset/activity_labels.txt", sep=" ", header = FALSE, col.names = c("id", "activity"))
features <- read.csv("./UCI\ HAR\ Dataset/features.txt", sep=" ", header = FALSE, col.names = c("id", "feature"))

# read the test data
subject_test <- read.csv("./UCI\ HAR\ Dataset/test/subject_test.txt", sep=" ", header = FALSE, col.names = "subject")
x_test <- read.csv("./UCI\ HAR\ Dataset/test/X_test.txt", sep="", header = FALSE, dec = ".", col.names = features$feature)
y_test <- read.csv("./UCI\ HAR\ Dataset/test/Y_test.txt", sep="", header = FALSE, dec = ".", col.names = "activity_id")

# read the train data
subject_train <- read.csv("./UCI\ HAR\ Dataset/train/subject_train.txt", sep=" ", header = FALSE, col.names = "subject")
x_train <- read.csv("./UCI\ HAR\ Dataset/train/X_train.txt", sep="", header = FALSE, dec = ".", col.names = features$feature)
y_train <- read.csv("./UCI\ HAR\ Dataset/train/Y_train.txt", sep="", header = FALSE, dec = ".", col.names = "activity_id")

# 1. Merges the training and the test sets to create one data set.

xdata <- rbind (x_test, x_train) ; rm (x_test, x_train) # merge and remove unused df
ydata <- rbind (y_test, y_train) ; rm (y_test, y_train) # merge and remove unused df
subjectdata <- rbind (subject_test, subject_train) ; rm (subject_test, subject_train) # merge and remove unused df

# combine dataframes
fulldf <- cbind(xdata, ydata, subjectdata)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
measure_sel <- fulldf %>% select (activity_id, subject, contains("mean"), contains("std")) ; rm (fulldf)

# 3. Uses descriptive activity names to name the activities in the data set
measure <- inner_join(measure_sel,activity_labels, by = c("activity_id" = "id")); rm(measure_sel)
measure <- measure %>% select (activity, subject, contains("mean"), contains("std")) # change order of columns

# 4. Appropriately labels the data set with descriptive variable names. 

names(measure) <- str_replace(names(measure), "Gyro", "_Gyroscope_")
names(measure) <- str_replace(names(measure), "Acc", "_Accelerometer_")


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- measure %>% group_by(activity, subject) %>% summarize_all (list(mean))

# Write Data to disk
write.table(tidydata, "./tidydata.txt", row.name=FALSE)

