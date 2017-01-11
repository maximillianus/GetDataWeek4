#run_analysis.R

run_analysis <- function()
{
	suppressMessages(library(dplyr))

	##set directory. Assume in our working directory, there is
	##UCI HAR Dataset unzipped directory
	setwd("UCI HAR Dataset/")
	
	#rows to read
	n <- -1
	
	##Extracts only measurement on mean & std deviation
	#check which column number provided mean & std measurement
	features <- read.table("features.txt")
	v <- grep(".*[Mm]ean|[Ss]td",features[,2])
	f <- rep("NULL", length(features[,1]))
	f[v] <- NA

	##Read training and test data set
	##Read only required column with mean & std deviation to save resources
	testvariables <- read.table("test/X_test.txt", nrows=n, colClasses=f) #test data set
	trainvariables <- read.table("train/X_train.txt", nrows=n, colClasses=f) #training data set 

	#Add the rows to merge
	testtrain <- rbind(testvariables, trainvariables)
	rm(testvariables, trainvariables) ##free up memory space
		
	##remove unneeded column number using index in df and name the variable
	#testtrain <- testtrain[,features[,1]]
	features <- features[(grep(".*[Mm]ean|[Ss]td",features[,2])),]
	names(testtrain) <- features[,2]

	##Name the activity in the data set
	#create activity dataframe
	activity <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
	
	#read in labels and combine them 
	testlabels <- read.table("test/y_test.txt", nrows=n)
	trainlabels <- read.table("train/y_train.txt", nrows=n)
	testtrainlabels <- rbind(testlabels, trainlabels)

	#read in subject and combine them
	testsubject <- read.table("test/subject_test.txt", nrows=n)
	trainsubject <- read.table("train/subject_train.txt", nrows=n)
	testtrainsubject <- rbind(testsubject, trainsubject)

	#relate labels with the name
	for(i in 1:length(testtrainlabels[,1]))
	{
		testtrainlabels$V2[i] <- activity[testtrainlabels[i,1], "V2"]
	}
	
	#name the subject and labels
	names(testtrainlabels)[1] <- "Activity.Code"
	names(testtrainlabels)[2] <- "Activity.Name"
	names(testtrainsubject)[1] <- "Subject"
	
	#Join subject and labels
	testtrainsublab <- cbind(Subject=testtrainsubject[,1], testtrainlabels)

	#Join everything
	testtrain <- cbind(testtrainsublab, testtrain)
	
	##Group by subject & activity name, summarize for mean, re-order
	newdf <- testtrain %>% group_by(Subject, Activity.Name) %>% summarise_each(funs(mean)) %>% arrange(Subject, Activity.Code)
	

	##Output to csv file outside UCI HAR Dataset directory
	setwd("..")
	if (file.exists("tidydata.csv") == TRUE)
	{
		file.remove("tidydata.csv")
	}
	write.csv(testtrain, file="tidydata.csv", row.names=FALSE)

	if (file.exists("tidydata_groupmean.csv") == TRUE)
	{
		file.remove("tidydata_groupmean.csv")
	}
	write.csv(newdf, file="tidydata_groupmean.csv", row.names=FALSE)
	
	rm(list=ls())
	detach("package:dplyr")

}