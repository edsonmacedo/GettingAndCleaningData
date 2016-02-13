# Check for the required packages.
# If the package is already installed, it is loaded.
# Otherwise, it is installed.
if(isTRUE("readr" %in% rownames(installed.packages()))) {library("readr")} else{install.packages("readr")}
if(isTRUE("dplyr" %in% rownames(installed.packages()))) {library("dplyr")} else{install.packages("dplyr")}

# Loads the features labels (using gsub to avoid duplicate columns and spaces):
features_labels <- gsub(" ", "_", x = read_lines(file = "UCI HAR Dataset/features.txt"))

# Loads the test dataset:
test <- read_fwf(file = "UCI HAR Dataset/test/X_test.txt",
                 col_positions = fwf_widths(rep(c(16), 561), col_names = features_labels))

# Loads the test labels, merges it into the test data frame and removes the incorporated object:
test_labels <- read_fwf("UCI HAR Dataset/test/y_test.txt", 
                        col_positions = fwf_widths(1, col_names = "activity"))
test <- bind_cols(test_labels, test)
rm(test_labels)

# Loads the subject's ids, merges it into the test data frame and removes the incorporated object:
subject_test <- read_fwf("UCI HAR Dataset/test/subject_test.txt", 
                         col_positions = fwf_widths(1, col_names = "subject"))
test <- bind_cols(subject_test, test)
rm(subject_test)

# Loads the train dataset:
train <- read_fwf(file = "UCI HAR Dataset/train/X_train.txt",
                 col_positions = fwf_widths(rep(c(16), 561), col_names = features_labels))

# Loads the train labels, merges it into the train data frame and removes the incorporated object:
train_labels <- read_fwf("UCI HAR Dataset/train/y_train.txt", 
                         col_positions = fwf_widths(1, col_names = "activity"))
train <- bind_cols(train_labels, train)
rm(train_labels)

# Loads the subject's ids, merges it into the train data frame and removes the incorporated object:
subject_train <- read_fwf("UCI HAR Dataset/train/subject_train.txt", 
                          col_positions = fwf_widths(1, col_names = "subject"))
train <- bind_cols(subject_train, train)
rm(subject_train)

# Removes the features labels object (already incorporated):
rm(features_labels)

# Merges the datasets (using row bindding, since both datasets have the same columns):
merged <- bind_rows("test" = test, "train" = train, .id = "dataset")

# Removes the merged data sets:
rm(test)
rm(train)

# Extracts only the measurements on the mean and standard deviation:
merged <- select(merged, dataset, subject, activity, contains("mean"), contains("std"))

# Uses descriptive activity names to name the activities in the data set:
activity_labels <- read_delim(file = "UCI HAR Dataset/activity_labels.txt", delim = " ",
                              col_names = c("activity", "activity_label"))
merged <- bind_cols(left_join(merged, activity_labels, by = "activity")["activity_label"], merged)
merged <- mutate(merged, activity = activity_label)
merged <- select(merged, -activity_label)
rm(activity_labels)

# Creates a data set with the average of each variable for each activity and each subject:
merged_avg <- summarise_each(group_by(merged, activity, subject), funs(mean(., na.rm = TRUE)), -dataset)

# Exports the data set files:
write_csv(merged_avg, path = "merged_avg.csv")
write_csv(merged, path = "merged.csv")
