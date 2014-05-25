setwd("/Users/rambler/Documents/Coursera/Data Science/03_GettingCleaningData/Project/UCI HAR Dataset")

# Assumed that the working directory is "UCI HAR Dataset"
# of the data exctracted from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Get the activity labels from "activity_labels.txt"
activity.map <- read.table("activity_labels.txt")[, 2]

# Get the original variable names.
variable.names <- read.table("features.txt")[, 2]

# Only mark the variables containing means or standard deviations.
to.be.included <- grepl("(mean\\(\\))|(std\\(\\))", variable.names)

# Create a function to clean up the names.
CleanVar <- function(ugly.name) {
  # According the requirements laid out around 10:00 into first
  # lecture of week 4, except decided to keep the variable names 
  # in camelCase format since some of the variable names were very 
  # long. 
  
  ugly.name <- gsub("(mean\\(\\))", "Mean", ugly.name)
  ugly.name <- gsub("(std\\(\\))", "Std", ugly.name)
  
  # To remove camelCase, we could simply uncomment the following line.
  
  # ugly.name <- tolower(ugly.name)
  
  # Only keep alphanumerical characters.
  
  ugly.name <- gsub("[^a-zA-Z0-9]", "", ugly.name)
  
  ugly.name
}

variable.names <- CleanVar(variable.names)

# Create one data set by merging the training and test sets.

final.selected <- data.frame(
  subject = read.table("train/subject_train.txt")[, 1]
)
# Get the training data; this may take a few seconds.
x.data <- read.table("train/X_train.txt", stringsAsFactors = FALSE)

# Keep the data of interest.
for (i in 1:561) {
  if (to.be.included[i])
    final.selected[variable.names[i]] <- x.data[, i]
}

# Insert the corresponding activity.
final.selected$activity <- activity.map[
  read.table("train/y_train.txt")[, 1]
]

# Create a dummy data frame to hold the test data.
dummy.data <- data.frame(
  subject = read.table("test/subject_test.txt")[, 1]
)

# Get the test data; this may take a few seconds.
x.data <- read.table("test/X_test.txt", stringsAsFactors = FALSE)

# Keep the data of interest.
for (i in 1:561) {
  if (to.be.included[i])
    dummy.data[variable.names[i]] <- x.data[, i]
}

# Insert the corresponding activity.
dummy.data$activity <- activity.map[
  read.table("test/y_test.txt")[, 1]
]

# Bind the two data sets together.
final.selected <- rbind(final.selected, dummy.data)

# Clean up.
rm(dummy.data)

# Create a second, tidy data set with the average for each variable
# by activity and subject.

variable.names <- variable.names[to.be.included]

final.data <- data.frame()
invisible(
  by(
    final.selected, 
    list(final.selected$activity, final.selected$subject), 
    function(df) {
      dummy.row <- data.frame(subject = df$subject[1])
      for (v in variable.names) 
        dummy.row[v] <- mean(df[[v]])
      dummy.row$activity <- df$activity[1]
      final.data <<- rbind(final.data, dummy.row)
    }
  )
)

# Save the final, tidy data set.

write.table(final.data, file = "tidy_data.txt", sep = ",")