#!/bin/bash

cd /opt
wget -O Project-OSRM-4.1.8.zip https://github.com/DennisOSRM/Project-OSRM/archive/v4.1.8.zip
unzip Project-OSRM-4.1.8.zip osrm-backend
cd osrm-backend
sed -i 's| -pedantic||' CMakeLists.txt
mkdir build; cd build
cmake  -DLUABIND_INCLUDE_DIR=/opt/osrm_infrastructure/luabind-0.9.1/include -DLUABIND_LIBRARY=/opt/osrm_infrastructure/luabind-0.9.1/lib/libluabindd.so \
-DLUAJIT_LIBRARIES=/opt/osrm_infrastructure/LuaJIT-2.0.2/lib/libluajit-5.1.so -DLUAJIT_INCLUDE_DIR=/opt/osrm_infrastructure/LuaJIT-2.0.2/include/ \
-DSTXXL_LIBRARY=/opt/osrm_infrastructure/stxx/lib/libstxxl.a -DSTXXL_INCLUDE_DIR=/opt/osrm_infrastructure/stxx/include  -DOSMPBF_LIBRARY=/usr/local/lib/libosmpbf.a -DOSMPBF_INCLUDE_DIR=/usr/local/include/ -DBOOST_LIBRARYDIR=/usr/lib64 ..