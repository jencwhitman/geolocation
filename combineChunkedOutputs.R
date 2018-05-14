remove(list=ls())
##########Things to be set by the user
directory="nameofdirectorycontainingoutputfiles"

####################### the code...
setwd(directory)
library(stringr)

outfilelist<-read.delim("outfilelist.txt",header=F)
numoutfiles<-nrow(outfilelist)
# note: check that the geocoder site didn't skip any chunks first

alloutput<-NULL
for (section in 1:numoutfiles){
	fname<-paste("geocodeoutput",toString(section),".csv")
	fname<-str_replace_all(fname, fixed(" "), "") 
	currentoutfile<-read.csv(fname,header=F,sep=",")
	alloutput<-rbind(alloutput,currentoutfile)
	section
	nrow(alloutput)
}
allnrow<-nrow(alloutput)


outfilepath<-paste(directory,"LatnLong.csv")
outfilepath<-str_replace_all(outfilepath, fixed(" "), "")
write.csv(alloutput, file = outfilepath, row.names=FALSE)
