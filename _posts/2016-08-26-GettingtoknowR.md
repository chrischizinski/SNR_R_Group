---
title: "Getting to know R: a very brief introduction"
date: August 26, 2016
tags: [R]
---

<img style="float: right;" src="/SNR_R_Group/figs/R.jpeg">

## What is R?   

R is an open-sourced computer language that allows you to conduct data analysis and programming  It is extremly versatile with almost 9000 packages that allow you to do pretty do anything, from spatial statistics to data wrangling to publication graphics.  In fact, this document was written with `R` and `Rstudio`.

A reason for its acceptance among researchers ([5th place in IEEE language rankings](http://spectrum.ieee.org/static/interactive-the-top-programming-languages-2016) is its versatility.  R can be used as an *object-oriented programming language*, or as a statistical environment where functions can be run line-by-line to analyze data. 

### Why R?

- R runs on Windows, Mac-OS, and Unix operating systems
- R provides a vast number of useful statistical tools (and you can write your own)
- R produces publication-quality graphics in a variety of formats
- R allows you to generate documents and html 
- R can be intergrated with many other programming languages.
- R scales, making it useful for small and large projects.
- There is a huge user base with lots of blogs and answers for your guarenteed many, many questions

### Why not R?

- R can do a lot but it cannot do everything.
- There is a decent learning curve
- There have been many improvements over the years but some of the documentation can be opaque.
- R will make you want to throw your computer through the wall at some point. 
-  Contributed packages go through a lot of testing but some are better and more reliable than others 
- R steers clear of point-and-click analysis


## Where can I get R?
It is best to download R from CRAN ([Comprehensive R Archive Network](https://cran.r-project.org/)).  It can be installed on  Linux, Windows, or Mac operating systems.  The current stable version will be available following the link to your operating system.  If you are installing on a Windows machine, you will want to select from the **base** link.  

## How do I run R?
There are many ways that you can run R (terminal to GUI).  You can run R from its basic GUI, while OK it does not have some of the bells and whistles other GUIs have.  

My favorite GUI is [RStudio](https://www.rstudio.com/home/)  RStudio truly makes R easier to use. It includes a code editor with syntax highlighting, debugging, and visualization tools. 

Using R, you have the options of running code from the console or by saving and reusing scripts.  I tend to only use the console for one off things, like pulling up a help page.  I keep all of my code in scripts which allows me to reuse code and run things again at a later time.  When writing a report or a publication for peer review, you are almost always asked to report something different or revise previous analysis so it is best to work from the script.  To maintain good housekeeping I always label these with the data at the end of the filename.  For example, I will name my file `bird_analysis-08-17-16.R` and that way it is easy to keep up to date with the most current version.  In the the next few sessions we will be diving fully into working with R. 

## How do I learn R?
I will come right out and say it.  R is not easy.  You will not be able to half ass it and be able to understand R.  I came from a background of working with SAS and Matlab and there are still things I do not fully understand.  I started learning R in 2007 as a postdoc at the University of Minnesota and it took me a while.  I believe the best strategy is **immersion**.  Do not give yourself an out (i.e., use point-and-click propiertory software) and struggle.  Over time you will begin to recognize the nuances of the language and how to use it to its fullest ability (even if this requires hacks and work-arounds).  I tell students frequently that learning R is like learning a foreign language.  How do you best learn that language?  Immersion.  You go to that country and live there, forcing you to learn how it is.  R is no different.   

There are three areas that I know I struggled with in R and know lots of students (used in the loose sense referring to anyone trying to learn R) that have found these things problems similarly.  

1. Getting data into R
2. Understanding the structure of your data (e.g., selecting columns and rows)
3. Understanding the error messages

I think if you can develop an understanding of these three things, you will be able to get around most of what occurs in R.  We will spend more time developing a greater understanding of these areas in subsequent lessons.  

## How do I get help in R?
The beauty of R and its large and diverse user base is that there is a lot of help out there for you.  There are sources that tend to be more prickley (e.g., [R mailing lists](https://www.r-project.org/mail.html)), to moderatly so (e.g., [stackoverflow](http://stackoverflow.com/questions/tagged/r)), and most forgiving (e.g., [google groups](https://groups.google.com/forum/#!forum/unmarked)).  

  
There tend to be three areas that I think students learning R get tripped up on when trying to find help. 

- The first is a general "How do I do so and so in R?" and my solution to that is simple.  Call up your favorite search engine and do a search for your question (and add "in R").  For example, to search how to do a linear regression in R, I would pull up google and search "linear regression and R."  Generally, your search results will include tutorials, packages, or questions posted on the online help sites.  
- The second is "how do I use this function in R?"  Like the first bullet you can always do a search and come up with an answer.  There are several ways to find help within R for a particular function.  `help(function_name)` or `?function_name` will bring up the documentation on the particular function you are interested in.  This is where I almost always start when I am having issues with a particular function because the pages called will have the input parameters and various options.  
- The third is "What does this warning or error mean?" Part of this will come as you spend more and more time learning the R language but everyonce in a while you will get an error that you have no clue.  Very often I will copy that error from the console and past it into google.     

<img style="float: right;" src="/SNR_R_Group/figs/noreproexample.png">

Generally when you are trying to help, whether you are using an online source or the R guru down the hall, it important to do your homework ahead of time.   The key to getting good feedback no matter from what source is to 1) Google search the issue.  It is more than likely that someone else has already had the issue, 2) do not make it seem like you are asking questions about a homework assignment, and 3) provide a [reproducible example](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example).  I think going through the process of trying to make a reproducible example ends up helping you solve your issue before you even post to one of the help sites. 
