## Overview

Banks play a crucial role in market economies. They decide who can get finance and on what terms and can make or break investment decisions. For markets and society to function, individuals and companies need access to credit. Credit scoring algorithms, which make a guess at the probability of default, are the method banks use to determine whether or not a loan should be granted. The goal of the analysis is to include participants to improve on the state of the art in credit scoring, by inferring the relationship between an individual's credit balance and other given variables.

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

## Conclusion

We find that the model with Income, Limit and Students performs much better than the other models. Although the ANOVA test indicates that we should prefer another model, we still choose the model with Income, Limit and Students as our final model because of its good residual performance, better interpretability, and already high enough R square (0.9905). Therefore, our final model is indicated below:

<p align="center">
  <img width="565" height="18" src="/graphics/Equation.png">
</p>
