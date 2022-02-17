# Multiple Linear Regression in R

This is a demo of multiple linear regression in R. A linear regression model is fit to a dateset containing various cars along with their specs. The aim is to predict miles per gallon statistic based on the relevant specs.

## Methodology and Data

The idea behind linear regression is that the dependent variable, the variable that we are trying to predict, is linearly dependent on some other variables, independent variables. For example, housing prices might be dependent on the squarefeet space of the house. Moreover, we can think many more variables on which the house price might depend on, such as the year it was build, its relative condition, its distance to the nearest city, neighborhood, last renovation year, etc. In the case there are multiple independent variables, the model is called multiple linear regression. The most common method to fit the line to the data is ordinary least squares. Loss function of the model minimizes the residual - true observation minus the point where the line passes - sum of squares to give the line that is closes to the data.

For the estimators, i.e. the parameters gotten from the model, to be BLUE - **B**est **L**inear **U**nbiased **E**stimators - several assumptions of the model has to hold. (1) The errors have zero mean, (2) the variance of the errors is constant and finite, (3) the errors are statistically independent of one another, (4) no relationship between the error and corresponding x variate, and (5) the errors are normally distributed. These assumptions can be validated by either visually examining relevant plots or by statistical tests. If the assumptions hold true, then the estimators estimate the true value of the parameter, the estimators are linear estimators, on average the value of the estimators are equal to the true values, and the estimators have the minimum variance among the possible linear unbiased estimators estimators.

Dataset "mtcars" contains 32 observations (cars) on 11 variables (miles per gallon, number of cylinders, gross horsepower, etc.). The variables are numeric, continous and integers, and contains no missing values.

## Results

For the purpose of the statistical tests, 5% signifigance level is chosen. This means that if the p-value of a statistical test is less than 0.05 the null hypothesis of the test is rejected and the results can be said to be statistically significant.

![model_with_every_variable](https://user-images.githubusercontent.com/91892495/154483402-927ce724-5579-4faa-a25f-eeb338c634ea.jpg)

**Figure 1.** Regression model with every variable

Figure 1. presents the results of fitting a model with every explanatory variable. We can see that the model itself is highly statistically significant with a low p-value, howevery of the regressors only "wt" approaches statistical signifigance. We can start improving the model by removing the regressors that are not very statistically significant and make real world sense contributing little to the consumption. "cyl", "drat", "vs", "gear", and "carb" are removed, which represent "number of cylinder", "rear axle ratio, "engine" type, "number of forward gears", and "number of carburetors", respectively. Their effects can be thought to be intrinsically captured by other variables.
