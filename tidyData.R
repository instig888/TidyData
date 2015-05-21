setwd("~/RCode/GettingData/Project/TidyData")

dateDownloaded <- format(Sys.Date(), "%m%d%Y")
fileName <- paste("projectSet", dateDownloaded, ".zip")

if(!file.exists(fileName))
{
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, destfile=fileName, method = "curl", extra ="-k")
}

# train/X_train.txt: Training set.
# train/y_train.txt: Training labels.
# test/X_test.txt: Test set.
# test/y_test.txt: Test labels.

xtrDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/train/X_train.txt"),overwrite=TRUE))
ytrDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/train/y_train.txt"),overwrite=TRUE))
xtstDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/test/X_test.txt"),overwrite=TRUE))
ytstDf <- read.table(unzip(fileName,files=c("UCI HAR Dataset/test/y_test.txt"),overwrite=TRUE))
