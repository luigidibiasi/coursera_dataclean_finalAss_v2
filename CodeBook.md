Preliminary: loading the dplyr library 

REQUEST: Giving respective column names to improve readability for users
Step2: Changing column name in “features ,activities ,subject_test,x_test ,y_test ,subject_train”

REQUEST: Creating two tables
Step3: Load x_train and y_train 
Step4: Merging x_train and y_train

REQUEST: Using descriptive activity names to name the activities in the data set
Step5 : gsub where used to change Acc, Gyro, BodyBody, Mag, ^t, ^f, tBody, -mean, std, freq, angle, gravity into ==>
 Acceler., gyroscope,body,magnitude,time,hz,timebody,Mean,SD,hz.

REQUEST: Writing in the cleaned data into the text file FinalData.txt
Step6: The new table was stored into FinalData.txt fiel
