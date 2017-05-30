#!/bin/bash
#
##########################################
# Accept 3 arguments
# $1 is the first shape file name
# $2 is the second shape file name
# $3 is the output shape file name
##########################################

file1=$1
s=${file1##*/}
filename1="${s%.*}"
file2=$2
s=${file2##*/}
filename2="${s%.*}"
file3=$3
s=${file3##*/}
filename3="${s%.*}"
json3=`echo $file3 | sed 's/.shp/.geojson/'`
echo $s
echo $json3

ogr2ogr -f 'ESRI Shapefile' $file3 $file1
ogr2ogr -f 'ESRI Shapefile' -update -append $file3 $file2
count=`ogrinfo $file3 -dialect SQLite -sql "SELECT a.CRATER_ID,a.Status from (SELECT CRATER_ID,Status FROM '$filename3' WHERE Status IS NULL) as a GROUP BY CRATER_ID HAVING COUNT(*)>1" | grep "Feature Count" | awk '{print $3}'`
echo $count
if [ !$count ]
then
  ogrinfo $file3 -dialect SQLite -sql "DELETE from '$filename3' WHERE Status IS NULL"
fi
rm $json3
ogr2ogr -f GeoJSON $json3 $file3
rm $file3
ogr2ogr -f 'ESRI Shapefile' $file3 $json3
count=`ogrinfo $file3 -dialect SQLite -sql "SELECT a.CRATER_ID,a.Status from (SELECT CRATER_ID,Status FROM '$filename3' WHERE Status IS NOT NULL) as a GROUP BY CRATER_ID HAVING COUNT(*)>1" | grep "Feature Count" | awk '{print $3}'`
echo $count
if [ $count ]
then
  rm $json3
  ogr2ogr -f GeoJSON $json3 $file3
  rm $file3
  ogr2ogr -f 'ESRI Shapefile' $file3 $json3
  ogrinfo $file3 -dialect SQLite -sql "UPDATE $filename3 SET Status=NULL WHERE CRATER_ID IN (SELECT CRATER_ID FROM $filename3 GROUP BY CRATER_ID HAVING COUNT(*)>1)"
  ogrinfo $file3 -dialect SQLite -sql "UPDATE $filename3 SET flagColor=\"255, 255, 0, 1\" WHERE CRATER_ID IN (SELECT CRATER_ID FROM $filename3 GROUP BY CRATER_ID HAVING COUNT(*)>1)"
  ogrinfo $file3 -dialect SQLite -sql "DELETE from $filename3 WHERE ROWID IN (SELECT min(ROWID) from $filename3 GROUP BY CRATER_ID HAVING COUNT(*)>1)"
  rm $json3
  ogr2ogr -f GeoJSON $json3 $file3
  rm $file3
  ogr2ogr -f 'ESRI Shapefile' $file3 $json3
fi
rm $filename3.geojson
ogr2ogr -f GeoJSON $json3 $file3
