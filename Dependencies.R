# Define a vector of required packages
required_packages <- c("dplyr", "caret", "e1071", "tidyr", "nnet", "randomForest", "reshape2")

# Function to check if each package is installed, and install it if it isn't
install_if_missing <- function(packages) {
  for (package in packages) {
    if (!require(package, character.only = TRUE)) {
      install.packages(package, dependencies = TRUE)
      library(package, character.only = TRUE)
    }
  }
}

# Install and load all required packages
install_if_missing(required_packages)

