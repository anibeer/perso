#!/bin/bash

cd /tmp
wget http://sourceforge.net/projects/luabind/files/luabind/0.9.1/luabind-0.9.1.tar.gz
tar -zxvf luabind-0.9.1.tar.gz 
cd luabind-0.9.1/
sed -i 's|(prefix)/lib ;|(prefix)/lib64 ;|' Jamroot
git clone https://gist.github.com/2011636.git
patch -p1 < ./2011636/luabind_boost.patch
bjam install --prefix=/opt/osrm_infrastructure/luabind-0.9.1