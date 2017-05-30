#!/bin/bash
#
##########################################
# Accept 2 arguments
# $1 is the input GeoJSON file name
# $2 is the output shape file name
##########################################

file=$2
s=${file##*/}
filename="${s%.*}"
echo $file
echo $filename
ogr2ogr -f "ESRI Shapefile" $2 $1
ogrinfo $file -sql "ALTER TABLE $filename RENAME COLUMN Radius TO StrRadius"
ogrinfo $file -sql "ALTER TABLE $filename ADD Radius FLOAT"
ogrinfo $file -dialect SQLite -sql "UPDATE '$filename' SET Radius=CAST(StrRadius AS Float)"
ogrinfo $file -sql "ALTER TABLE $filename DROP COLUMN StrRadius"
ogrinfo $file -sql "ALTER TABLE $filename DROP COLUMN Valid"
ogrinfo $file -sql "ALTER TABLE $filename DROP COLUMN Secondary"
ogrinfo $file -sql "ALTER TABLE $filename DROP COLUMN Ghost"
ogrinfo $file -sql "ALTER TABLE $filename DROP COLUMN Uncertain"
ogrinfo $file -sql "ALTER TABLE $filename DROP COLUMN Invalid"
ogrinfo $file -sql "ALTER TABLE $filename DROP COLUMN Layered"
ogrinfo $file -sql "ALTER TABLE $filename ADD Status STRING"
ogrinfo $file -dialect SQLite -sql "UPDATE '$filename' SET Status=\"Valid\", OGR_STYLE=\"SYMBOL\(c:#00FF00\)\" WHERE flagColor=\"0, 255, 0, 1\""
ogrinfo $file -dialect SQLite -sql "UPDATE '$filename' SET Status=\"Invalid\", OGR_STYLE=\"SYMBOL(c:#FF0000)\" WHERE flagColor=\"255, 0, 0, 1\""
ogrinfo $file -dialect SQLite -sql "UPDATE '$filename' SET Status=\"Uncertain\", OGR_STYLE=\"SYMBOL(c:#0000FF)\" WHERE flagColor=\"0, 0, 255, 1\""
ogrinfo $file -dialect SQLite -sql "UPDATE '$filename' SET Status=\"Ghost\", OGR_STYLE=\"SYMBOL(c:#FFFFFF)\" WHERE flagColor=\"255, 255, 255, 1\""
ogrinfo $file -dialect SQLite -sql "UPDATE '$filename' SET Status=\"Secondary\", OGR_STYLE=\"SYMBOL(c:#FF00FF)\" WHERE flagColor=\"255, 0, 255, 1\""
ogrinfo $file -dialect SQLite -sql "UPDATE '$filename' SET Status=\"Layered\", OGR_STYLE=\"SYMBOL(c:#190000)\" WHERE flagColor=\"25, 0, 0, 1\""

