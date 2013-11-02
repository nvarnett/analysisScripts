

###This function takes the "experiment summary" file from UMass' Eye Doctor software.
##File is .txt, formatted as tab-separated values

importEyeDrAcc <- function(filePath, subjNum){

    buffer <- read.delim(filePath, header = FALSE)

    ##how many obs are there?
    vLength <- length(buffer$V1)
    ##Which subject? Useful when bound together with other Df
    vSubj <- as.numeric(subjNum)

    ###Make a data.frame from the relevant bits
    ###KEY-VALUES for the buffer columns, from the eye Dr
    accData <- data.frame(SUBJ = as.factor(rep(vSubj, vLength)),
                          TRIAL = buffer$V2,            #2-trial ID
                          RIFix = buffer$V3,            #3-Reye fixations
                          FixMu = buffer$V4,            #4-fixations mean
                          FixSigma = buffer$V5,         #5-fixations SD
                          SaccMu = buffer$V6,           #6-saccade mean
                          SaccSigma = buffer$V7,        #7-saccade S.D.
                          nBlink = buffer$V8,           #8-num of Blinks
                          Corr = as.factor(buffer$V15)  #15-Resp correct?
                          ##Everything else is 0 or irrelevant
                          )
    ##CLEAN UP THE CORRECT RESPONSE COLUMN
    ##Where are the reading obs? (don't have button events, not relevant)
    vDrop <- with(accData, which(Corr=="0"))
    ##Prep safety check
    vYes <- length(which(accData$Corr=="1"))
    vNo <- length(which(accData$Corr=="-1"))
    vAns <- vYes + vNo
    ##Drop unused levels (i.e. replace with "NA")
    accData[vDrop,] <- NA
    accData <- na.omit(accData)
    return(accData)
}


