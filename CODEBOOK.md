# Codebook


## Variables

### <code>subject</code>
A record to identify the volunteer who was wearing the mobile device while performing the various activities, from whom the data was collected.

### <code>activity</code>
A record of the activity the volunteer was engaged in when the data was collected. This a categorical variable with a value from the set <code>WALKING</code>, <code>WALKING_UPSTAIRS</code>, <code>WALKING_DOWNSTAIRS</code>, <code>SITTING</code>, <code>STANDING</code> and <code>LAYING</code> (_sic_). This is the variable that the gyroscope and accelerometer readings are ideally to predict.

### _Predictors_
The original data set (see [README.md](https://github.com/ram6ler/wearable-computing-data/blob/master/README.md)) contained 561 numerical variables measured or calculated from readings from accelorometers and gyroscopes in mobile devices carried by volunteers engaging in various activities. Some (66) of the variables were measures of centre (means) or spread (standard deviation) of other collected data. For this project, we were only interested in these latter variables. 

I have called these variables _predictors_ because the purpose of the original data collection appears to have been to use information collected from the mobile devices to predict the activity in which the subject was engaged.

In cleaning up the original variable names, I removed any non alphanumeric characters, e.g. <code>-</code>, <code>(</code> and <code>)</code>. Ideally, I should have also made sure that the predictor names only used lower case letters, but, since many of the predictors had very long names -- for example, <code>tGravityAccMag-mean()</code> -- I ended up keeping the camel case format to enhance readability.

Further, in the original data set, for each subject and activity, measurements were taken at a frequency of 50 Hz over 2.56 s periods (128 readings per window). For this project, I have taken the mean of readings from all windows per subject and activity.

The predictors are named as follows:

* <code>__tBodyAccMeanX__</code><br>The mean of data windows stored in the variable <code>tBodyAcc-mean()-X</code> in the original data set, for each subject and each activity.
* <code>__tBodyAccStdX__</code><br>The mean of data windows stored in the variable <code>tBodyAcc-std()-X</code> in the original data set, for each subject and each activity.
* _etc._


The final, tidy data set has 66 predictors with values calculated similarly to those for the above two example variables.



