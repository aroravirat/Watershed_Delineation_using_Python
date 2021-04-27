# Watershed_Analysis_using_Python

## AIM : To calculated Watershed Delineation Using Python

## Abstract:

The watershed delineation is defined as the area of land which servesunder catchment of river or stream. Using watershed delineation we calculate stream order, flow directions, catchment area and basins.Watershed delineation is carried out using Digital Elevation Models (DEM). Digital Elevation Models (DEM) is grids of cell which contain information regarding the elevation in each cell. DEMs store same kind of information as contour lines do, but with different data structure. For many years engineers have been using paper maps for watershed delineation. But recently watershed delineation is carried out using software such as QGIS, ArcGIS, etc. but it seems to be too tedious and requires extensive training to use such software, hence we have developed an alternate method for doing such kind of analysis using Python script which can be implemented in any system using Bash Script. In this project we have developed a python algorithm to calculate flow direction, strahler order and catchment area using PCRaster module at a desired location. PcRaster is an open source module used for various spatio-temporal analysis with support of GDAL. It is also user friendly python module for watershed analysis. The result shows that this is most convenient and cheap method for watershed analysis. It also provides efficient and robust results.

## Watershed Analysis:

Watershed management has
received utmost importance from the countries itself.
Watershed Analysis involves extracting river or stream network,
flowdirections, catchment area or basins through manual or digital
means.
In simple words watershed is a region of land within which water flows
down into a specified body, such as a river, lake, sea, or ocean i.e. to
a drainage basin. The word watershed is sometimes used
interchangeably with drainage basin or catchment.

## Watershed Delineation Using PCRaster
PCRaster works on
python as well as it has GDAL supported library, hence it can be used
for Watershed Delineation. It’s a collection of software targeted at the
development and deployment of spatial and temporal environmental
models and analysis. Its main feature is that it allows scripting
development environment. Scripting languages include PCRcalc and
Python. It’s an Open source and free to use module. The GDAL library
allows converting raster maps between various platforms.

Lddcreate:
Lddcreate in the codes below represents Local drain direction, with
which flow directions from each cell to its steepest down slope
neighbor cell is calculated.


```
Result = lddcreate(elevation, outflowdepth, corevolume, corearea, catchmentprecipitation)
```

### Step 1:

Download all the required DEM tiles from https://search.earthdata.nasa.gov or Bhuvan website.

### Step 2:


If there are more than one tiles than built a mosaic or skip to step 3.
First include all tiff files to list file. 

```
dir *.tif > list.txt 

type list.txt

gdalbuildvrt -input_file_list list.txt dem_mosaic.vrt.

Or

gdal_merge.py -o Merged.tif -of GTIFF /home.../DEM_Tiles/*.tif

gdalwarp -t_srs EPSG:4326 -tr 30 30 -dstnodata -9999 dem_mosaic.vrt dem.tif 
```
Note: Here *.tif denotes all your tiff files.

PcRaster supports .map format hence we need to translate it to required format using GDAL commands.

### Step 3:

```
gdal_translate -of PCRaster -ot Float32 -mo VS_SCALAR dem.tif/merged.tif dem.map
```
View your DEM using aguila dem.map

Open the command prompt and we will visualize DEM by following command
```
aguila dem.map
```
In this case the DEM will look like:

![DEM](https://user-images.githubusercontent.com/76841630/116230868-c4d15f00-a775-11eb-92d3-34a3587b9d8a.jpeg)

### Step 4: Flow Direction 


In this step we are going to calculate flow directions using lddcreate (local drain direction) function. By specifying its elevation, outflow depth, core volume, core area and catchment precipitation values.

```
from pcraster import*

DEM = readmap ("/home/…/.map")

FlowDirection = lddcreate(DEM,3601,3601,2777,7999)

report(FlowDirection,"/home/.../FlowDirection.map")

```
Visualize Flowdirections map using:

```
aguila FlowDirection.map
```

![Strahler](https://user-images.githubusercontent.com/76841630/116233780-5e4e4000-a779-11eb-9b92-c267b6c11225.png)

### Step 5: 
Calculate Strahler order
To extract the network of streams or rivers we will use streamorder function. Stream order / Strahler Order is defined as the index of all streams delineated on a given local drain direction network. 
In the python script:
```
Strahler = streamorder(FlowDirection)
report(Strahler, "/home/.../strahler.map")

```

Visualize Stream order using:

```
aguila strahler.map
```
![Strahler](https://user-images.githubusercontent.com/76841630/116233780-5e4e4000-a779-11eb-9b92-c267b6c11225.png)

### Step 6:
The results of strahler order doesn’t differntiate between small streams and large streams. Hence, in order to get larger streams, we will delineate streams above strahler index  8. 

```
Strahler8 = ifthen(Strahler > 8 , boolean(1))

report(Strahler8, "strahler8.map")

```
![Strahler8](https://user-images.githubusercontent.com/76841630/116233638-2c3cde00-a779-11eb-86ff-0e84d7c07750.png)

### Step 7: 

Catchment delineation

To find catchment delineation we will specify the co-ordinates in a text file using following commands in command prompt:

```
cat > location.txt

78.5974 30.1451 1

```
We will clone this text file which contains coordinates to a PCRaster format using GDAL command. 

```
col2map -N location.txt outlet.map --clone dem.map 
```
Step 8: 

To view catchment area delineated with the help of flow direction and coordinates specified we will open Python Script:

```
outlet = readmap ("/home/.../outlet.map”)

RurCatchment = catchment(FlowDirection,outlet) 

report(RurCatchment,"rurcatchment.map") 

```
In the command propmt:

```
aguila rurcatchment.map
```

Results:

![catchment](https://user-images.githubusercontent.com/76841630/116233419-e253f800-a778-11eb-9e62-1d7fe96f81ce.png)
