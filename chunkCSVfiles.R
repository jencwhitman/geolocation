
remove(list=ls())
#######################################################
### purpose of script is to take data files
### with addresses, and to get latitude and longitude for each row.
### then will recombine the output file chunks saved from website output

##########Things to be set by the user
directory="maindirectoryname/"
district="subdirectoryname/"
infilenameMain="filenamewithoutcsvextentionadded"
NumRowsTarg=9000; # because https://geocoding.geo.census.gov maxes out at 10,000 rows
# NumRowsTarg=desired number of rows per chunk 

####################### the code...
infilenameExt=".csv"
infilepath=paste(directory,district,infilenameMain,infilenameExt)

library(stringr)
infilepath<-str_replace_all(infilepath, fixed(" "), "")
infilepath

DataAllRows <- read.csv(infilepath, header=FALSE, sep=",")

total_length=nrow(DataAllRows)
total_length/NumRowsTarg
nsrounded<-round(total_length/NumRowsTarg) # works if it ends up rounding down
if (nsrounded < total_length/NumRowsTarg) {
	numsections<-nsrounded+1
}else{
numsections<-nsrounded
}

sectionRowInds=matrix(0,numsections,2)
startrow=2
endrow=1
for (section in 1:numsections) {
	if ( (startrow+NumRowsTarg-1) > total_length) {
		endrow <- total_length
	} else {
		endrow <- startrow+NumRowsTarg-1
	}

	sectionRowInds[section,1]<-startrow
	sectionRowInds[section,2]<-endrow
	startrow=startrow+NumRowsTarg
}
sectionRowInds
nrow(DataAllRows)



for (section in 1:numsections) {
	currentchunk<-DataAllRows[sectionRowInds[section,1]:sectionRowInds[section,2],]
	outfilepath<-paste(directory,district,"chunk",toString(section),".csv")
	outfilepath<-str_replace_all(outfilepath, fixed(" "), "")
	write.csv(currentchunk, file = outfilepath, row.names=FALSE)
}


# file was then uploaded into https://geocoding.geo.census.gov/geocoder/locations/addressbatch?form 
# selecting the 'address batch' option under 'find locations using...'
# took about 1 min to process each chunk of 9000 rows.





