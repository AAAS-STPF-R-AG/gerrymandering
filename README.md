# gerrymandering
Gerrymandering project for the 2020-21 STPF R Users AG. 


## Goal

The goal of this project is to create functionality in R to input a set of district boundaries and output metrics about them. 

- Federally, only requirement is that all districts have roughly equal population 
- Redistricting in VA [Wiki](https://en.wikipedia.org/wiki/Redistricting_in_Virginia), [Ballotpedia](https://ballotpedia.org/Redistricting_in_Virginia)


### Restrictions on Districts 

What requirements does a district have to meet in Virginia to qualify as a valid district? School board level, State House, State Senate, US House of Reps, etc. 

### Collecting metrics 

There are lots of metrics to evaluate district boundaries, from statistical, demographic, or purely mathematical perspective. Our first goal of this project is to collect those metrics here. 

- [Here](http://www.ams.org/publicoutreach/feature-column/fc-2014-08) is an article from the American Mathematical Society about metrics for evaluating district shapes. The first 4 are compactness metrics. **Mike** 
    * Polsby-Popper	
    * Reock: ratio of the area of the polygon (district) to the area of the smallest circle cirumscribing the polygon. 
    * Schwartberg: ratio of the perimeter of the polygon (district)	to the perimeter of the circle with the same area as the polygon
    * Convex Hull	
    * Bizarreness 	
    * More on [Compactness](https://arxiv.org/pdf/1803.02857.pdf)
- [3 tests of partisan gerrymandering](http://www.stanfordlawreview.org/wp-content/uploads/sites/3/2016/06/3_-_Wang_-_Stan._L._Rev.pdf), used by the [Princeton Gerrymandering project](https://gerrymander.princeton.edu/tests). [Lopsided wins](https://projects.fivethirtyeight.com/partisan-gerrymandering-north-carolina/) from 538. **Brandon** 
    1. The Excess Seats Test
    
  Requires a computer simulation available at princeton.gerrymander.edu which can be calculated from national trends in a given election. Not worth replicating though source does indicate that the software can be requested directly too
    
  Provides a delta, based on actual seats vs expected seats based on nation trends, divided by the standard deviation of the expected. The difference can be linked to a p value (I don't know how just yet - can research)
      
  This just alerts us that the state likely differed from nationwide trends, not why.
    2. The Lopsided Outcomes Test 
      
  t-test on the shares of votes winners got in their districts, split between R and D.

  If there is a statistically significant difference, this is evidence that margins were targeted (shore up and win 'just barely' in districts the party wants to win, and lump a lot of other party's votes into a few throwaway districts)

    3. the reliable-wins test
     
  The reliable wins test
  Separate whether the state is split or dominated by the gerrymandering party if a closely divided state: 
  Need vote share for each district for a party 
  Compare median and mean vote share across districts 
  Delta = (mean - median)/(0.756* SE vote shares across N districts) 
  SE = SD/sqrt(N)
      
  if dominant party:
  chi-squared test on standard deviation of vote shared in districts won in state vs nationally
- [Efficiency gaps](https://www.nytimes.com/interactive/2017/10/03/upshot/how-the-new-math-of-gerrymandering-works-supreme-court.html) by the Upshot at NYT. **Kristin**
- [More efficiency gap metrics](https://www.tandfonline.com/doi/pdf/10.1080/00029890.2019.1609324?needAccess=true) from the American Mathematical Monthly journal. 
- [Efficiency gap definition](https://chicagounbound.uchicago.edu/cgi/viewcontent.cgi?article=1946&context=public_law_and_legal_theory) in the original article defining the idea and a [brief explanation](https://www.brennancenter.org/sites/default/files/legal-work/How_the_Efficiency_Gap_Standard_Works.pdf) from the Brennan Center for Justice at NYU. **Stu**

- Population Density metrics, i.e. "packing and cracking" **Justin**

- [Here](https://mggg.org/) is another mathematical project investigating metrics on gerrymandering, at Tufts University. **Stu**

### Data to evaluate 

Because we are in the DC area, and Virginia happens to have an anti-gerrymmandering amendment on the ballot in 2020 (which [passed](https://www.washingtonpost.com/elections/election-results/virginia-2020/#ballot-measures)!), we will start with Virginia data. 

Potential Data Source

- FEC Data https://www.fec.gov/introduction-campaign-finance/election-and-voting-information/
- Disctrict maps
- TidyCensus R package

### Existing gerrymandering resources in R 

- [`redist` package](https://cran.r-project.org/web/packages/redist/redist.pdf), [GitHub repo](https://github.com/kosukeimai/redist)
- [`mandeR` package](https://github.com/gerrymandr/mandeR)
- [Metric Geometry and Gerrymandering Group](https://mggg.org/), [GitHub organization](https://github.com/gerrymandr)
- [Using the `spatstat` package](https://www.r-bloggers.com/2012/12/measuring-the-gerrymander-with-spatstat/), [website](http://spatstat.org/)
- [`BARD` package](https://pdfs.semanticscholar.org/7c1e/3a665e12a631430f1156414772ffc28524d2.pdf), removed from CRAN. 

Source: [Princeton Gerrymandering Project](https://gerrymander.princeton.edu/reforms2019/va/)

## TODO

- Find other metrics 
- Put links here 
- Add found PDFs to the repo so others can read and easily access. 
