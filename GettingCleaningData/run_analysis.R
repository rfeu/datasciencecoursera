#Load libraries used in the script
#If you do not have the following libraries installed, please download them with the function install.packages()
library(downloader)
library(reshape2)
library(plyr)

#Create folder "dataset" if this folder does not exist in your working directory
 if (!file.exists("dataset")){
    dir.create("dataset")
    }
 setwd("dataset")

#Download the dataset if the dataset is not already in the "dataset" folder
 if (!file.exists("UCI_HAR_Dataset.zip")){
    fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download(fileurl, destfile = "UCI_HAR_Dataset.zip", mode = "wb")
    datedowloaded <- date()
    }
 list.files()

#Unzip the dataset if the dataset has not been unzipped
 if (!file.exists("UCI HAR Dataset")){
    unzip ("UCI_HAR_Dataset.zip")
    }

#Read x,y and subject test files and merge them into "mergedTest"
mergedTest <- do.call(cbind, lapply(dir("UCI HAR Dataset/test", pattern = "\\.txt$", full.names= TRUE), read.table))

#Read x,y and subject train files and merge them into "mergedTrain"
mergedTrain <- do.call(cbind, lapply(dir("UCI HAR Dataset/train", pattern = "\\.txt$", full.names= TRUE), read.table))

#Merge "mergedtrain" and "mergedtest" into "totalMerged"
totalMerged <- rbind(mergedTest, mergedTrain)
dim(totalMerged)

#Read the column names from "features" file
#Turn everything into lower cases
#Add two names to the vector "features": "subject" & "activity"
features <- read.table ("UCI HAR Dataset/features.txt")
features <- tolower(features[,2])
features <- c("subject",features,"activity")

#Assign names in "features" vector to the "totalMerged" dataset
names(totalMerged) <- features

#Extracts only measurements on the mean and standard deviation for each measurement
meanStdCol <- grep("mean\\(\\)|std\\(\\)", names(totalMerged))
meanStdCol <- c(1,meanStdCol,dim(totalMerged)[2])
dataMeanStd <- totalMerged[ ,meanStdCol]

#Uses descriptive activity names to name the activities in the data set
dataMeanStd$activity <- as.factor(dataMeanStd$activity)
activitylabels <- read.table ("UCI HAR Dataset/activity_labels.txt")
levels(dataMeanStd$activity) <- activitylabels[,2]

#Appropriately labels the data set with descriptive variable names
#Remove the following characters: ()-
names(dataMeanStd) <- gsub("-","",names(dataMeanStd))
names(dataMeanStd) <- gsub("\\(\\)","",names(dataMeanStd))
names(dataMeanStd) <- gsub("mag","magnitude", names(dataMeanStd))
names(dataMeanStd) <- sub("^t","time", names(dataMeanStd))
names(dataMeanStd) <- sub("^f","fourier", names(dataMeanStd))

#Transform the merged data into long tidy data
# Calculate the average of each variable for each activity and each subject
#Export this tidy data set into a text file in your working directory
meltedData <- melt(dataMeanStd, id = c("subject","activity"), variable.name = "measurement", value.name = "measurement_value")
tidyData <- ddply (meltedData, .(subject, activity,measurement), summarize, mean_measurement = mean(measurement_value))
setwd("..")
write.table (tidyData, file = "tidyData.txt")