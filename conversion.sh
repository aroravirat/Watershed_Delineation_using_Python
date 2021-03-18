#!usr/bin/bash


gdal_translate -of GTiff FlowDirection.map FlowDir.tiff

gdal_polygonize.py FlowDir.tif -f "ESRI Shapefile" flowdirection_shp.shp


