#!/bin/bash

cd /tmp
git clone http://github.com/stxxl/stxxl.git
cd stxxl
mkdir debug
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=/opt/osrm_infrastructure/stxx -DBUILD_STATIC_LIBS=ON ..
make -j4 && make install

cd..
mkdir release; cd release
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/osrm_infrastructure/stxx - DBUILD_STATIC_LIBS=ON  ..
make -j4 && make install  