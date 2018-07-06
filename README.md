## Overview

We start our model building with exploratory data analysis. In the pairwise plot, we discover that there is a strong marginal linear relationship between Income and Balance, Limit and Balance, and Rating and Balance. However, there seems to be collinearity among Income, Limit and Rating. Other variables are mostly randomly distributed and hard to detect any pattern. In the box plots, we discover that Student’s plot has shifted from the "No" category to the "Yes" category, which is not discovered in other box plots. So, we conclude that Income, Limit, Rating and Student may be useful in explaining the Balance and simple linear regression model may be a suitable choice for now.

We then look at the full model. Since a lot of coefficients are marginally not significant, the R-squared coefficient is extremely high and we only have 115 observations. Therefore, we conclude that the full model is overfitting. We then check the residual plots and conclude that our assumptions about the model are roughly met.

Because we only have 11 variables, we apply the exhaustive model search. We find that the adjusted R-squared coefficient suggests a model with Income, Limit, Cards and Student as predictors. Moreover, the BIC score suggests a model with Income, Limit and Students as predictors. These results are consistent with our exploratory data analysis. Additionally, it is not surprising to see that Rating is not in the model, since Limit and Income are in the model.

So, we concentrate on these two models. In the coefficient summary, we find that both models perform very well, since they have very high R-squared coefficients and very small p-values for each coefficient. We then conduct the added variable test and find that each variable does contribute its explanatory power to the model.

Finally, we run the residual plots for both models. We find that the model with Income, Limit and Students performs much better than the other model in this respect. Although the anova test indicates preference of the other model, we still choose the model with Income, Limit and Students as our final model because of its good residual performance, better interpretability and already high enough R square (0.9905).

## Variable Descriptions

- `Income:` The income of the individual.
- `Limit:` The credit limit of the individual.
- `Rating:` The credit rating of the individual.
- `Cards:` The type of card that the individual owns.
- `Age:` The age of the individual.
- `Education:` The education of the individual.
- `Gender:` The gender of the individual.
- `Student:` Whether the individual is a student or not.
- `Married:` Whether the individual is married or not.
- `Ethnicity:` The ethnicity of the individual.
- `Balance:` The credit balance of the individual.

If you would like to receive more details about the analysis, please refer to the Rmd code.


Final Model:

Balance= -682.8 - 10.14*Income + 0.3278*Limit + 492.9*Student
