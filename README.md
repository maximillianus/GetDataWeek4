#**GetDataWeek4**
*Repository for Coursera Project for Week 4 of Getting and Cleaning Data*

###**Files**
There will be 3 files in this repository:

1. run_analysis.R : the script to analyze data and output tidy data
2. CodeBook.md : A code book that explains the script, the data, and the output files.
3. README.md : Read this README file first to understand all the files and scripts in this repository.

###**Explanation on run_analysis.R**

This script assumes that the working directory contains a folder of unzipped package downloaded from this link (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Here is the step-by-step algorithm process it runs:

1. set working directory to the folder containing necessary files.
2. read features.txt files and extract out the positions of all the necessary mean and std variables and save it into a vector 'f'.
3. read the required columns variables in the test and train data files based on the vector f (vector f contains NA and NULL values which sums up to 561, the same number of columns in the data files. NA colClass will read in the column and NULL colClass will omit the column) then combine them into a single dataframe. Remove the test and train dataframes to free up memory space.
*4. Name the variables inside the combined dataframe.
5. Read in Activity names, Activity Labels, and Subjects for each test and train datasets.
6. Name the subject and activity labels and join all of them into single dataframe.
7. Combine the Subject and Activity label dataframe with the test & train variables dataframe to make a single tidied up dataframe.
8. Create another independent dataframe which summarizes the mean for each variables and group them based on Subject and Activity. Then sort this based on Subject and Activity.
9. reset working directory
10. Output 1 file: tidydata_groupmean.txt. I believe this dataset follows the principle of tidy data as there is only 1 variable per column and 1 observation per rows. I have also sorted the activity per subject to give a better presentation of the dataset

11. detach all library packages



