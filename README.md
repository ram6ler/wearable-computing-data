## Wearable computer data / readme

This is a project that was done as part of the [Coursera](https://www.coursera.org) course, [Getting and Cleaning Data](https://www.coursera.org/course/getdata). For the project, we were given access to a really untidy data set, [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from the [University of California, Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml), from which we were to extract and organise some of the data. The raw data may be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The original data is a large set of values recorded or calculated from gyroscope and accelerometer readings of mobile devices worn by volunteers while engaging in various activities. The basic idea was to see whether such readings may be used to predict the activity.

This repo consists of the following files:

* __README.md__<br>This file, that you are reading.
* [__run_analysis.R__](https://github.com/ram6ler/wearable-computing-data/blob/master/run_analysis.R)<br>The R code that produced the final, tidy data set (see below for code explanation).
* [__CODEBOOK.md__](https://github.com/ram6ler/wearable-computing-data/blob/master/CODEBOOK.md)<br>An explanation of the variables in the final tidy data set.

### Process / What run_analysis.R does...
The R code is commented in detail so that it is clear where each of the following steps take place.

* It is assumed that the raw data has been downloaded and extracted in the working directory.
* The activity labels are read from the file __activity_labels.txt__ and stored into a character vector called <code>activity.map</code>.
*  A boolean vector called <code>to.be.included</code> is created to mark which of the variables we are interested in extracting (_i.e._, those variables that contain means or standard deviations of other measurements).
*  A function called <code>CleanVar</code> was created to take in a raw variable name from the original data set and to return a variable name more appropriate for R. (As discussed in CODEBOOK.md, I decided to keep camel case format for the sake of readability, but I have added a commented out line of code to remove the camel case if it is desired.) The function effectively removes non alphanumeric characters from the variable names. The function is used to replace the variable names read from file.
*  A data frame called <code>final.selected</code> is created and the variables from the training set are read in from __train/X_train.txt__ and identified in <code>to.be.included</code> are added to the data frame. The subjects are read in from the file __train/subject_train.txt__ and the activities are read in from __train/y_train.txt__ and mapped to value using the variable <code>activity.map</code>.
*  A simialr process is used with the test data and the rows of the corresponding data frame are attached to <code>final.selected</code>. (This is the data set asked for in part 1 of the assignment.)
*  A new data frame called <code>final.data</code> is created. For each activity and subject in <code>final.selected</code>, the mean of each of the predictors is stored in <code>final.data</code>. (This is the data set referred to in part 5 of the assignment.)
*  Finally, <code>final.data</code> is saved in comma separated format to a file called __tidy_data.txt__, which has been submitted on the course peer assessment page.