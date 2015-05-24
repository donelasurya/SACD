setwd("C:/Users/212341630/Desktop/R_coursera/project/UCI_HAR_Dataset")
dir.create("merge")
dir.create("./merge/Inertial_Signals")
#Reading Train data
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
body_acc_x_train <- read.table("./train/Inertial_Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("./train/Inertial_Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("./train/Inertial_Signals/body_acc_z_train.txt")
body_gyro_x_train <- read.table("./train/Inertial_Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("./train/Inertial_Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("./train/Inertial_Signals/body_gyro_z_train.txt")
total_acc_x_train <- read.table("./train/Inertial_Signals/total_acc_X_train.txt")
total_acc_y_train <- read.table("./train/Inertial_Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("./train/Inertial_Signals/total_acc_z_train.txt")
#Reading test data
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
body_acc_x_test <- read.table("./test/Inertial_Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("./test/Inertial_Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table("./test/Inertial_Signals/body_acc_z_test.txt")
body_gyro_x_test <- read.table("./test/Inertial_Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table("./test/Inertial_Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("./test/Inertial_Signals/body_gyro_z_test.txt")
total_acc_x_test <- read.table("./test/Inertial_Signals/total_acc_X_test.txt")
total_acc_y_test <- read.table("./test/Inertial_Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("./test/Inertial_Signals/total_acc_z_test.txt")
#merge Train & Test data
X_merge <- rbind(X_train,X_test)
y_merge <- rbind(y_train,y_test)
subject_merge <- rbind(subject_train,subject_test)
body_acc_x_merge <- rbind(body_acc_x_train,body_acc_x_test)
body_acc_y_merge <- rbind(body_acc_y_train,body_acc_y_test)
body_acc_z_merge <- rbind(body_acc_z_train,body_acc_z_test)
body_gyro_x_merge <- rbind(body_gyro_x_train,body_gyro_x_test)
body_gyro_y_merge <- rbind(body_gyro_y_train,body_gyro_y_test)
body_gyro_z_merge <- rbind(body_gyro_z_train,body_gyro_z_test)
total_acc_x_merge <- rbind(total_acc_x_train,total_acc_x_test)
total_acc_y_merge <- rbind(total_acc_y_train,total_acc_y_test)
total_acc_z_merge <- rbind(total_acc_z_train,total_acc_z_test)
#Writing merge files
write.table(X_merge,file="./merge/X_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(y_merge,file="./merge/y_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(subject_merge,file="./merge/subject_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(body_acc_x_merge,file="./merge/Inertial_Signals/body_acc_x_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(body_acc_y_merge,file="./merge/Inertial_Signals/body_acc_y_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(body_acc_z_merge,file="./merge/Inertial_Signals/body_acc_z_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(body_gyro_x_merge,file="./merge/Inertial_Signals/body_gyro_x_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(body_gyro_y_merge,file="./merge/Inertial_Signals/body_gyro_y_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(body_gyro_z_merge,file="./merge/Inertial_Signals/body_gyro_z_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(total_acc_x_merge,file="./merge/Inertial_Signals/total_acc_x_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(total_acc_y_merge,file="./merge/Inertial_Signals/total_acc_y_merge.txt",col.name=FALSE,row.name=FALSE)
write.table(total_acc_z_merge,file="./merge/Inertial_Signals/total_acc_z_merge.txt",col.name=FALSE,row.name=FALSE)
#
#Activity names to activity labels
act_merge <- matrix(1:10299,nrow=10299,ncol=1)
for(t in 1:10299){
	if (y_merge[t,1]==1) act_merge[t,1]<-"WALKING"
	else if (y_merge[t,1]==2) act_merge[t,1]<-"WALKING_UPSTAIRS"
	else if (y_merge[t,1]==3) act_merge[t,1] <-"WALKING_DOWNSTAIRS"
	else if (y_merge[t,1]==4) act_merge[t,1] <-"SITTING"
	else if (y_merge[t,1]==5) act_merge[t,1] <-"STANDING"
	else if (y_merge[t,1]==6) act_merge[t,1] <-"LAYING"
	}
colnames(act_merge) <- "activity"
colnames(subject_merge) <- "subject"
act_sub <- cbind(subject_merge,act_merge)
#
#assigning Variable names
Var_names <- read.table("features.txt")
Var_names <- Var_names[,2]
Var_names <- t(Var_names)
colnames(X_merge) <- Var_names
#Extracting only means and Standard deviation
mean <- X_merge[,grep("mean",colnames(X_merge))]
std <- X_merge[,grep("std",colnames(X_merge))]
mean_std <- cbind(mean,std)
mean_std <- cbind(act_sub,mean_std)
order.sub <- order(mean_std$subject)
mean_std <- mean_std[order.sub,]
#average of variables base on activities and subjects
average <- sapply(split(mean_std[,3:81],list(mean_std$activity,mean_std$subject)),colMeans)
average <- t(average)
act.sub <- rownames(average)
act.sub <- as.matrix(act.sub)
colnames(act.sub) <- "activity.subject"
average <- cbind (act.sub,average)
write.table(average,file="average.txt",row.name=FALSE)


