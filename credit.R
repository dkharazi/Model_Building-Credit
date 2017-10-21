## Read in Credit Data
load("") ## Enter the location of the "credit.Rdata" here
summary(newcredit)

## Pairwise Plot
plot(newcredit,pch=19,cex=0.25)

## Boxplots for categorical predictors
par(mfrow=c(2,2),cex.lab=2)
with(newcredit,{
  plot(Balance~Gender)
  plot(Balance~Student)
  plot(Balance~Married)
  plot(Balance~Ethnicity)
})

is.factor(newcredit$Gender)
is.factor(newcredit$Student)
is.factor(newcredit$Married)
is.factor(newcredit$Ethnicity)

levels(newcredit$Gender)
levels(newcredit$Student)
levels(newcredit$Married)
levels(newcredit$Ethnicity)

## Simple Linear Regression
## Fit full model
fitf = lm(Balance~Income+Limit+Rating+Cards+Age+Education+Gender+Student+Married+Ethnicity,data=newcredit)
summary(fitf)

## Residual plots
resf = rstandard(fitf)
plot(resf) #by index
plot(predict(fitf),resf)  # by predicted
plot(newcredit$Income,resf) # by income
plot(newcredit$Limit,resf)  # by credit limit
plot(newcredit$Rating,resf) # by credit rating
plot(newcredit$Cards,resf)  # by number of CC
plot(newcredit$Age,resf)    # by age
plot(newcredit$Education,resf) # by education level
hist(resf,main="") # histogram

## Residual boxplots for categorical predictors
par(mfrow=c(2,2))
with(newcredit,{
  plot(resf~Gender)
  plot(resf~Student)
  plot(resf~Married)
  plot(resf~Ethnicity)
})

## qq plot:
library(car)
qqPlot(resf)

## Exhaustive Model Search
library(leaps)
all.out=regsubsets(Balance ~ .,
                   data = newcredit,
                   nbest = 2,     # save the 2 best models for each number of predictors
                   nvmax = NULL,  # NULL for no limit on total number of variables in model
                   force.in = NULL, force.out = NULL,  # if we wanted to add constraints
                   really.big = FALSE, 	# default is false, set to true to enable exhaustive
                   # search when p>50.
                   method = "exhaustive")	# or "forward" for forward selection,
sum.reg=summary(all.out)

## Plot the best models of each size respect to Adjusted R2 and BIC
ixbest=seq(1,ncol(newcredit)*2-1,by=2)
par(mfrow=c(1,2))
plot(ixbest,sum.reg$adjr2[ixbest],pch=20,xlab="Model",ylab="adjR2",cex.lab=1,cex.axis=1)
abline(v=ixbest[which.max(sum.reg$adjr2[ixbest])])
plot(ixbest,sum.reg$bic[ixbest],pch=20,xlab="Model",ylab="BIC",cex.lab=1,cex.axis=1)
abline(v=ixbest[which.min(sum.reg$bic[ixbest])])

## Adjusted R2 suggests model 7
sum.reg$outmat[7,]  # Income, Limit, Cards, Student, 
## BIC suggested model 5
sum.reg$outmat[5,]  # Income, Limit, Student

fit7=lm(Balance~Income+Limit+Cards+Student,data=newcredit)
fit5=lm(Balance~Income+Limit+Student,data=newcredit)

summary(fit7)
summary(fit5)

## Better than "null" model?
fit0 = lm(Balance~1,data=newcredit)
summary(fit0)
anova(fit0,fit5)
anova(fit0,fit7)
##We reject null model and prefer the bigger model in both cases
##Our model is definitely better than the null model

##Anonva test
anova(fit5)
anova(fit7)

# Added variable plots
avPlots(fit7,cex=2)
avPlots(fit5,cex=2)
##Here, it indicates that each varaible is useful in the model


## Check model assumptions
## Residual plots for model 7
res7 = rstandard(fit7)
par(mfrow=c(2,3))
plot(res7) #by index
plot(predict(fit7),res7)  # by predicted
plot(newcredit$Income,res7) # by income
plot(newcredit$Limit,res7)  # by credit limit
plot(newcredit$Cards,res7)  # by number of CC
with(newcredit,{plot(res5~Student)})
par(mfrow=c(1,2))
hist(res7,main="") # histogram
qqPlot(res7)  #qq plot
#The Historgram of standard residuals seems to be inconsistent with normality assumption and qq plots performs not well.

## Residual plots for model 5
res5= rstandard(fit5)
par(mfrow=c(2,3))
plot(res5) #by index
plot(predict(fit5),res5)  # by predicted
plot(newcredit$Income,res5) # by income
plot(newcredit$Limit,res5)  # by credit limit
with(newcredit,{plot(res5~Student)})
par(mfrow=c(1,2))
hist(res5,main="") # histogram
qqPlot(res5)  #qq plot
##residual plots overall seems to be random and among -2 and 2.
##Although qq plot performs not that well, the histogram does seem to be relatively consistent with
##normality assumption. And we have some concern about it but not that huge.

## Model 5 vs model 7 through anonva test
anova(fit5, fit7)

## Selected Model
fit5=lm(Balance~Income+Limit+Student,data=newcredit)
summary(fit5)
avPlots(fit5,cex=2)

par(mfrow=c(2,3))
plot(res5) #by index
plot(predict(fit5),res5)  # by predicted
plot(newcredit$Income,res5) # by income
plot(newcredit$Limit,res5)  # by credit limit
with(newcredit,{plot(res5~Student)})
par(mfrow=c(1,2))
hist(res5,main="") # histogram
qqPlot(res5)  #qq plot