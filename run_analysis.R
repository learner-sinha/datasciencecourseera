download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="./data/originaldataset.zip")
unzip(zipfile = "./data/originaldataset.zip",exdir = "./data")
 
 x_train <- read.table("./data/UCI HAR dataset/train/X_train.txt")
 y_train <- read.table("./data/UCI HAR dataset/train/y_train.txt")
 training <- read.table("./data/UCI HAR dataset/train/subject_train.txt")
 x_test <- read.table("./data/UCI HAR dataset/test/X_test.txt")
 y_test <- read.table("./data/UCI HAR dataset/test/y_test.txt")
 testing <- read.table("./data/UCI HAR dataset/test/subject_test.txt")
 features <- read.table("./data/UCI HAR dataset/features.txt")
 activity_labels <- read.table("./data/UCI HAR dataset/activity_labels.txt")
 
 colnames(x_train) <- features[,2]
 colnames(y_train) <- "activityID"
 colnames(training) <- "subjectID"
 colnames(x_test) <- features[,2]
 colnames(y_test) <- "activityID"
 colnames(testing) <- "subjectID"
 colnames(activity_labels) <- c('activityID', 'activityType')

 merge_training <- cbind(y_train, training, x_train)
 merge_testing <- cbind(y_test, testing)
 merge_testing <- cbind(y_test, testing, x_test)
 final_table <- rbind(merge_training, merge_testing)
 columNames <- colnames(final_table)
 

 mean_deviation <- (grepl("activityID", columNames) | grepl("subjectID", columNames) | grepl("mean", columNames) | grepl("deviation", columNames))
 subset_final_table <- final_table[,mean_deviation == TRUE]
 View(subset_final_table)
 ActivityNames_table <- merge(subset_final_table,activity_labels,by='activityID',all.x=TRUE)
 final_tidy_table <- aggregate(. ~subjectID + activityID, ActivityNames_table, mean)
 final_tidy_table <- final_tidy_table[order(final_tidy_table$subjectID, final_tidy_table$activityID),]
 write.table(final_tidy_table,"final_tidy_table.txt", row.name=FALSE)
> 