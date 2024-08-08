# Install and load the required packages
library(nnet)
library(dplyr)
library(tidyr)
#change setwd accoridngly
#setwd("C:\\Users\\Joe\\OneDrive - Singapore University of Technology and Design\\Office Lens\\T5 The Analytics Edge\\Competition")
# Load the data
train_data <- read.csv("train2024.csv")
test_data <- read.csv("test2024.csv")

# Prepare the training data, this converts from CH1,Ch2,Ch3,Ch4 into A Choice column
train_data_long <- train_data %>%
  pivot_longer(cols = starts_with("Ch"), names_to = "Alternative", values_to = "Chosen") %>%
  filter(Chosen == 1) %>%
  mutate(Choice = case_when(
    Alternative == "Ch1" ~ 1,
    Alternative == "Ch2" ~ 2,
    Alternative == "Ch3" ~ 3,
    Alternative == "Ch4" ~ 4
  )) %>%
  select(-Alternative, -Chosen)

# Convert Choice to a factor
train_data_long$Choice <- as.factor(train_data_long$Choice)

# Fit the multinomial logistic regression model
model <- multinom(Choice~FA1+LD1+BZ1+FC1+FP1+RP1+PP1+SC1+TS1+NV1+AF1+HU1+Price1+FA2+LD2+BZ2+FC2+FP2+RP2+PP2+SC2+TS2+NV2+AF2+HU2+Price2+FA3+LD3+BZ3+FC3+FP3+RP3+PP3+SC3+TS3+NV3+AF3+HU3+Price3+FA4+LD4+BZ4+FC4+FP4+RP4+PP4+SC4+TS4+NV4+AF4+HU4+Price4+yearind+milesind+nightind+genderind+ageind+educind+regionind+Urbind+incomeind+pparkind, 
                  data = train_data_long)

# Summarize the model
summary(model)
logLik(model)

library(randomForest)
set.seed(1234)

# # Values of ntree to be tested
# B <- seq(500,700,by=100)
# # Values of mtry to be tested
# m <- seq(25,35,by=1)
# # Initialize a matrix for the OOB value
# OOB_matrix <- matrix(0,nrow=length(B),ncol=length(m))
# # For loop to obtain OOB Values
# for (i in 1:length(B)){
#   for (j in 1:length(m)){
#     # train a forest with B[i] trees
#     forest_temp <- randomForest(Choice~CC1+GN1+NS1+BU1+FA1+LD1+BZ1+FC1+FP1+RP1+PP1+KA1+SC1+TS1+NV1+MA1+LB1+AF1+HU1+Price1+CC2+GN2+NS2+BU2+FA2+LD2+BZ2+FC2+FP2+RP2+PP2+KA2+SC2+TS2+NV2+MA2+LB2+AF2+HU2+Price2+CC3+GN3+NS3+BU3+FA3+LD3+BZ3+FC3+FP3+RP3+PP3+KA3+SC3+TS3+NV3+MA3+LB3+AF3+HU3+Price3+CC4+GN4+NS4+BU4+FA4+LD4+BZ4+FC4+FP4+RP4+PP4+KA4+SC4+TS4+NV4+MA4+LB4+AF4+HU4+Price4+segmentind+yearind+milesind+nightind+genderind+ageind+educind+regionind+Urbind+incomeind+pparkind,data=train_data_long,ntree=B[i],mtry=m[j])
#     # model performance
#     OOB_matrix[i,j] <- forest_temp$err.rate[B[i],1]
#     # remove the temporary variable
#     rm(forest_temp)
#   }
# }

library(reshape2)
# rownames(OOB_matrix) <- B
# colnames(OOB_matrix) <- m
# longData <- as.data.frame(OOB_matrix)
# row.names(longData) <- B; colnames(longData) <- m

# longData <- melt(OOB_matrix)
# ggplot(longData, aes(x = Var1, y = Var2)) + 
#   geom_raster(aes(fill=value)) + 
#   scale_fill_gradient(low="grey90", high="red") +
#   labs(x="Number of Trees", y="Number of predictors")

forest_temp <- randomForest(Choice~CC1+GN1+NS1+BU1+FA1+LD1+BZ1+FC1+FP1+RP1+PP1+KA1+SC1+TS1+NV1+MA1+LB1+AF1+HU1+Price1+CC2+GN2+NS2+BU2+FA2+LD2+BZ2+FC2+FP2+RP2+PP2+KA2+SC2+TS2+NV2+MA2+LB2+AF2+HU2+Price2+CC3+GN3+NS3+BU3+FA3+LD3+BZ3+FC3+FP3+RP3+PP3+KA3+SC3+TS3+NV3+MA3+LB3+AF3+HU3+Price3+CC4+GN4+NS4+BU4+FA4+LD4+BZ4+FC4+FP4+RP4+PP4+KA4+SC4+TS4+NV4+MA4+LB4+AF4+HU4+Price4+segmentind+yearind+milesind+nightind+genderind+ageind+educind+regionind+Urbind+incomeind+pparkind,data=train_data_long,ntree=600,mtry=29)

#combination of forest and muiltinomial
pred_forest <- predict(forest_temp, newdata=test_data, type='prob')
pred_multinom <- predict(model, newdata =test_data, type='prob')
pred <- 0.5*pred_multinom +(0.5)*pred_forest
pred <- as.data.frame(pred)
colnames(pred) <- c("Ch1", "Ch2", "Ch3", "Ch4")

pred$No <- seq(21566, 21566 + nrow(pred) - 1)

# Move the new column "No" to the start of the dataframe
pred <- pred[, c("No", colnames(pred)[-length(colnames(pred))])]

write.csv(pred, 'adjustedmultinomforest.csv', row.names = FALSE)

#Prepare the test data (assuming the test data has the same structure as the training data)
# choices<- test_data_long[,c("Ch1","Ch2","Ch3","Ch4")]
# error <- (sum(choices * log(pred)))*(-1/nrow(test_data_long))
# avg_logloss <- 0
# avg_logloss <- error + avg_logloss

# Save the predictions to a CSV file
# write.csv(test_data_long, "/mnt/data/predicted_test_choices.csv", row.names = FALSE)
