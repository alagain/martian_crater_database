#!/bin/bash
#
##########################################
# Accept 3 arguments
# $1 is the first shape file name
# $2 is the second shape file name
# $3 is the output shape file name
##########################################

file1=$1
filename1="${file1%.*}"
file2=$2
filename2="${file2%.*}"
file3=$3
filename3="${file3%.*}"
ogrinfo $file1 -dialect SQLite -sql "DELETE FROM $filename1 WHERE Status IS NULL"
ogrinfo $file2 -dialect SQLite -sql "DELETE FROM $filename2 WHERE Status IS NULL"
ogr2ogr -f 'ESRI Shapefile' $file3 $file1
ogr2ogr -f 'ESRI Shapefile' -update -append $file3 $file2 -nln merge
ogrinfo $file3 -dialect SQLite -sql "DELETE from $filename3 WHERE CRATER_ID IN (SELECT CRATER_ID from $filename3 GROUP BY CRATER_ID HAVING COUNT(*)>1) AND Status IS NOT NULL"

