# gerrymandering
Gerrymandering project for the 2020-21 STPF R Users AG. 


## Goal

The goal of this project is to create functionality in R to input a set of district boundaries and output metrics about them. 

### Collecting metrics 

There are lots of metrics to evaluate district boundaries, from statistical, demographic, or purely mathematical perspective. Our first goal of this project is to collect those metrics here. 

- [Here](http://www.ams.org/publicoutreach/feature-column/fc-2014-08) is an article from the American Mathematical Society about metrics for evaluating district shapes. The first 4 are compactness metrics. 
    * Polsby-Popper	
    * Reock	
    * Schwartberg	
    * Convex Hull	
    * Bizarreness	
- [3 tests of partisan gerrymandering](http://www.stanfordlawreview.org/wp-content/uploads/sites/3/2016/06/3_-_Wang_-_Stan._L._Rev.pdf), used by the [Princeton Gerrymandering project](https://gerrymander.princeton.edu/tests). [Lopsided wins](https://projects.fivethirtyeight.com/partisan-gerrymandering-north-carolina/) from 538.
    1. the excess seats test
    2. the lopsided outcomes test 
    3. the reliable-wins test
- [Efficiency gaps](https://www.nytimes.com/interactive/2017/10/03/upshot/how-the-new-math-of-gerrymandering-works-supreme-court.html) by the Upshot at NYT.
- [More efficiency gap metrics](https://www.tandfonline.com/doi/pdf/10.1080/00029890.2019.1609324?needAccess=true) from the American Mathematical Monthly journal. 
- [Compactness](https://arxiv.org/pdf/1803.02857.pdf)

### Data to evaluate 

Because we are in the DC area, and Virginia happens to have an anti-gerrymmandering amendment on the ballot in 2020 (which [passed](https://www.washingtonpost.com/elections/election-results/virginia-2020/#ballot-measures)!), we will start with Virginia data. 

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
