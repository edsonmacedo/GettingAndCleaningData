# Check for the required packages.
# If the package is already installed, it is loaded.
# Otherwise, it is installed.
if(isTRUE("readr" %in% rownames(installed.packages()))) {library("readr")} else{install.packages("readr")}
if(isTRUE("dplyr" %in% rownames(installed.packages()))) {library("dplyr")} else{install.packages("dplyr")}

# Loads the features labels:
features_labels <- read_delim(file = "data/features.txt", delim = " ", col_names = FALSE)$X2

# Loads the test dataset:
test <- read_fwf(file = "data/test/X_test.txt",
                 col_positions = fwf_widths(rep(c(16), 561), col_names = features_labels))

# Loads the test labels, merges it into the test data frame and removes the incorporated object:
test_labels <- read_fwf("data/test/y_test.txt", 
                        col_positions = fwf_widths(1, col_names = "activity"))
test <- bind_cols(test_labels, test)
rm(test_labels)

# Loads the subject's ids, merges it into the test data frame and removes the incorporated object:
subject_test <- read_fwf("data/test/subject_test.txt", 
                         col_positions = fwf_widths(1, col_names = "subject"))
test <- bind_cols(subject_test, test)
rm(subject_test)

# Loads the train dataset:
train <- read_fwf(file = "data/train/X_train.txt",
                 col_positions = fwf_widths(rep(c(16), 561), col_names = features_labels))

# Loads the train labels, merges it into the train data frame and removes the incorporated object:
train_labels <- read_fwf("data/train/y_train.txt", 
                         col_positions = fwf_widths(1, col_names = "activity"))
train <- bind_cols(train_labels, train)
rm(train_labels)

# Loads the subject's ids, merges it into the train data frame and removes the incorporated object:
subject_train <- read_fwf("data/train/subject_train.txt", 
                          col_positions = fwf_widths(1, col_names = "subject"))
train <- bind_cols(subject_train, train)
rm(subject_train)
