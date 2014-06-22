# Original dataset
## Source
The original dataset was downloaded on June 21st, 2014 from  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This original source for this dataset is the following publication:
>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Description
This dataset is the result of the following experiment:
>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

For more information about the original dataset, please refer to the `README.txt` file in the zip file.

# Tidy dataset
## Transformation
To obtain a tidy dataset based on the original dataset, we wrote the script `run_analysis.r` which performs the following transformations:

1. Merge the two partitions (training data and test data) of the original dataset into one.
2. Use the names contained in `features.txt` from the original dataset to name the variables of our merged dataset.
3. Extract only the measurements on the mean and standard deviation for each measurement.  
We decided to exclude meanFreq() as well as gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, tBodyGyroJerkMean from the original dataset because these variables are not measurements but additional vectors obtained by averaging the signals.
4. Use descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The result of `run_analysis.r` is a file called `tidyData.txt` with 11,880 observations and 4 variables.

## Variables
The final tidy dataset has four different variables:

1. "subject": subject ID. Can take a value between 1 and 30. 
2. "activity": activity performed by the volunteer. Can take six different values:WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  
3. "measurement": please refer to the file "features_info" in the original dataset for more information. Among all the features possible, we have only selected the mean (features ending with mean()) and the standard deviation (ending with sd()).
4. "measurement_mean": mean value of each measurement.

## Note about tidy data
Our tidy dataset follows Hadley Wickham's definition of tidy data:
1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.
