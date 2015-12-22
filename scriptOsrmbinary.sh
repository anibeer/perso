#!/bin/bash

cd /tmp
git clone https://github.com/scrosby/OSM-binary.git
cd OSM-binary
mkdir build
cd build
cmake ..
make
make install