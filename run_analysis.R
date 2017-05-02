

# Locate the data at the source and download from the source
# Skip this section below until the section with header "Read Features files",
# if you have the data set in the memory with the address: "./data/UCI HAR Dataset"
# I use libcurl instead of curl as method since I don't use RStudio
# mode= "wb" is required for downloading zip files 

if (!file.exists("./data")) {dir.create("./data")} 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file (fileUrl, destfile = "./data/DataSet.zip", method = "libcurl", mode = "wb")

# Unzip the file to "data" folder

unzip(zipfile = "./data/DataSet.zip", exdir = "./data")

# Read Features files

datFeatTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
datFeatTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)

# Read Subject Files

datSubjTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
datSubjTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# Read Activity Files

datActivTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
datActivTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)

# Bind training and test data sets together

dataFeatures <- rbind(datFeatTest, datFeatTrain)
dataSubject <- rbind(datSubjTest, datSubjTrain)
dataActivity <- rbind(datActivTest, datActivTrain)

# Assigning names to data frames

names(dataSubject) <- "Subject"
names (dataActivity) <- "Activity"

# Extracting the Features data names 

dataFeaturesNames <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE)
names(dataFeatures) <- dataFeaturesNames$V2

# Merge all the tables into one : This fulfills assignment section 1

dataMerge <- cbind(dataSubject, dataActivity)
dataMerge <- cbind(dataMerge, dataFeatures)

# Section below extracts only the measurements on the mean and standard deviation for each measurement. 

subg_dataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
filteredNames <- c("Subject", "Activity" , as.character(subg_dataFeaturesNames))
dataMerge <- subset(dataMerge, select = filteredNames) # This fulsills assignment section 2

# Section below adds descriptive activity names to the data set: Fulfills assignment section 3

actLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)
dataMerge$Activity <- actLabels[dataMerge$Activity,2]

# Section below appropriately labels the data set with descriptive variable names: Fulfills assignment section 4

# * Acc is replaced by Accelerometer
# * BodyBody is replaced by Body
# * Gyro is replaced by Gyroscope
# * Mag is replaced by Magnitude
# * prefix f is replaced by frequency
# * prefix t is replaced by time

names(dataMerge)<-gsub("Acc", "Accelerometer", names(dataMerge))
names(dataMerge)<-gsub("BodyBody", "Body", names(dataMerge))
names(dataMerge)<-gsub("Gyro", "Gyroscope", names(dataMerge))
names(dataMerge)<-gsub("Mag", "Magnitude", names(dataMerge))
names(dataMerge)<-gsub("^f", "frequency", names(dataMerge))
names(dataMerge)<-gsub("^t", "time", names(dataMerge))

# Section below creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject. The writes the output to tidydata.txt
# Section below fulfills the requirement for section 5

library(plyr)
dataTidy <- aggregate(. ~Subject + Activity, dataMerge, mean)
dataTidy <- dataTidy[order(dataTidy$Subject, dataTidy$Activity),]
write.table(dataTidy, file = "tidydata.txt", row.name = FALSE)

# End of the file

