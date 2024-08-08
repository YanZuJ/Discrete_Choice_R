# Discrete_Choice_R
40.220 The Analytics Edge (SUTD) 2024 
In this competition, you will be predicting the choice among bundles of safety features in cars. This data was analyzed in Weeks 4 and 5 of the classes.
We've used a combination of Random Forest, Multinomial and Support Vector Machine 

## File Info

| Info                                                          | .R                       | .csv                       |
|---------------------------------------------------------------|--------------------------|----------------------------|
| Train                                                         | -                        | train2024.csv              |
| Test                                                          | -                        | test2024.csv               |
| Dependencies Installation                                     | Dependencies.R           | -                          |
| Model 1: Random Forest (RF) + Multinomial (Mlogit)            | Initial_MultinomForest.R | initial_multinomforest.csv |
| Support Vector Machine (SVM) Linear                           | SVM_Linear.csv           | svm_linear.csv             |
| Support Vector Machine (SVM) Radial                           | SVM_Radial.csv           | svm_radial.csv             |
| Model 2: SVM Linear + RF + MLogit                             | Model2.R                 | model2.csv                 |
| Model 3: SVM Linear + Radial                                  | Model3.R                 | model3.csv                 |
| Adjusted RF + MLogit                                          | AdjustedMultinomForest.R | adjustedmultinomforest.csv |
| Model 4: 0.5(SVM Linear + Radial) + 0.5(Adjusted RF + MLogit) | Model4.R                 | model4.csv                 |

## Installation

Please ensure you have at least R 4.3.3 version installed.

1. Clone this repository through git clone onto your computer
2. Run Dependencies.R first to install all the necessary packages.
3. For each R code, please remember to set your working directory to the this repository through `setwd`
For example,
```bash
setwd("C:\\Users\\File\\Path\\To\\Code") #Note the double \\
```
5. Run the code in order from from top to bottom based on the .R column in the table shown above.
6. The .csv results are already in the file. If you would like to verify the best solution, run Model4.R only
