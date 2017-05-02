# GettingandCleaningData
Coursera Getting and Cleaning Data Final Assignment
This is the course project for the Getting and Cleaning Data Coursera course.
The R script file, `run_analysis.R`, does the following:

1. Check if there exists a data file. If not, then create, else locate the data 
   at the source and download from the source. This step can be skipped if the
   data is already downloaded.
2. Unzip the downloaded data into the data folder   
3. Read Features files into data frames
4. Read Subject files into data frames
5. Read Activity files into data frames
6. Bind training and test datas together for each of the data frame couples
7. Assign names to data frames "Activity" and "Subjects"
8. Extract the Features data names and assigning them to the Features data columns
9. Merge all the tables into one : This fulfills assignment section 1
10. Extract only the measurements on the mean and standard deviation for each measurement.
   This fulfills assignment section 2
11. Add descriptive activity names to the data set: Fulfills assignment section 3
12. Label the data set with descriptive variable names: Fulfills assignment section 4
13. Create a second, independent tidy data set with the average of each variable for 
   each activity and each subject. The writes the output to tidydata.txt: Fulfills the 
   requirement for section 5

 The end result is shown in the file `tidy.txt`.
