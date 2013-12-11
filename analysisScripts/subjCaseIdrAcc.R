
###Import the data from Eye Dr.
###Files are "Experiment summary" files from Eye Dr.

##Make a vector of subject numbers
subjIDs <- c(2:4, 6:22)

##Make a vector of data file names
fileIDs <- c("002", "003", "004", "006",#no subj1,5 yet
             "007", "008", "009", "010",
             "011","012", "013", "014", "015",
             "016", "017", "018", "019", "020",
             "021", "022")
vLength <- length(subjIDs)

##Make a vector of file names; Serves as input to the import function
fileNames <- vector(mode = "double", length = length(subjIDs))
for(i in 1:length(subjIDs)){
    filePath <- "/Users/Nate/Dropbox/Work/Projects/SubjectFeature/eyeTrackerExpt/Analysis/accuracy/accData/eyeDrSummaries/"
    fileNames[i] <- paste(filePath,
                          as.character(fileIDs[i]),
                          "drSum.TXT",
                          sep = "")
    }

###Now import the eye Dr. files into R, format as a data frame
source("~/git/analysisScripts/importEyeDrSummary.R")
##Make a data frame to hold the subjects' obs
subjData <- data.frame()

for(f in 1:length(fileNames)){
    subjBuffer <- importEyeDrAcc(fileNames[f], subjIDs[f])
    SUBJ <- subjBuffer$SUBJ;
    TRIAL <- subjBuffer$TRIAL;
    RIFix <- subjBuffer$RIFix;
    FixMu <- subjBuffer$FixMu;
    FixSigma <- subjBuffer$FixSigma;
    SaccMu <- subjBuffer$SaccMu;
    SaccSigma <- subjBuffer$SaccSigma;
    Corr <- subjBuffer$Corr;

    subjData <- rbind(subjData, data.frame(SUBJ, TRIAL, RIFix, FixMu,
                                           FixSigma, SaccMu, SaccSigma,
                                           Corr))
    }


###Rename the TRIAL IDs to reflect experimental design
## ind <- with(accData, which(regexpr("^E{1}", accData$TRIAL)==1))
## d <- within(accData, which(regexpr("^E{1}", accData$TRIAL)==1))
## accData$EXPT <- accData$TRIAL
## EXPT <- levels(accData$TRIAL)
## levels(accData$EXPT)[ind] <- 'Specifiers'

###Add column to the Df for the EXPT id
vExpt <- subjData$TRIAL
vExpt <- gsub("E.*", "Specifiers", vExpt,
              perl = TRUE)
vExpt <- gsub("F.*", "Fillers", vExpt,
              perl = TRUE)
subjData$EXPT <- vExpt
subjData$EXPT <- factor(subjData$EXPT)

###Add a column to the Df for the item numbers
##Regexpr finds item ID in the string (= "I"n) and
##replaces the whole string with the number following "I".
vItems <- subjData$TRIAL
vItems <- gsub("^.*I(\\d{1,2}).*", "\\1", vItems,
               perl = TRUE)
subjData$ITEM <- vItems
subjData$ITEM <- factor(subjData$ITEM)

###Add a column for the condition ID
vCond <- subjData$TRIAL
##cond is "E1-8"; We find each occurence and rename as value following "E"
vCond <- gsub("^E(\\d{1}).*", "\\1", vCond,
              perl = TRUE)
vCond <- gsub("F.*", "Filler", vCond,
              perl = TRUE)
##Put the column into the Df, as a factor
subjData$COND <- vCond
subjData$COND <- factor(subjData$COND)
##Rename the levels to reflect factorial design
levels(subjData$COND) <- c("ECM", "SComp", "SCompAmb", "ObjCtrl",
                           "lgECM", "lgSComp", "lgSCompAmb", "lgObjCtrl",
                           "Filler")
###Add a factor for the embedded subject complexity manipulation
subjData$EmbSubj <- subjData$COND
levels(subjData$EmbSubj) <- c("simple", "simple", "simple", "simple",
                              "complex", "complex", "complex", "complex",
                              "Filler")
###Add a factor for the VType manipulation
subjData$VType <- subjData$COND
levels(subjData$VType) <- c("ECM", "SComp", "SCompAmb", "ObjCtrl",
                            "ECM", "SComp", "SCompAmb", "ObjCtrl",
                            "Filler")
###The for each sentence, the Df has a row for the sentence, and the Q
##Add a vector to id whether the ob is reading or Q
## vObType <- subjData$TRIAL
## y <- gsub("^.{4,7}D1", "Question", levels(vObType),
##                 perl = TRUE)
## yy <- gsub("^.{4,7}D0", "Sentence", y,
##                 perl = TRUE)

## yy <- gsub("^.{4,7}test", "test", y,
##                 perl = TRUE)
##                 #fixed = TRUE)
