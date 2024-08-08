
svm_linear <- read.csv("svm_linear.csv")
multirf <- read.csv("initial_multinomforest.csv")

model2 <- 0.5*svm_linear +(0.5)*multirf
model2 <- as.data.frame(model2)

write.csv(model2, 'model2.csv', row.names = FALSE)

