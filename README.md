## Getting-cleaning-data-project

This repository is the course project for the Johns Hopkins Data Science track course "Getting and Cleaning Data" in Coursera.

### Overview

The purpose of this project is to demonstrate how to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

A full description of the data source is available at the website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data used for this project is:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Files 

CodeBook.md describes the variables, the data, and any transformations or work that was performed to clean up the data.

run_analysis.R contains all the code to perform the analyses described in the 5 steps. They can be launched in RStudio by just importing the file. 

### R Script will Perfrom the Following 5 Steps

Step 1: Merge the train and the test datasets to create one joint dataset.

Step 2: Extract only the measurements on the mean and standard deviation for each measurement. 

Step 3: Use descriptive activity names to name the activities in the dataset.

Step 4: Appropriately label the dataset with descriptive activity names. 

Step 5: Create a second, independent tidy dataset with the average of each variable for each activity and each subject. 

The output of step 5 are two files: merged_data.txt" and "data_with_means.txt". They are included in this repository.

### Libraries

This script automatically loads the following libraries:

plyr

reshape2