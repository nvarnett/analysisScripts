library(ggplot2)
library(plyr)
source("~/Dropbox/Work/Rscripts/HelperFunctions.R")

acc.summary <- ddply(work.Acc, .(VType, EmbSubj), summarize,
                     Mean = mean(Corr), SE = stdErr(Corr))

acc.base <- ggplot(work.Acc)
acc.base + geom_bar(aes(y = Corr, x = COND),
                    stat = "summary", fun.y = "mean",
                    colour = "darkgrey", alpha = .9)

acc.base + geom_bar(aes(y = Corr, x = Qregion),
                    stat = "summary", fun.y = "mean",
                    colour = "darkgrey", alpha = .9)
