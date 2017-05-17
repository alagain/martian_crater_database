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
ogr2ogr -f 'ESRI Shapefile' $file3 $file1
ogr2ogr -f 'ESRI Shapefile' -update -append $file3 $file2 -nln merge
count=`ogrinfo $file3 -dialect SQLite -sql "SELECT a.CRATER_ID,a.Status from (SELECT CRATER_ID,Status FROM '$filename3' WHERE Status IS NULL) as a GROUP BY CRATER_ID HAVING COUNT(*)>1" | grep "Feature Count" | awk '{print $3}'`
echo $count
if [ !$count ]
then
  ogrinfo $file3 -dialect SQLite -sql "DELETE from '$filename3' WHERE Status IS NULL"
fi
rm $filename3.geojson
ogr2ogr -f GeoJSON $filename3.geojson $file3
rm $file3
ogr2ogr -f 'ESRI Shapefile' $file3 $filename3.geojson
count=`ogrinfo $file3 -dialect SQLite -sql "SELECT a.CRATER_ID,a.Status from (SELECT CRATER_ID,Status FROM '$filename3' WHERE Status IS NOT NULL) as a GROUP BY CRATER_ID HAVING COUNT(*)>1" | grep "Feature Count" | awk '{print $3}'`
echo $count
if [ $count ]
then
  rm $filename3.geojson
  ogr2ogr -f GeoJSON $filename3.geojson $file3
  rm $file3
  ogr2ogr -f 'ESRI Shapefile' $file3 $filename3.geojson
  ogrinfo $file3 -dialect SQLite -sql "UPDATE $filename3 SET Status=NULL WHERE CRATER_ID IN (SELECT CRATER_ID FROM $filename3 GROUP BY CRATER_ID HAVING COUNT(*)>1)"
  ogrinfo $file3 -dialect SQLite -sql "UPDATE $filename3 SET flagColor=\"255, 255, 0, 1\" WHERE CRATER_ID IN (SELECT CRATER_ID FROM $filename3 GROUP BY CRATER_ID HAVING COUNT(*)>1)"
  ogrinfo $file3 -dialect SQLite -sql "DELETE from merge WHERE ROWID IN (SELECT min(ROWID) from $filename3 GROUP BY CRATER_ID HAVING COUNT(*)>1)"
  rm $filename3.geojson
  ogr2ogr -f GeoJSON $filename3.geojson $file3
  rm $file3
  ogr2ogr -f 'ESRI Shapefile' $file3 $filename3.geojson
fi
rm $filename3.geojson
ogr2ogr -f GeoJSON $filename3.geojson $file3
