# This is a Repo for the final projec of Getting and Cleaning Data on Coursera Data Science specialization.

## Info about data transformation

# General Info

In this Repo you will find a R script to work with, and clean a data set collected from the accelerometers from the Samsung Galaxy S smartphone. The goal is to prepare tidy data that can be used for later analysis.

To work with the script in this Repo, there are some required R packages. The script will check it and, in case of some package absent, it will install it.

Futhermore, this R script considers that you already have downloaded the data into your current working directory. So, it is important to download the data from the link below and extract the "UCI HAR Dataset" folder into your working directory:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After that, just open the R and run the script "run_analysis.R" with source() function.

# Script

The script will do the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

More details about the steps are described inside the script code as comments.

# Variables

More details about the data and variables are found on code book.
