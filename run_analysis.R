# Step1. Merge the train and the test datasets to create one dataset.
# setwd("~/Desktop/Coursera_R Programming/getting_cleaning_data/Project/Course-Getting-and-Cleaning-Data-Project")

# Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and 
# store them in variables called trainData, trainLabel and trainSubject respectively.
trainData <- read.table("./data/train/X_train.txt")
dim(trainData)       
head(trainData)
trainLabel <- read.table("./data/train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("./data/train/subject_train.txt")

# Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and 
# store them in variables called testData, testLabel and testsubject respectively.
testData <- read.table("./data/test/X_test.txt")
dim(testData)       
testLabel <- read.table("./data/test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("./data/test/subject_test.txt")

# Concatenate testData to trainData to generate a 10299x561 data frame, joinData; 
# concatenate testLabel to trainLabel to generate a 10299x1 data frame, joinLabel; 
# concatenate testSubject to trainSubject to generate a 10299x1 data frame, joinSubject.
joinData <- rbind(trainData, testData)
dim(joinData)      
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel)     
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject)   

# Step 2. Extract only the measurements on the mean and 
# standard deviation for each measurement. 

# Read the features.txt file from the "/data" folder and store the data in a variable called features. 
features <- read.table("./data/features.txt")
dim(features)           
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices)   
joinData <- joinData[, meanStdIndices]
dim(joinData)            

# Clean the column names of the subset. We remove the "()" and "-" symbols in the names, 
# as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData))           # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData))             # capitalize S
names(joinData) <- gsub("-", "", names(joinData))                  # remove "-" in column names 

# Step 3. Use descriptive activity names to 
# name the activities in the dataset

# Read the activity_labels.txt file from the "./data"" folder and 
# store the data in a variable called activity.
activity <- read.table("./data/activity_labels.txt")

# Clean the activity names in the second column of activity. 
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))

# Step 4. Appropriately label the dataset with descriptive activity names. 

# Transform the values of joinLabel according to the activity data frame.
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"
names(joinSubject) <- "subject"

# Step 5. Create a second, independent tidy dataset with the average of 
# each variable for each activity and each subject. 

# Combine the joinSubject, joinLabel and joinData by column to 
# get a new cleaned 10299x68 data frame, cleanedData.
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData)   

# Generage first tidy dataset "merged_data.txt"
write.table(cleanedData, "merged_data.txt") 

# Properly name the first two columns, "subject" and "activity".
subjectLen <- length(table(joinSubject)) # integers ranging from 1 to 30 inclusive
activityLen <- dim(activity)[1] # the column contain 6 kinds of activity names
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == cleanedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
head(result)
# Generage the second tidy dataset "data_with_means.txt"
write.table(result, "data_with_means.txt") 
