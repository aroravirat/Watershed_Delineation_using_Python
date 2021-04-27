#!/usr/bin/bash

echo "Hello";

gdal_translate -of PCRaster -ot Float32 -mo VS_SCALAR /home/omkar/Documents/DEM_Bhuvan/Aster_DEM_WB/ASTGTMV003_N21E087_dem.tif dem3.map

python <<END_OF_PYTHON

from pcraster import*

DEM = readmap ("/home/omkar/dem3.map")

FlowDirection = lddcreate(DEM,3601,3601,0.000277778,72.9999)

report(FlowDirection,"FlowDirection.map")

Strahler = streamorder(FlowDirection)

report(Strahler, "/home/omkar/Documents/DEM_Bhuvan/Aster_DEM_WB/Single_dem/strahler2.map")

Strahler8 = ifthen(Strahler > 8 , boolean(1))
report(Strahler8, "strahler8.map")

END_OF_PYTHON

cat > location2.txt
87.209 21.7376 1

col2map -N location2.txt outlet2.map --clone dem3.map


python <<END_OF_PYTHON

outlet = readmap("/home/omkar/outlet2.map")
RurCatchment = catchment(FlowDirection,outlet)
report(RurCatchment,"rurcatchment2.map")

END_OF_PYTHON


gdal_translate -of GTiff FlowDirection.map FlowDir.tiff

gdal_polygonize.py FlowDir.tif -f "ESRI Shapefile" flowdirection_shp.shp




