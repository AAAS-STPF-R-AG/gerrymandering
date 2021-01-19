---
output:
  pdf_document: default
  html_document: default
---
# Style guide
This is a guide I wrote for a different collaboration. If it is useful, use it, if not, don't. $\ddot\smile$



This document lays out guidelines and best practices for writing readable, hand-offable code. Keep in mind that someone (either you or someone else) will need to read and understand your code in the future.

This guide is a work in progress. If something could be more clear or something needs to be added, consider adding to this guide. 

General rules
===============
- Do use comments. Clear and concise is preferred but if in doubt write more.
- Empty lines should be empty, commented lines should have comments.
- Use whitespace. There should be a space after commas. Spaces around <- and logicals where it aids in viewing. 
- Use the outline tools Rstudio has built in that utilize commented lines ending in repeated - and =. 
- When posible use the automatic indentation. 
- Don't use CAPSLOCK, it reads as angry.
- Try not to use abbreviations or acronyms. This was good practice when there were character limits per line but this is no longer the case.



Specific naming conventions
============================
1. Iterative variable should have a uncapitalized descriptor as the beginning and Iterator as the ending of their name. They should be removed after the loop they are iterating for. For example:

```
for (articleIterator in 1:NumberOfArticles) { 
  ...
}
rm(articleIterator)

```

2. Persistent variables should be capitalized and each word in their name should be capitalized. These names should be descriptive. Try not to use abbreviations or acronyms. No underscores. For example:

```
LargeDataFrame <- data.frame()

```

3. Function names should be all lowercase and use underscores to separate words. For example:

```
get_data <- function(value1, value2)

```
4. Temporary variables should end in Tmp capitalized and each word in their name should be capitalized. No underscores. They should be removed when no longer in use. For example:

```
dataToAddTmp <- get_data(value1, value2)
LargeDataFrame[articleIterator,] <- dataToAdd

rm(dataToAddTmp)

```



