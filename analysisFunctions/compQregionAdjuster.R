###This function takes a data frame of accuracy data from the eye tracker
###and returns a Df with a vector for experimental regions

mapFile <- data.frame(item = seq(1, 41, 1),
                      region = rep(c("Matrix", "RC", "PP"),
                      length.out = 41))

adjustCompRegions <- function(accData, mapFile){

    ##path <- paste("./", mapFile, sep = "")

    ###How many obs to adjust?
    vLength <- length(accData$Corr)

    ###How many items to adjust?
    nItems <- length(levels(accData$ITEM))

    ##Make a vector to hold the regions.
    vRegions <- vector(mode = "double", length = vLength)

    ###How many regions?
    ##regionMap <- as.data.frame(read.csv(path, header = TRUE))

    ###Loop through each item
    for(i in 1:nItems){

        n <- as.numeric(i)
        ##Get the obs for that item
        i.obs <- with(accData, which(ITEM == i))

        ##Find the region that corresponds to that item
        vRegions[i.obs] <- as.character(mapFile$region[n])

        } #End item loop

    ##Put the region vector into the Df
    accData$Qregion <- vRegions
    return(accData)

    }
