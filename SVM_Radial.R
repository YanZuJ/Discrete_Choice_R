Set Working Directory
#setwd("C:\\Users\\1006864\\Downloads\\the-analytics-edge-data-competition-2024 (1)")

rm(list=ls())

library(dplyr)
library(caret)
library(e1071)
library(tidyr)

train<- read.csv("train2024.csv")

test <- read.csv("test2024.csv")

test$Ch1<-1
test$Ch2<-0
test$Ch3<-0
test$Ch4<-0
trainntest<- rbind(train,test)
trainntest<- data.frame(trainntest)

trainntest$Choice <- factor(apply(trainntest[, 110:113], 1, function(row) {
  choices <- c("Ch1", "Ch2", "Ch3", "Ch4")
  choices[which(row == 1)]
}))

View(trainntest)

train_data_k<-data.frame(trainntest[,-c(1:3,64:84,86,88,91,94,96,98,101,103,105,107,110:113)])
View(train_data_k)


df_train <- train_data_k[1:21565, ]
View(df_train)
df_test <- train_data_k[-1:-21565]
View(df_test)

colnames(df_test)

set.seed(123)
#Choice ~ CC1+GN1+NS1+BU1+FA1+LD1+BZ1+FC1+FP1+RP1+PP1+KA1+SC1+TS1+NV1+MA1+LB1+AF1+HU1+Price1+CC2+GN2+NS2+BU2+FA2+LD2+BZ2+FC2+FP2+RP2+PP2+KA2+SC2+TS2+NV2+MA2+LB2+AF2+HU2+Price2+CC3+GN3+NS3+BU3+FA3+LD3+BZ3+FC3+FP3+RP3+PP3+KA3+SC3+TS3+NV3+MA3+LB3+AF3+HU3+Price3+CC4+GN4+NS4+BU4+FA4+LD4+BZ4+FC4+FP4+RP4+PP4+KA4+SC4+TS4+NV4+MA4+LB4+AF4+HU4+Price4+
svm_model <- svm(Choice~., df_train, kernel = "radial",probability=TRUE)

df_test$BU1 <- test$BU1
predicted_clusters <- predict(svm_model, df_test,probability = TRUE)
predicted_clusters

pred_svm <- attr(predicted_clusters, "probabilities") #for some reason, ch1 and ch2 are swapped
pred_svm <- pred_svm[, c(2,1,3,4)] #to swap it back

# Note: Adjust the sequence length to match the number of rows in the dataframe
pred$No <- seq(21566, 21566 + nrow(pred) - 1)

# Move the new column "No" to the start of the dataframe
pred <- pred[, c("No", colnames(pred)[-length(colnames(pred))])]

# Save the predictions to a CSV file
write.csv(pred, 'svm_radial.csv', row.names = FALSE)


