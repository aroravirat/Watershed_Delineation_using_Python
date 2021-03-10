#!/usr/bin/bash
echo "hello!";

python <<END_OF_PYTHON

from pcraster import*

DEM = readmap("/home/omkar/Documents/DEM_Bhuvan/Aster_DEM_WB/dem2.map")

FlowDirection = lddcreate(DEM,3601,3601,0.000277778,72.9999)

report(FlowDirection,"FlowDirection2.map")

END_OF_PYTHON

echo "Tumhi FlowDirection aguila FlowDirection2.map type karun pahu sakhta ";
