
## Thanks for reading my code. I decided to do more than one step at the   
## same time since it makes more sense to me to first organize the whole 
## data set and then start subseting. At each section of my code there   
## will be an inditication to which steps were done. Cheers from Brazil!           


###########################################################################
## Step 1 - Merges the training and the test sets to create one data set.##
## Step 3 - Uses descriptive activity names to name the activities in    ##
## the data set.                                                         ##
## Step 4 - Appropriately labels the data set with descriptive variable  ##
## names.                                                                ##
###########################################################################


### Train Data ###

train_raw <- read.table("./UCI HAr Dataset/train/X_train.txt")               # reads the train data

features <- read.table("./UCI HAr Dataset/features.txt")                     # reads the variables data 
var_names <- features[,2]                                                    # extracts variable names
colnames(train_raw) <- var_names                                             # rename columns 

activities <- read.table("./UCI HAr Dataset/train/y_train.txt")              # read the activities data
train_raw <- cbind(activities, train_raw)                                    # bind the activities to the data
descriptive_names <- c("walking", "walking_upstairs", "walking downstairs",  
                       "sitting", "standing", "laying")                      # vector with activity names
train_raw[,1] <- descriptive_names[train_raw[[1]]]                           # rename the activity levels
colnames(train_raw)[1] <- "activity"

subj_train <- read.table("./UCI HAr Dataset/train/subject_train.txt")        # reads the data on the subjects
train <- cbind(subj_train, train_raw)                                        # binds the names with variables
colnames(train)[1] <- "subjects"

train["origin"] <- NA                                                        # creates a new column to record 
train$origin <- "train"                                                      # the origin of the data

### Test Data ###

test_raw <- read.table("./UCI HAr Dataset/test/X_test.txt")                  # reads the test data

activities2 <- read.table("./UCI HAr Dataset/test/y_test.txt")               # read the activities data
test_raw <- cbind(activities2, test_raw)                                     # bind the activities to the data
test_raw[,1] <- descriptive_names[test_raw[[1]]]                             # rename the activity levels

subj_test <- read.table("./UCI HAr Dataset/test/subject_test.txt")           # reads the data on the subjects
test <- cbind(subj_test, test_raw)                                           # binds the names with variables

test["origin"] <- NA                                                         # creates a new column to record 
test$origin <- "test"                                                        # the origin of the data

names(test) <- names(train)                                                  # copy the column name from train

### Binding the two datasets ###

df <- rbind(train, test)                                                     # merges the two datasets and
                                                                             # assigns to a new data frame (df)


###########################################################################
## Step 2 - Extracts only the measurements on the mean and standard      ##
## deviation for each measurement.                                       ##
###########################################################################

cols <- c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352,
          426:431, 505:506, 518:519, 531:532, 544:545)                       # cols is a variable that stores
                                                                             # the indices of columns in the 
                                                                             # data frame that end with mean()
                                                                             # or sd() and it also includes the
                                                                             # subjects id [1] and activity [2]

df2 <- df[,cols]                                                             # subsets the data frame only with
                                                                             # the right columns and assigns to
                                                                             # df2


###########################################################################
## Step 5 - From the data set in step 4, creates a second, independent   ##
## tidy data set with the average of each variable for each activity and ##
## each subject.                                                         ##
###########################################################################

df2[,1]<- as.factor(df2[,1])                                                   # transform the subject and
df2[,2]<- as.factor(df2[,2])                                                   # activity columns into factors

levels <- split(df2, list(df2[,1], df2[,2]))                                   # splits df2 according to the
                                                                               # activity and subject levels

means <- lapply(levels, function(x) colMeans(df2[,3:68]))                      # get the mean of each column
                                                                               # according to 'levels' and 
                                                                               # assings the results list to 
                                                                               # means

df3 <- data.frame(matrix(unlist(means), nrow = 180, byrow = TRUE))             # transform 'means' to dataframe 


heading <- data.frame(subjects = rep(c(1:30), 6), activity = rep(c("laying",   # creates a data frame with the
                                    "sitting", "standing", "walking",          # subjects and activities in the
                                    "walking downstairs", "walking upstairs"), # correct order to bind with df3
                                    each = 30))

tidy_data <- cbind(heading, df3)                                               # binds the heading columns with
                                                                               # with df3 creating the final tidy
                                                                               # data

names(tidy_data) <- names(df2)                                                 # gets the correct column names
                                                                               # from df2 and assings to tidy_data

write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
