library(dplyr)
setwd("~/RCode/GettingData/Project/TidyData")

dateDownloaded <- format(Sys.Date(), "%m%d%Y")
fileName <- paste("projectSet", dateDownloaded, ".zip")

if(!file.exists(fileName))
{
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, destfile=fileName, method = "curl", extra ="-k")
}

activities <- read.table(unzip(fileName,files=c("UCI HAR Dataset/activity_labels.txt"),overwrite=TRUE))
names(activities) <- c("Activity.Code", "Activity.Name")
features <- read.table(unzip(fileName,files=c("UCI HAR Dataset/features.txt"),overwrite=TRUE))
names(features) <- c("Feature.Code", "Feature.Name")

# train/X_train.txt: Training set.
# train/y_train.txt: Training labels.
# test/X_test.txt: Test set.
# test/y_test.txt: Test labels.

# Read the Test and Train Data Sets
xtrDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/train/X_train.txt"),overwrite=TRUE))
ytrDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/train/y_train.txt"),overwrite=TRUE))
strDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/train/subject_train.txt"),overwrite=TRUE))
xtstDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/test/X_test.txt"),overwrite=TRUE))
ytstDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/test/y_test.txt"),overwrite=TRUE))
ststDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/test/subject_test.txt"),overwrite=TRUE))

# ==================================================================
# 1. Merges the training and the test sets to create one data set.
# Merge Test and Train of X Data
xallDf <- rbind(xtrDf, xtstDf)

# Merge Test and Train of Y Data
yallDf <- rbind(ytrDf, ytstDf)

# Merge Test and Train of subject Data
sallDf <- rbind(strDf, ststDf)
names(sallDf) <- c("Subject.Number")

# End of 1
# ==================================================================

# ==================================================================
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Find which columns in X are Mean and Std deviation Columns using REGEXP
meanStdColumns <- grep("mean|std", features$Feature.Name)

# ==================================================================
# 3. Uses descriptive activity names to name the activities in the data set
# Create a new column in the data frame with the activity name from the
# activity code set provided in the Zip
yallDf$Activity <- activities[yallDf$V1, "Activity.Name"]
names(yallDf) <- c("Activity.Code","Activity.Name")

# End of 3
# ==================================================================

meanStdDf <- data.frame(sallDf)
meanStdDf <- cbind(sallDf, yallDf)

# For each of the column names that looks like it's a standard deviation
# or mean add to the new data frame and label with the appropriate name
# from the features text file in the Zip
for(i in meanStdColumns)
{
  # Grab the column that matched the grep
  newCol <- xallDf[i]
  
  # ---------------------------------------------------------------------
  # 4. Appropriately labels the data set with descriptive variable names. 
  # Rename the column with the name from the feature text file
  names(newCol) <- features$Feature.Name[i]
  # End of 4
  # ---------------------------------------------------------------------
  
  # Add column to the data frame
  meanStdDf <- cbind(meanStdDf, newCol)  
}

# End of 2
# ==================================================================

# ===================================================================================
# 5. From the data set in step 4, creates a second, independent tidy data set with
#    the average of each variable for each activity and each subject.


finalDf <- meanStdDf %>% group_by(Subject.Number, Activity.Code, Activity.Name) %>% summarise_each(funs(mean))
# Please upload the tidy data set created in step 5 of the instructions.
# Txt file created with write.table() using row.name=FALSE
write.table(finalDf, file="final_tidy_data.txt", row.name=FALSE)
