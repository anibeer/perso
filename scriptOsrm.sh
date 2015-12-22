#!/bin/bash

cd /opt
wget -O Project-OSRM-4.1.8.zip https://github.com/Project-OSRM/osrm-backend/archive/v4.8.1.zip
unzip Project-OSRM-4.1.8.zip osrm-backend-4.1.8
cd osrm-backend-4.1.8
sed -i 's| -pedantic||' CMakeLists.txt
mkdir build; cd build
cmake  -DLUABIND_INCLUDE_DIR=/opt/osrm_infrastructure/luabind-0.9.1/include -DLUABIND_LIBRARY=/opt/osrm_infrastructure/luabind-0.9.1/lib/libluabindd.so \
-DLUAJIT_LIBRARIES=/opt/osrm_infrastructure/LuaJIT-2.0.2/lib/libluajit-5.1.so -DLUAJIT_INCLUDE_DIR=/opt/osrm_infrastructure/LuaJIT-2.0.2/include/ \
-DSTXXL_LIBRARY=/opt/osrm_infrastructure/stxx/lib/libstxxl.a -DSTXXL_INCLUDE_DIR=/opt/osrm_infrastructure/stxx/include  -DOSMPBF_LIBRARY=/usr/local/lib/libosmpbf.a -DOSMPBF_INCLUDE_DIR=/usr/local/include/ -DBOOST_LIBRARYDIR=/usr/lib64 ..