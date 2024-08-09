setwd("C:\\Users\\Joe\\OneDrive - Singapore University of Technology and Design\\Office Lens\\T5 The Analytics Edge\\Competition")

rm(list=ls())

library(dplyr)
library(caret)
library(e1071)
library(tidyr)

train<- read.csv("train2024.csv")
View(train)
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
#train_data_k <- train_data_k[,c(1:3,24:25,76)]
#View(train_data_k)

features <- train_data_k[, -which(names(train_data_k) == "Choice")]

# Scale the feature columns
scaled_features <- scale(features)

# Combine the scaled features back with the Choice column
train_data_k_scaled <- cbind(as.data.frame(scaled_features), Choice = train_data_k$Choice)

# Split data into training and testing sets
df_train <- train_data_k_scaled[1:21565, ]
df_test <- train_data_k_scaled[21566:nrow(train_data_k_scaled), ]

#df_train <- train_data_k[1:21565, ]
View(df_train)
#df_test <- train_data_k[-1:-21565, ]
View(df_test)

set.seed(123)
svm_model <- svm(Choice ~ ., df_train, kernel = "radial",probability=TRUE)

predicted_clusters <- predict(svm_model, newdata=df_test,probability = TRUE)
predicted_clusters
print(predicted_clusters)
#View(predicted_clusters)
predicted_clusters<- predict(svm_model,df_test,probability = TRUE)
predicted_clusters
pred_svm <- attr(predicted_clusters,"probabilities")
pred_svm <- pred_svm[,c(2,1,3,4)]
predicted_clusters_df <- data.frame(pred_svm)
View(predicted_clusters_df)
write.csv(predicted_clusters_df,"svm_radial.csv")
#write.csv(predicted_clusters,"attempt3107.csv", row.names = TRUE)

