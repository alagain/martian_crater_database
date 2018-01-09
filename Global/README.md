## Lagain_crater_database file

This catalog contains all craters of the Robbins catalog and craters added by the reviewer team, unidentified by Robbins.

Columns in the catalog are described as

#### Crater_ID
Same as in the Robbins' database.
For added craters ID has been built in the following way:
- northern hemisphere = 100-xxx,
- southern hemisphere = 200-xxx
where xxx corresponds to the creation index.

#### RADIUS
Same as in the Robbins' database.
Added craters has been defined as circles from three points placed on the crater rim: the radius is automatically computed.

#### X,Y
Coordinates, same as in the Robbins' database.
Added craters has been defined as circles from three points placed on the crater rim: the center is automatically computed.

#### TYPE
crater classification (int):
- 1 = Valid (Simple craters without morphologic characteristics described above)
- 2 = Layered (only Layered Ejecta Rampart Sinuous craters and Low-Aspect Ratio Layered Ejecta craters)
- 3 = Ghost (Degraded impact craters, the same geologic unit is superposed to the crater floor and outside to the crater)
- 4 = Secondary (Elongated craters or impact craters belonging to a crater chain in an area where the crater spatial density is anomalously high)
- 5 = Invalid (The geologic structure identified by Robbins is not an impact craters)

#### STATUS
crater classification (string):
- Valid
- Layered
- Ghost
- Secondary
- Invalid

#### LRD_MORPH
Layered ejecta crater morphology:
SLE : Single Layered Ejecta
DLE : Double Layered Ejecta
MLE : Multiple Layered Ejecta
LARLE : Low-Aspect Ratio Layered Ejecta

#### ORIGIN
Secondary craters for which the primary crater source has been identified.
The primary crater ID is indicated.
If the secondary crater is produced by a double primary crater, crater ID of both primaries is mentionned.

#### ADDING
null = Craters contained in the Robbins' database
1 = Craters added by the reviewers
