---
title: "R Notebook"
output: html_notebook
---
```{r}
library(data.table)
library(glmnet)
library(DMwR)
library(MASS)
library(ROCR)
library(caret)
library(glmnet)
library(DMwR)
library(ROCR)
library(caret)
```
#Loading the data 

```{r}
rm(list = ls())
setwd("E:\\INSOFE RAR\\census")
train<- fread("census-income.data",na.strings = c(""," ","?","NA",NA))
test<-fread("census-income.test",na.strings = c(""," ","?","NA",NA))

str(train)
str(test)
summary(train)
summary(test)

```
#Name of attributes
```{r}
names(train) <-  c("age","class of worker","industry code","occupation code","education","wage per hour","enrolled in edu inst last wk","marital status","major Industry code","major occupation code","mace","hispanic Origin","sex","member of a labor union","reason for unemployment","full or part time employment stat","capital gains","capital losses","divdends from stocks","tax filer stat","region of previous residence","state of previous residence","detailed household and family stat","detailed household summary in household","Instance Weight","migration code-move in msg","migration code-change in reg","migration code-move within reg","live in this house 1 year ago","migration prev res in sunbelt","num persons worked for employer","family members under 18","country of birth father","country of birth mother","country of birth self","citizenship","own business or self employed","fill inc questionnaire for veteran's admin","veterans benefits","weeks worked in year","year","income_levels")	

names(test) <-c("age","class of worker","industry code","occupation code","education","wage per hour","enrolled in edu inst last wk","marital status","major Industry code","major occupation code","mace","hispanic Origin","sex","member of a labor union","reason for unemployment","full or part time employment stat","capital gains","capital losses","divdends from stocks","tax filer stat","region of previous residence","state of previous residence","detailed household and family stat","detailed household summary in household","Instance Weight","migration code-move in msg","migration code-change in reg","migration code-move within reg","live in this house 1 year ago","migration prev res in sunbelt","num persons worked for employer","family members under 18","country of birth father","country of birth mother","country of birth self","citizenship","own business or self employed","fill inc questionnaire for veteran's admin","veterans benefits","weeks worked in year","year","income_levels")

```

#Merging both test and train

```{r}
duplicate<-rbind(train,test)
dim(duplicate)
```
#Finding Null values in the given dataset
```{r}
#Null values in Train 
sum(is.na(train))
colSums(is.na(train)) #to get null of that particular  individual column 
colMeans(is.na(train)) #to percentage of null values of that particular column


#Null values in Test
sum(is.na(test))
colSums(is.na(test))
colMeans(is.na(test))

#NUll values in Duplicate (entire dataset)
colSums(is.na(duplicate))
colMeans(is.na(duplicate))
sum(is.na(duplicate))


```
#To find levels in Target variable
```{r}
unique(train$income_levels)
unique(test$income_levels)
```
#Seperating categorical and numerical attributes
```{r}
categorical=train[,c(2,5,7:16,20:24,26:30,32:36,38,42)]
Numerical=train[,c(1,3,4,6,17,18,19,25,31,37,39,40,41)]
colMeans(is.na(categorical))
colMeans(is.na(Numerical))


categorical_test=test[,c(2,5,7:16,20:24,26:30,32:36,38,42)]
Numerical_test=test[,c(1,3,4,6,17,18,19,25,31,37,39,40,41)]
colMeans(is.na(categorical_test)
colMeans(is.na(Numerical_test))

```

#Corelation Plot 
```{r}
corrplot(cor(Numerical),method="number")
dataaaaaa<-data.frame(cor(Numerical)) 
```

#feature engineering 
```{r}
train$income[train$income=='- 50000.']=0
train$income[train$income=='50000+.']=1


test$income[test$income=='- 50000.']=0
test$income[test$income=='50000+.']=1
```

#Data Preprocessing 
```{r}
#converting traget variable to factor
train$income_levels<-as.factor(train$income_levels)
test$income_levels<-as.factor(test$income_levels)
```

