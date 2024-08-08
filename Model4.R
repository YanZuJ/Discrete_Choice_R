
model3 <- read.csv("model3.csv")
adjmultirf <- read.csv("adjustedmultinomforest.csv")

model4 <- 0.5*model3 +(0.5)*adjmultirf
model4 <- as.data.frame(model4)

write.csv(model4, 'model4.csv', row.names = FALSE)

