#### Lagain_crater_database file ####

Columns in the catalog are described as

### Crater_ID
Same as Robbins' database except for craters added for which ID has been built from their location: northern hemisphere = 100-xxx, southern hemisphere = 200-xxx, -xxx corresponds to the order of creation.

### RADIUS
Same as Robbins' database except for craters added for which the radius has been determined from three points placed on the crater rim.

### X,Y
Coordinates, same as Robbins' database except for craters added for which it corresponds to the centroid of circle shape created on Cesium.

### TYPE
crater classification (numerical):
1 = other
2 = layered
3 = degraded
4 = secondary
5 = misidentified entry

### STATUS
crater classification (text)

### LRD_MORPH
Layered ejecta crater morphology:
SLE : Single Layered Ejecta
DLE : Double Layered Ejecta
MLE : Multiple Layered Ejecta
LARLE : Low-Aspect Ratio Layered Ejecta

### ORIGIN
Secondary craters for which the primary crater source has been identified. The primary crater ID is indicated. In case of double primary craters being produced secondaries, the crater ID of the couple is mentionned.

### ADDING
0 = Craters contained in the Robbins' database
1 = Craters added on Cesium viewer
