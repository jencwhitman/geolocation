This is a linux shell script for submitting csv files with street addresses to the census.gov geocoder 
in order to get latitudes and longitudes.
Because the site won't take batch inputs of more than 10,000 entries, we broke our data into
9000 row chunks first in a separate r script.
