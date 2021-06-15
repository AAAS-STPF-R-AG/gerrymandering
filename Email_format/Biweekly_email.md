---
title: R Users biweekly meeting
output: html_document
---


Hi all,

R 4.1 and Rstudio 1.4 are out now, see blog post [here](https://blog.rstudio.com/2021/06/09/rstudio-v1-4-update-whats-new/). In addition to the native pipe operator |>, r has a new graphics engine. 

R you ready to talk about R. Come learn what forcats is and why it's not fordogs? Do you want to talk about spatial || special data? Do you need frames for your tables? R you having trouble with tibbles? 

```{r}
pacman::p_load(pacman, tidyverse, lubridate)
dayOfMeeting <- mdy("06-16-2021")
timeOfMeeting <- "5:30pm" # could be included in date as mdy_hm
sprintf("The R Users AG will meet tomorrow, %s, Wednesday at %s, to talk about R.", date, time) |>
  print()
```
  


[Zoom link](https://nih.zoomgov.com/j/1611027635?pwd=aW1mWThqYkRoMjZhN1JUR2RVTTJEZz09)

See you TheRe!

Mike
