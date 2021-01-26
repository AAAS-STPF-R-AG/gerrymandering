---
title: "3tests"
author: "Brandon Rohnke"
date: "1/26/2021"
output: html_document
---
[3 tests of partisan gerrymandering](http://www.stanfordlawreview.org/wp-content/uploads/sites/3/2016/06/3_-_Wang_-_Stan._L._Rev.pdf), used by the [Princeton Gerrymandering project](https://gerrymander.princeton.edu/tests). [Lopsided wins](https://projects.fivethirtyeight.com/partisan-gerrymandering-north-carolina/) from 538.

Dependencies
install.packages("EnvStats")
install.packages("readr")
install.packages("tidyverse")

##Example: 2018 Election Results
After saving Excel output from [Federal Election Commission](https://www.fec.gov/introduction-campaign-finance/election-and-voting-information/federal-elections-2018/), sheet 6: Table 5.  2018 Votes Cast for the U.S. House of Representatives by Party has the data we need. Save sheet as .csv
<!--Future work: look into ways to streamline this?-->  
Load table and trim to candidates in general election via removing rows with `NA` in `GENERAL %`
```r
library(readr)
house18 <- read_csv("how_to/3_tests/federalelections2018-US-House-results-by-state.csv")
house18.general <- house18[!is.na(house18$`GENERAL %`), ]
```  
The error message below is fine
`Warning message:
Missing column names filled in: 'X24' [24], 'X25' [25]
`  
We can filter down to two tables which contain districts Democrats won in VA (7) or Republicans won in VA (4)
Comma at end is important to define looking at rows
```r
Dems=house18.general[which(house18.general$PARTY=="D" & house18.general$`GE WINNER INDICATOR`=="W" & house18.general$`STATE ABBREVIATION`=="VA"),]
GOP=house18.general[which(house18.general$PARTY=="R" & house18.general$`GE WINNER INDICATOR`=="W" & house18.general$`STATE ABBREVIATION`=="VA"),]
```  
Verify that 11 districts in total (11 VA districts) through number of objects in each variable. In this case, we have 7 in Dems and 4 in GOP. This step helped us catch that `which()` was needed to play nicely with the strings and Boolean logic with multiple NA cells. Now that we have filtered to the winner in each district, we can convert the character to a number by trimming the %. We replace the Number % format with just the numbers (dividing by 100 could be optional here)
```r
Dems$`GENERAL %` = gsub("%", "", Dems$`GENERAL %`)
Dems$'GENERAL %'<-as.numeric(Dems$`GENERAL %`)
GOP$`GENERAL %` = gsub("%", "", GOP$`GENERAL %`)
GOP$'GENERAL %'<-as.numeric(GOP$`GENERAL %`)
```  
##Test 2
Test 2 performs a Students T test on winning vote shares split by R and D in a state. If the difference in means is statistically significant, then the two parties likely have an unequal distribution of margines. In conjunction with a party being flagged by Test 1, if that party has a statistically lower mean winning vote share, then it is possible that they have designed districts to spread out their voting blocks in order to more efficiently win seats (few wasted votes)  
Now we can run the t-test
<!--Look into whether we are running the correct T-test for our variables - we should assume populations of heterogenous variance-->
###t-test assumptions:
1. The two samples are independently and randomly drawn from the source population(s);T
2. The scale of measurement for both samples has the properties of an equal interval scale; andT
3. The source population(s) can be reasonably supposed to have a normal distribution.
```r
t.test(Dems$`GENERAL %`,GOP$`GENERAL %`,var.equal=F)
Test2_PVal<-t.test(Dems$`GENERAL %`,GOP$`GENERAL %`,var.equal=F)$p.value
```
Expected Output
```
	Welch Two Sample t-test
data:  Dems$`GENERAL %` and GOP$`GENERAL %`
t = 1.152, df = 8.1556, p-value = 0.282
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -7.157619 21.542619
sample estimates:
mean of x mean of y 
  65.4900   58.2975 
```
Democrats trend towards a higher margine of vote shares, so our alternative hypothesis if true would support the conclusion that there is gerrymandering in favor of the republicans in VA. However, we cannot reject the null hypothesis (p = 0.282) and thus Virginia House elections 2018 fail Test 2. Later, we look into Test 3, which can catch some different factors than Test 2. Below are some alternative options for Test 2  
###Mann-Whitney U Test assumptions:
1. Treatment groups are independent of one another. Experimental units only receive one treatment and they do not overlap.
2. The response variable of interest is ordinal or continuous.
3. Both samples are random.
```r
wilcox.test(Dems$`GENERAL %`,GOP$`GENERAL %`, conf.int = TRUE)
```
Expected Output
```r
	Wilcoxon rank sum exact test
data:  Dems$`GENERAL %` and GOP$`GENERAL %`
W = 17, p-value = 0.6485
alternative hypothesis: true location shift is not equal to 0
95 percent confidence interval:
 -9.06 26.03
sample estimates:
difference in location 
                  4.43 
```
Though not mandated (vote shares could be reasonably supposed to have a normal distribution), a Mann-Whitney test may be more appropriate than the t-test suggested by Wang et al. (2016). The alternative hypothesis is still rejected (p = 0.6485)  
###tidyverse options example setup
```r
library(tidyverse)
dems.df = house18.general %>% 
					filter(PARTY == 'D' & `STATE ABBREVIATION` == 'VA' & `GE WINNER INDICATOR` == 'W') %>%
					mutate(general_pct = parse_number(`GENERAL %`)/100)
gop.df = house18.general %>% 
					filter(PARTY == 'R' & `STATE ABBREVIATION` == 'VA' & `GE WINNER INDICATOR` == 'W') %>%
					mutate(general_pct = parse_number(`GENERAL %`)/100)
t.test(dems.df$`general_pct`,gop.df$`general_pct`,var.equal=F)
```  
##Test 3
Test 3 is also appropriate as the districts are roughly equally sized. To check this, we can combine the Dems and GOP tables into one, convert GENERAL VOTES column to numeric, and look at the standard deviation relative to the average number of votes  
```r
VADist<-rbind(Dems,GOP)
VADist$`GENERAL VOTES` = gsub(",", "", VADist$`GENERAL VOTES`)
VADist$`GENERAL VOTES` <-as.numeric(VADist$`GENERAL VOTES`)
sd(VADist$`GENERAL VOTES`, na.rm = TRUE)
mean(VADist$`GENERAL VOTES`)
```  
General votes in each district have a standard deviation of 30,091 votes with a mean of 186,551 votes. While Wang et al. (2016) do not indicate how much variation is allowed here, a SD of 16% of the total seems reasonably small. Then, for Test 3, we have two options:  
###Closely Divided State
When the redistricting party does not dominate. We do not have an exact metric of how close is 'closely divided'. However, if we wanted to test from the perspective of the Republican as the redistricting party, we compare median and mean vote share across R districts as follows:
$$Delta = (mean - median)/(0.756*SE vote shares across N districts)$$
```r
Test3_R_Delta<-(mean(GOP$`GENERAL %`)-median(GOP$`GENERAL %`))/(sd(VADist$`GENERAL %`)/sqrt(nrow(VADist)))
Test3_R_Delta
```  
The resulting Delta = o.232 is small. From Wang et al. (2016) pg. 1308:
"Delta is evaluated by comparison with significance values for the t-distribution. For Tests 2 and 3, statistical significance is typically reached when Delta exceeds 1.75"
But since it is also the t-score, we can ask R to do a reverse t-score calculation to obtain the *p*-value" (lower.tail = False):
```r
Test3_R_PVal<-pt(Test3_R_Delta,nrow(GOP),lower.tail = F)
Test3_R_PVal
```  
For Democrats (though we would likely not use this test given the 7/4 split):
```r
(mean(Dems$`GENERAL %`)-median(Dems$`GENERAL %`))/(sd(VADist$`GENERAL %`)/sqrt(nrow(VADist)))
```
Delta (for VA Dems in the House) = 0.776
This could be connected to a *p*-value as in the previous example.  
###State Redistricting Party Dominates
If we suspect the Democrats of gerrymandering in VA and want to test using 2018 House results, we would use a **chi-squared test for variance** to determine whether the variance in Democratic vote shares (by district) in Virginia is lower than (one-tailed test justified) the variance in vote shares in districts won by Democrats nationally. We would perform this test here because democrats won 7 of 11 districts with a mean vote share of 65.5%. Again, there's no exact threshold, so 'dominates' is vague. 
####EnvStats option
<!SD is the square root of the variance>
```r
library(EnvStats)
NatlD=house18.general[which(house18.general$PARTY=="D" & house18.general$`GE WINNER INDICATOR`=="W"),]
NatlD$`GENERAL %` = gsub("%", "", NatlD$`GENERAL %`)
NatlD$'GENERAL %'<-as.numeric(NatlD$`GENERAL %`)
varTest(Dems$`GENERAL %`,alternative = "l", conf.level = 0.95,sigma.squared = var(NatlD$`GENERAL %`))
Test3_D_PVal<-varTest(Dems$`GENERAL %`,alternative = "l", conf.level = 0.95,sigma.squared = var(NatlD$`GENERAL %`))$p.value
```
Out of curiosity, we can test from the perspective of Republican partisan districting:
```r
NatlR=house18.general[which(house18.general$PARTY=="R" & house18.general$`GE WINNER INDICATOR`=="W"),]
NatlR$`GENERAL %` = gsub("%", "", NatlR$`GENERAL %`)
NatlR$'GENERAL %'<-as.numeric(NatlR$`GENERAL %`)
varTest(GOP$`GENERAL %`,alternative = "l", conf.level = 0.95,sigma.squared = var(NatlR$`GENERAL %`))
```
We still can't reject the null hypothesis, but remember that this isn't the test we want to run for Test 3 on Republicans, as they do not dominate VA.  
####By hand (Democrate Party Example)
For a lower one-tailed test at significance level *p*<0.05, the lower bound of the zone of chance is equal to $(national standard deviation)*sqrt(χ^2^~α=0.05,N-1~/(N-1))$
For $N=7$, $χ^2^~α=0.05,6~=1.635
```r
NatlD_pctSD<-sd(NatlD$`GENERAL %`)/mean(NatlD$`GENERAL %`)*100
LowerBound_NatlD_pctSD<-NatlD_pctSD-NatlD_pctSD*sqrt(1.635/(nrow(Dems)-1))
VAD_pctSD<-sd(Dems$`GENERAL %`)/mean(Dems$`GENERAL %`)*100
NatlD_pctSD
LowerBound_NatlD_pctSD
VAD_pctSD
VAD_pctSD<LowerBound_NatlD_pctSD
```
This will report out the % SD of winning vote shares for Democrats nationally and uses a critical threshold value from the chi-squared distribution to determine a one-tailed confidence interval at alpha - 0.05
VAD_pctSD<LowerBound_NatlD_pctSD tests the alternative hypothesis that the variance in vote shares in Democrat-won districts in Virginia is lower than the national variance.
We get false, so we fail to reject the null hypothesis as when we ran varTest.  

##In summary
```r
Test2_PVal
Test3_D_PVal
Test3_R_PVal
```
Virginia elections for house Representatives show no significant lopsided outcomes (Test 2) and neither party shows statistically reliable wins (Test 3).