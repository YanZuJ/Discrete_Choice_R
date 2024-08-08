
svm_linear <- read.csv("svm_linear.csv")
svm_rad <- read.csv("svm_radial.csv")

model3 <- 0.5*svm_linear +(0.5)*svm_rad
model3 <- as.data.frame(model3)

write.csv(model3, 'model3.csv', row.names = FALSE)

