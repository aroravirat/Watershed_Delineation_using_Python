#!/usr/bin/bash

echo "PYTHONPATH:: $PYTHONPATH"

echo "PATH:: $PATH"

echo "LD_LIBRARY_PATH:: $LD_LIBRARY_PATH"

pyver=`which python`

echo "Using python version $pyver"

python Flowdir.py

python <<END_OF_PYTHON

import time

start_time = time.time()

print("--- %s seconds ---" % (time.time() - start_time))

END_OF_PYTHON


