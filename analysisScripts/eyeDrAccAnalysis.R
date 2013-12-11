###This file if for analysis of the accuracy data from the "Bringing Structur Back" experiment
##Assumes that data has been imported and manipulated, as in the "ImportEyeDrAcc.R" file.

###Restrict attn to the experimental conditions
work.Acc <- subset(subjData, EXPT == "Specifiers")
work.Fill <- subset(subjData, EXPT == "Fillers")

##Fix the Corr factor; Make values interpretable, then de-factor (for stats)
levels(work.Acc$Corr) <- c("0", NA, "1")
y <- levels(work.Acc$Corr)[work.Acc$Corr]
work.Acc$Corr <- as.numeric(y)

levels(work.Fill$Corr) <- c("0", NA, "1")
y <- levels(work.Fill$Corr)[work.Fill$Corr]
work.Fill$Corr <- as.numeric(y)

options("scipen" = 100, digits = 6)

###The experimental items are significantly different than the fillers
t.test(work.Acc$Corr, work.Fill$Corr,
       var.equal = FALSE)

##What is the mean for each condition?
exptItem.Mu <- mean(work.Acc$Corr)*100 #Items, overall
fillerItem.Mu <- mean(work.Fill$Corr)*100 #Fillers, overall

with(work.Acc, tapply(Corr, COND, mean)*100)
