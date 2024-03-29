# Multiple Linear Regression in R

This is a demo of multiple linear regression in R. A linear regression model is fit to a dateset containing various cars along with their specs. The aim is to predict miles per gallon statistic based on the relevant specs.

## Methodology and Data

The idea behind linear regression is that the dependent variable, the variable that we are trying to predict, is linearly dependent on some other variables, independent variables. For example, housing prices might be dependent on the squarefeet space of the house. Moreover, we can think many more variables on which the house price might depend on, such as the year it was build, its relative condition, its distance to the nearest city, neighborhood, last renovation year, etc. In the case there are multiple independent variables, the model is called multiple linear regression. The most common method to fit the line to the data is ordinary least squares (OLS). Loss function of the model minimizes the residual - true observation minus the point where the line passes - sum of squares to give the line that is closes to the data.

For the estimators, i.e. the parameters gotten from the model, to be BLUE - **B**est **L**inear **U**nbiased **E**stimators - several assumptions of the model has to hold. (1) The errors have zero mean, (2) the variance of the errors is constant and finite, (3) the errors are statistically independent of one another, (4) no relationship between the error and corresponding x variate, and (5) the errors are normally distributed. These assumptions can be validated by either visually examining relevant plots or by statistical tests. If the assumptions hold true, then the estimators estimate the true value of the parameter, the estimators are linear estimators, on average the value of the estimators are equal to the true values, and the estimators have the minimum variance among the possible linear unbiased estimators.

Dataset "mtcars" contains 32 observations (cars) on 11 variables (miles per gallon, number of cylinders, gross horsepower, etc.). The variables are numeric, continous and integers, and contain no missing values.

## Results

For the purpose of the statistical tests, 5% signifigance level is chosen. This means that if the p-value of a statistical test is less than 0.05, the null hypothesis of the test is rejected and the results can be said to be statistically significant.

![model_with_every_variable](https://user-images.githubusercontent.com/91892495/154483402-927ce724-5579-4faa-a25f-eeb338c634ea.jpg)

**Figure 1.** Regression model with every variable

Figure 1. presents the results of fitting a model with every explanatory variable. Coefficient values are essentially multipliers for their respective variables when using the model to predict values for a new car model. For example, gross horsepower of the vehicle (hp) will have an negative effect on the fuel consumption. Adjusted R-squared, which accounts for the number of variables in the model, value of the model is 0.8153, which means that the model captures around 80% of the variablity of the dependent variable around its mean. We can see that the model itself is highly statistically significant with a low p-value, however of the regressors only "wt" approaches statistical signifigance. We can start improving the model by removing the regressors that are not very statistically significant and make real world sense contributing little to the consumption. "cyl", "drat", "vs", "gear", and "carb" are removed, which represent "number of cylinder", "rear axle ratio, "engine" type, "number of forward gears", and "number of carburetors", respectively. Their effects can be thought to be intrinsically captured by other variables.

![model_without_cyl_drat_vs_gear_carb_removed](https://user-images.githubusercontent.com/91892495/154489613-2c7136da-5d0b-48f8-a8a5-60545766e729.jpg)

**Figure 2.** Model with cly, drat, vs, gear, and carb variables removed

Figure 2. has the model with previously mentioned variables removed. The model is still statistically significant and the explanatory power model of the model has increased. Now also wt, qsec as well as am are statistically significant. We can try to further improve the model by removing the still statistically insignificant variables.

![final_model_with_wt_qsec_am](https://user-images.githubusercontent.com/91892495/154491116-ddd54318-4d6c-4335-b685-8d4b40ecb474.jpg)

**Figure 3.** Final model

Figure 3. contains the final model. Weight (1000 lbs) (wt), 1/4 mile time (qsec), and transmission (am) are the final explanatory variables. These variables seem to make sense explaining the consumption. The model explanatory power is about the same as before but now every independent variable is statistically significant at the chosen significance level. Only intercept is not statistically significant, however removing it means that the line will go through the origin, which generally is not the best fit. Also, including the intercept means that the assumption (1) will always hold.

![original_vs_fitted](https://user-images.githubusercontent.com/91892495/154651553-607134a8-e776-4908-b4c5-cb3ce5337340.jpeg)

**Figure 4.** Original vs fitted values

Figure 4. plots the model fitted values against the original data values. Fit seems to be relatively good, however training and testing the model was done with the same dataset so the results may not be very generalizable. Now is a good idea to check the assumptions so that our model is BLUE. As the model has intercept, assumption (1) that the errors have zero mean holds. To test for assumption (2) that the variance of the errors is constant, we can plot the errors against fitted values and look for any patterns, and conduct couple statistical tests.

![assumptions](https://user-images.githubusercontent.com/91892495/154674173-1b87f0d1-8ef3-467a-a10a-0ade9e350ce5.jpeg)

**Figure 5.** Assumption plots

From figure 5. residuals vs fitted and their scaled values plots it would seem that the residuals are not homoskedastic, i.e. the variance of the errors is not constant - there is a clear pattern to them. Goldfeld-Quandt and studentized Breusch-Pagan test give p-values of 0.02 and 0.10, respectively, giving supporting evidence that the errors are heteroskedastic. Consequence of this is that the estimators are no longer BLUE. To remedy this, some other estimation method could be used. To check for assumption (3) that the errors are not autocorrelated, autocorrelation function can be plotted. From figure 5. it would seem that there is first order of autocorrelation present and there may be pattern in the lagged vs unlagged values. Durbin-Watson test tests for autocorrelation and gives the p-value of 0.25, indicating that there is no autocorrelation presents. Breusch-Godfrey test tests for autocorrelation of order up to 4 and gives the p-value of 0.26, also indicating that there is no autocorrelation, so assumption (3) should hold. Assumption (4) can also be visually confirmed by plotting residuals against independent variables and seeing if there is a pattern. Correlation tests such as Pearson's product-moment correlation can also be used, and in this case it strongly supports no correlation with a p-value of 1. From Q-Q plot in figure it's clear that the residuals are not perfectly normally distributed, however Jarque Bera test, which tests for the normality, gives the p-value of 0.33, giving evidence that they don't significantly differ from normal distribution.

There are other tests we can do to evaluated the model, for example multicollinearity, parameter stability test, and adopting the wrong functional form. Multicollinearity occurs when there is a relationship between the explanatory variables. Practically, there is always some measure of multicollinearity present. It can be detected from correlation matrix, but it doesn't tell us whether there is a relationship between more than two variables. Calculating variance inflation factors (VIF) is a better method of detecting it. It gives a range of values, and typically values less than 5 indicate a negligible multicollinearity. For our model VIF values are 2.5 (wt), 1.4 (qsec), and 2.5 (am), so it likely is not a problem. Chow's test can test for parameter stability. The dataset is split in half and the regression is done for the both halfs and then the combined residual sum of squares (RSS) is compared to the whole sample RSS. If it doesn't significantly differ, the parameters can be thought to be stable. For this model the chow test gives the p-value of 0.19 so the parameters should be stable. Lastly, the assumption that a straight line best fits the data might be wrong. Ramsey's RESET test is a test for this. Our model gets the p-value of 0.01, rejecting the null hypothesis of the linearity. Remedy to the non-linearity would be switch to a non-linear model.

In the end the model that we fit is not BLUE since the residuals are heteroskedastic. Generalized least squares method could be a better method for parameter esimation than OLS. But regardless, non-linear model could be a better fit to the data.
