---
title: "R tutorial for what test should I use"
author: "Zhengye"
date: "2019/10/10"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
### Purpose

This tutorial will help you to determine the best test for your condition. The data set we are using here can be found at link. The data are continous and describe values of 6 kinds of biomarkers for 144 animals by treatment.

### Flowchart

Here is the flowcahrt of tests

```{r grViz, echo=FALSE}
library(DiagrammeR)
grViz("digraph flowchart{
node [fontname=Helvetica, shape = rounded]
tab8 [label = '@@8']
tab9 [label = '@@9']
tab10 [label = '@@10']
tab13 [label = '@@13']
tab14 [label = '@@14']
tab16 [label = '@@16']

node [fontname = Helvetica, shape=oval]
tab2 [label = '@@2']
tab7 [label = '@@7']
tab12 [label = '@@12']

node [fontname = Helvetica, shape = plaintext]
tab1 [label = '@@1']
tab3 [label = '@@3']
tab4 [label = '@@4']
tab5 [label = '@@5']
tab6 [label = '@@6']
tab11 [label = '@@11']
tab15 [label = '@@15']

tab1 -> tab2;
tab2 -> tab3;
tab2 -> tab4;
tab3 -> tab5 -> tab7;
tab7 -> tab8;
tab7 -> tab9;
tab3 -> tab6 -> tab10;
tab4 -> tab11 -> tab12;
tab12 -> tab13;
tab12 -> tab14;
tab4 -> tab15 -> tab16;
}
  [1]: 'Continuous Data'
  [2]: 'Normally Distributed or Skewed'
  [3]: 'Normally distributed'
  [4]: 'Skewed'
  [5]: '2 groups'
  [6]: '2+ groups'
  [7]: 'Paired or Unpaired'
  [8]: 'Two sample t test'
  [9]: 'Paired t test'
  [10]: 'ANOVA (post hoc)'
  [11]: '2 groups'
  [12]: 'Paired or Unpaired'
  [13]: 'Wilcoxon Rank Sum'
  [14]: 'Wilcoxon Signed Rank'
  [15]: '2+ groups'
  [16]: 'Kruskal-Waliis (post hoc)'
      ")
```

### normality check
Many statistical tests require data to be normally distributed, this can be tested using a normality test, for example, Shapiro test. 
The null hypothesis of normality test is that there is no significant departure from normality. When the p is greater than .05, it fails to reject the null hypothesis and thus the assumption holds.

We are going to test if biomarker MMP3 with treatment 0 is normally distributed.

```{r}
biomarker=read.csv("/Users/deliciousway/Desktop/rExampleData.csv")
shapiro.test(biomarker[which(biomarker$Treatment==0),"MMP3"])
```
The p-value = 0.4031, which is above 0.05. It suggests MMP3 with treatment 0 follows normal distrbution.

### paired or unpaired

#### paired

If you collect two measurements on the same experimental unit, then each pair of observations is closely related. In that case, you should use the paired t-test to test the mean difference between these dependent observations if your data is normally distributed and has same variance. If your data does not meet the normality or homogeneity of variance assumption, you should use nonparametric method Wilcoxon Signed Rank test.

#### Unpaired

If you randomly sample each set of items separately, under different conditions, the samples are independent. The measurements in one sample have no bearing on the measurements in the other sample, then the samples are unpaired. You should use the 2-sample t test to compare the difference in the means if your data is normally distributed and have equal variance. If your data does not meet the normality or homogeneity of variance assumption, use nonparametric method Wilcoxon Rank Sum test.

it is important to use the correct test to prevent wrong results. 

### Two sample t test
1. Assumptions
    + Data are continous
    + Samples are simply random samples from their respective populations, which means taht each individual in the population has an equal chance of being selected in the sample. 
    + Two samples are independent
    + Data follow normal probability distribution
    + Variances of the two populations are equal

2. Goal: We want to compare the means of MMP3 with treatment 0 and treatment 5, to see if they are equal.

3. Code:
```{r}
shapiro.test(biomarker[biomarker$Treatment==5,"MMP3"])
var.test(biomarker[biomarker$Treatment==0,"MMP3"], biomarker[biomarker$Treatment==5,"MMP3"])
t.test(biomarker[biomarker$Treatment==0,"MMP3"], biomarker[biomarker$Treatment==5,"MMP3"], var.equal = T)
```

4. Interpret result:
Shapiro tests show that MMP3 with treatment 0 and 5 are both normal. Equal variance test shows that variances are equal for two groups. Finally, two sample t test p-value = 3.519e-07, which is below 0.05. The conclusion is to reject the null hypothesis and that the means of two treatment groups are significantly different.

5. Note:
Checking the assumptions is very important. If the normality check or the equal variance check fails, you need to use non-parametric methods Wilcoxon Rank Sum test, which will be introduced later.

### paired t test
1. Assumptions
    + Data (differences for the matched-pairs) are continous
    + Data follow a normal probability distribution.
    + The sample of pairs is a simple random sample from its population. 
    
2. Goal:The null hypothesis for paired t test assumes that the mean difference of two groups equals to 0. We want to check whether or not the corresponding MMP3 and CTXII for treatment 0 have the same mean. 

3. Code:
```{r}
shapiro.test(biomarker[biomarker$Treatment==0,"MMP3"] - biomarker[biomarker$Treatment==0,"CTXII"])
t.test(biomarker[biomarker$Treatment==0,"MMP3"], biomarker[biomarker$Treatment==0,"CTXII"],paired = T)
```

4. Interpret result:
Shapiro test shows that the difference between two groups follows normal, so we can continue to use paired t test. The paired t test p-value = 2.2e-16, which is below 0.05. The conclusion is to reject the null hypothesis and that the means of MMP3 and CTXII are significantly different.

5. Note:
Checking the assumptions is very important. If the normality check fails, you need to use non-parametric methods Wilcoxon Signed Rank test, which will be introduced later.

### ANOVA (post hoc)
1. Assumptions
2. Goal:
3. Code:
4. Interpret result:

### Wilcoxon Rank Sum
1. Assumptions
2. Goal:
3. Code:
4. Interpret result:

### Wilcoxon Signed Rank
1. Assumptions
2. Goal:
3. Code:
4. Interpret result:

### Kruskal-Wallis (post hoc)
1. Assumptions
2. Goal:
3. Code:
4. Interpret result:
