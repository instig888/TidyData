# TidyData
Course project for Getting and Cleaning and Data
The intent of this README.md file is to provide context and understanding of how the
provided scripts manage the data set.

The run_analysis.R script contained in this repository does all of the associated manipulation of the data sets.
The data sets are contained in a zip file and represent a series of measurements taken from the accelerometer
of a Galaxy S II.  See the README.txt file in the associated zip for details on the experiment.

# Purpose
The related zip file:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Contains all the related "raw" data from the experiments that are available for this project.
*Original experiment related site http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones*

## Original Files
**activity_labels.txt** provides the activity names for the activity codes associated with the observation data in the y_*.txt files.
**features.txt** provides the raw variable names for the observations in the x_*.txt
**features_info.txt** provides information on what the variables represent in relation to the readings from the phone and how they were calculated.
**y_train.txt** & **y_test.txt** the list of activity codes for the related observations (divided into a train and test file)
**x_train.txt** & **x_test.txt** the list of hardware readings for the related observations (divided into a train and test file)
**subject_train.txt** & **subject_test.txt** the list of subject identifiers to align which measurements were related to a specific individul (dividied into a train and test file).

## Intention of the analysis script
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Script Explained
The run_analysis.R script, downloads the experiment data in the zip file format, unpacks the desired files to a local working data, aligns and merges all of the related data files to each other and finally performs some statistical analsysis by group across all the observations.

1. Script loads necessary libraries (dplyr) and sets the working directory.  It currently assumes a specific working directory, rather than creating it if it doesn't exist it simply assumes the current directory should be leveraged.
2. We get a formated version of today's date.  We leverage that date to create the name of local file we're going to download the zip to.  Check for the existance of that file, download if it does not exist.  (Will only execute 1 time a day).
3. Read the activity codes and labels in from the associate text file and modify the variable names to be more descriptive. *In all of these examples we unzip the files inside of a read.table command to avoid having to pass around file names.*
4. Read the feature labels (variable names) in from the associated text file and modify the varaiable names of this data set (not the read in variables) to be more descriptive.
5. Read in the measurements, subject identifiers, and activity data for the related observations (test & train) into related data frames.
6. Use rbind to append the test data to the train data for each of these categories of data. *We now have the complete observations in each category merged into 3 aligned data frames.  *Need to be certain that we merge the related observations in the same order to they line up across the multiple files.*
7. Create a descriptive variable "Subject.Number" for the merged subject id data frame.
8. Using grep against the feature names, get a list of all the columns that represent Standard Deviation measurements or Means.  grep("mean|std").  This is the fastest way to pair down the larger list of variables to only these specific types of measurements. 
9. Add a column to the activity code datat frame (yallDf) which pulls in the descriptive label for each code in the observation list from the activities data frame.  Appropriately label the variables in the resulting data frame.
10. Create a new data frame to house our tidy data set.  Initialize it with the subject ids for each observation and bind the activity codes and labels to the right.  We call this the meanStdDf.
11. Now iterate through the meanStdColumns vector created by the earlier grep on the feature names.  For each column bind the observations related to that variable to the right of our new meanStdDf.  In this way we're adding only the mean and standard deviation related variables/observation to our new data set.
12. Rename the new variable to match the feature name.  *We now have a set of data where all of the data has been merged across the related files, labels are applied to the activities and the measurements are labeled by subject identifier.*




