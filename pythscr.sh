#!/usr/bin/bash

echo "PYTHONPATH:: $PYTHONPATH"

echo "PATH:: $PATH"

echo "LD_LIBRARY_PATH:: $LD_LIBRARY_PATH"

pyver=`which python`

echo "Using python version $pyver"

python Flowdir.py


cat > locationpys.txt

86.70850 22.94925 1

col2map -N locationpys.txt outletpys.map --clone dem5.map


