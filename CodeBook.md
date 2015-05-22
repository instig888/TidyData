## Setup
30 volunteers between 19-48 years old performed 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.  Data was captured from the accelerometer and gyroscope.  It was then randomly split into two sets, called training and test.

## Raw data
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment

## Study Design
Taken from the README.txt
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Codebook
The test and train data sets were merged in order to form combined data sets.
The activity codes were joined with activity codes for each observation. 
The subject ids were merged back into those observations to identify which subjects corresponded to which sets of measurements.
The activity codes for the observations were merged with the related labels to provide a text label for each observation.
The activity code / label data was merged into the feature/subject data to form a wholistic data set.
The feature measurements were filtered to only maintain only the columns whose data was Standard deviation or mean related.
Feature labels were pulled from the feature text file and applied to the variable columns.

The data was then grouped by Subject.Number and Activity.Code and a mean was calculated for each variable to generate the final tidy data set.

The tidy data has 82 variables, the original data had 561 veriables.

Subject Number is an integer
Activity Code is an integer
Activity Name is a string (6 level factor)
The addtiaionl x,y,z mean averages are numbers.
