#!/bin/bash

cd /tmp
wget http://luajit.org/download/LuaJIT-2.0.2.tar.gz
tar -zxvf LuaJIT-2.0.2.tar.gz
cd LuaJIT-2.0.2
make install PREFIX=/opt/osrm_infrastructure/LuaJIT-2.0.2