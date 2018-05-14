cd /mnt/c/Jen/ #...rest of directory... 
for i in {1..9}
do
echo "getting latitude and longitude for chunk$i"
curl --form addressFile=@chunk$i.csv --form benchmark=4 https://geocoding.geo.census.gov/geocoder/locations/addressbatch --output geocodeoutput$i.csv
#   echo file$i > fileout$i.txt
done
ls *output*csv > outfilelist.txt

