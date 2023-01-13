# Getting and Cleaning Data Final Project #####################################

# create R script called run_analysis that 
## 1. Merges the training and the test sets to create one data set
## 2. Extracts only the measurements on the mean and stand dev for each measurement
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names
## 5. From data set in step 4, create a 2nd, independent tidy data set with average
##    of each variable for each activity and each subject

setwd("C:/Users/jdole/OneDrive - Research Triangle Institute/Related to R/Coursera/Getting and Cleaning Data")
getwd()

# Load packages
library(tidyr)
library(dplyr)

# Read in the data
  # subject file = list of subjects
  # x file = set
  # y file = labels

features.txt<-read.table("./UCI HAR Dataset./features.txt") 
# use this to see which variable names (columns) need to be extracted for mean and st.dev

subject_test<- read.table("./UCI HAR Dataset./test/subject_test.txt")
x_test<-read.table("./UCI HAR Dataset./test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset./test/Y_test.txt")

subject_train<-read.table("./UCI HAR Dataset./train/subject_train.txt")
x_train<-read.table("./UCI HAR Dataset./train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset./train/Y_train.txt")

# Add column names to Subject and Activity files
subject_test<-rename(subject_test, "SubjectID" = V1)
y_test<-rename(y_test, "Activity" = V1)


subject_train<-rename(subject_train, "SubjectID" = V1)
y_train<-rename(y_train, "Activity" = V1)

# Merge data frames
merged_test<-cbind(x_test, y_test, subject_test)
merged_train<-cbind(x_train, y_train, subject_train)
combined<-rbind(merged_test, merged_train)


# Extract measurements on the mean and standard deviation for each measurement
  ## tBodyAcc 1-6, tGravityACC 41-46, tBodyAccJerk 81-86, tBodyGyro 121-126,
  ## tBodyGyroJerk 161-166, tBodyAccMag 201-202, tBodyAccJerkMag 227-228, tBodyGyroMag 240-241
  ## tBodyGyroJerkMag 253-254, fBodyAcc 266-271, fBodyAccJerk 345-350, fBodyGyro 424-429
  ## fBodyAccMag 503-504, fBodyBodyAccJerkMag 516-517, fBodyBodyGryoMag 529-530
  ## fBodyBodyGryoJerkMag 542-543

df<- combined%>%
  select(562, 563, 1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 227:228, 240:241,
         253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)

# Use descriptive activity names to name the activities in the data set
df$Activity[df$Activity == 1] <- "Walking"
df$Activity[df$Activity == 2] <- "Walking_Upstairs"
df$Activity[df$Activity == 3] <- "Walking_Downstairs"
df$Activity[df$Activity == 4] <- "Sitting"
df$Activity[df$Activity == 5] <- "Standing"
df$Activity[df$Activity == 6] <- "Laying"

# Appropriately label the data set with descriptive variable names
colnames(df)<-c("Activity", "SubjectID", "body_accelX_time_mean", "body_accelY_time_mean", "body_accelZ_time_mean","body_accelX_time_std",
                "body_accelY_time_std", "body_accelZ_time_std", "gravity_accelX_time_mean", "gravity_accelY_time_mean",
                "gravity_accelZ_time_mean", "gravity_accelX_time_std", "gravity_accelY_time_std", "gravity_accelZ_time_std",
                "bodyjerk_accelX_time_mean",  "bodyjerk_accelY_time_mean",  "bodyjerk_accelZ_time_mean",  "bodyjerk_accelX_time_std",
                "bodyjerk_accelY_time_std",  "bodyjerk_accelZ_time_std", "body_gyroX_time_mean", "body_gyroY_time_mean",
                "body_gyroZ_time_mean", "body_gyroX_time_std", "body_gyroY_time_std", "body_gyroZ_time_std", "bodyjerk_gyroX_time_mean",
                "bodyjerkY_gyro_time_mean", "bodyjerkZ_gyro__timemean","bodyjerkX_gyro_time_std", "bodyjerk_gyroY_time_std", "bodyjerk_gyroZ_time_std",
                "body_accel_magnitude_time_mean", "body_accel_magnitude_time_std", "bodyjerk_accel_magnitude__time_mean", "bodyjerk_accel_magnitude_time_std",
                "body_gyro_magnitude_time_mean", "body_gyro_magnitude_time_std", "bodyjerk_gyro_magnitude_time_mean", "bodyjerk_gyro_magnitude_time_std",
                "body_accelX_freq_mean", "body_accelY_freq_mean", "body_accelZ_freq_mean", "body_accelX_freq_std", "body_accelY_freq_std", "body_accelZ_freq_std",
                "bodyjerk_accelX_freq_mean", "bodyjerk_accelY_freq_mean", "bodyjerk_accelZ_freq_mean", "bodyjerk_accelX_freq_std", "bodyjerk_accelY_freq_std",
                "bodyjerk_accelZ_freq_std", "body_gyroX_freq_mean", "body_gyroY_freq_mean", "body_gyroZ_freq_mean", "body_gryoX_freq_std", "body_gryoY_freq_std",
                "body_gryoZ_freq_std", "body_accel_magnitude_freq_mean", "body_accel_magnitude_freq_std", "bodyjerk_accel_magnitude_freq_mean",
                "bodyjerk_accel_magnitude_freq_std", "body_gryo_magnitude_freq_mean", "body_gryo_magnitude_freq_std", "bodyjerk_gyro_magnitude_freq_mean",
                "bodyjerk_gyro_magnitude_freq_std")

# Create a 2nd, independent tidy data set with average of each variable for each 
# activity and each subject


df2<-df%>%
  group_by(SubjectID, Activity)%>%
  summarize_all("mean")

write.csv(df2, "finalproject.csv")
