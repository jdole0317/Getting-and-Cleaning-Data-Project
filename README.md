# Getting-and-Cleaning-Data-Project
Final project for getting and cleaning data course

This README describes each step of the script.


STEP 1: Read in the data
==============================
Using the read.table() function, each text data file was read into R
Data files include:
X_test.txt
Y_test.txt
subject_test.txt
X_train.txt
Y_train.txt
subject_train.txt

The file features.txt was also read into R for reference.

============================================================
STEP 2: Column names for 4 files
============================================================
V1 in the subject files was renamed to SubjectID
V1 in the y files was renamed to Activity

============================================================================================================
STEP 4: Merge the data
============================================================================================================
Each of the test files are combined by column to create a data frame called merged_test of 2947 observations 
of 563 variables.
Each of the train files are combined by column to create a data frame called merged_train of 7352 observations 
of 563 variables.
These two files were combined by row to create a data frame called combined with 10299 observations of 563 
variables.

============================================================================================================
STEP 5: Select only the columns that include means and standard deviatoins
============================================================================================================
After identifying which columns include mean or standard deviation. Used the select() function to create a 
new data frame called df that selects by index, only the columns in the combined dataset that include mean
and standard deviation.

============================================================================================================
STEP 6: Add descriptive names to name the activities in the df data frame
============================================================================================================
Recoded each activity (1-6) to match the corresponding activity lables. 
1=Walking
2=Walking_Upstairs
3=Walking_Downstairs
4=Sitting
5=Standing
6=Laying

============================================================================================================
STEP 7: Label the remaining variables with descriptive variable names
============================================================================================================
Used the colnames() function to add descriptive names to each of the measurements

============================================================================================================
STEP 8: Create a tidy data set with average of each variable for each activity and subject
============================================================================================================
Used the group_by() function to group the data by SubjectID and Activity and then summarized all the columns
to get the mean of each variable for each subject and activity. This creates one row per subjectID-activity
pair and the averages of all the observations for each variable for each pair. The resulting data frame was 
called df2 and includes 180 observations of 66 variables and 30 SubjectID-Activity pairs.

============================================================================================================
STEP 9: Save data set
============================================================================================================
Used the write.csv() function to save the df2 data frame as finalproject.csv
