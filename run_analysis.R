# Load training_data 

training=read.csv("C:/Users/burak/Desktop/johnshopkins/week4/courseproject/getdata%2Fprojectfiles%2FUCIHARDataset/UCIHARDataset/train/X_train.txt", sep = "", header = FALSE)
training[,562]=read.csv("C:/Users/burak/Desktop/johnshopkins/week4/courseproject/getdata%2Fprojectfiles%2FUCIHARDataset/UCIHARDataset/train/y_train.txt", sep = "", header = FALSE)
training[,563]=read.csv("C:/Users/burak/Desktop/johnshopkins/week4/courseproject/getdata%2Fprojectfiles%2FUCIHARDataset/UCIHARDataset/train/subject_train.txt", sep = "", header = FALSE)

# Load testing_data 
testing = read.csv("C:/Users/burak/Desktop/johnshopkins/week4/courseproject/getdata%2Fprojectfiles%2FUCIHARDataset/UCIHARDataset/test/X_test.txt", sep="", header=FALSE)
testing[,562] = read.csv("C:/Users/burak/Desktop/johnshopkins/week4/courseproject/getdata%2Fprojectfiles%2FUCIHARDataset/UCIHARDataset/test/Y_test.txt", sep="", header=FALSE)
testing[,563] = read.csv("C:/Users/burak/Desktop/johnshopkins/week4/courseproject/getdata%2Fprojectfiles%2FUCIHARDataset/UCIHARDataset/test/subject_test.txt", sep="", header=FALSE)

# Load activity_labels
activityLabels = read.csv("C:/Users/burak/Desktop/johnshopkins/week4/courseproject/getdata%2Fprojectfiles%2FUCIHARDataset/UCIHARDataset/activity_labels.txt", sep="", header=FALSE)

# Load features
features= read.csv("C:/Users/burak/Desktop/johnshopkins/week4/courseproject/getdata%2Fprojectfiles%2FUCIHARDataset/UCIHARDataset/features.txt", sep="", header=FALSE)
features[,2]= gsub('-mean','Mean', features[,2])
features[,2]= gsub('-std','STD', features[,2])

wholeData= rbind(training, testing)

columns<- grep(".*Mean.*|.*STD.*", features[,2])

features <- features[columns,]

columns<-columns(columns,562,563)

wholeData<-wholeData[,columns]

colnames(wholeData) <- c(features$V2, "activity", "subject")

curActivity = 1
for(curActivityLabel in activityLabels$V2)
  {wholeData$activity <-gsub(curActivity,curActivityLabel,wholeData$Activity)
curActivity<-curActivity+1
}

wholeData$activity <-as.factor(wholeData$activity)
wholeData$subject <- as.factor(wholeData$subject)

tidy_data<- aggregate(wholeData,by=list(wholeData$activity,wholeData$subject),FUN=mean, na.rm=TRUE)
# Write tidy_data
write.table(tidy_data, "tidy_data.txt", sep="\t", row.names=FALSE)