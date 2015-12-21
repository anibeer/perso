#!/bin/bash
#OSRM installation script
echo "Started"
echo ""

mkdir /opt/osrm_infrastructure

#Installing Boost package
cd /home/osrm
wget http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.bz2
tar -jxf boost_1_57_0.tar.bz2
cd boost_1_57_0/
./bootstrap.sh --prefix=/opt/osrm_infrastructure/boost_1_57_0
./b2 --prefix=/opt/osrm_infrastructure/boost_1_57_0

#Installing boost-jam package
cd /home/osrm
#copy des fichier
#wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/jblunck:/md/CentOS_CentOS-6/x86_64/boost-jam-1.46.1-10.1.x86_64.rpm
rpm -ivh boost-jam-1.50.0-17.14.x86_64.rpm

#Installing boost-build package
#copy des fichier
# ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/jblunck:/md/CentOS_CentOS-6/x86_64/boost-build-1.46.1-10.1.x86_64.rpm
rpm -ivh boost-build-1.50.0-17.14.x86_64.rpm

#Installing STXXL package
cd /home/osrm
git clone git://github.com/stxxl/stxxl.git
cd stxxl/

sed -i 's|option(USE_OPENMP "Use OpenMP for multi-core parallelism" ON)|option(USE_OPENMP "Use OpenMP for multi-core parallelism" OFF)|' CMakeLists.txt

mkdir debug && cd debug
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=/opt/osrm_infrastructure/stxx -DBUILD_STATIC_LIBS=ON ..
make -j$Threads && make install

cd ..
mkdir release && cd release
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/osrm_infrastructure/stxx -DBUILD_STATIC_LIBS=ON ..
make -j$Threads && make install

#Installing LUABIND package
cd /home/osrm
wget http://sourceforge.net/projects/luabind/files/luabind/0.9.1/luabind-0.9.1.tar.gz
tar -zxf luabind-0.9.1.tar.gz
cd luabind-0.9.1/
sed -i 's|(prefix)/lib ;|(prefix)/lib64 ;|' Jamroot
git clone https://gist.github.com/2011636.git
patch -p1 < ./2011636/luabind_boost.patch
#Resolve trouble with connectivity of LUABIND and BOOST
sed -i 540i\ '#if BOOST_VERSION < 105700' /home/osrm/luabind-0.9.1/luabind/object.hpp
sed -i 561i\ '#endif' /home/osrm/luabind-0.9.1/luabind/object.hpp
bjam install --prefix=/opt/osrm_infrastructure/luabind-0.9.1 -sBOOST_ROOT=/home/osrm/boost_1_57_0

#Installing LUAJIT package
cd /home/osrm
wget http://luajit.org/download/LuaJIT-2.0.2.tar.gz
tar -zxvf LuaJIT-2.0.2.tar.gz
cd LuaJIT-2.0.2/
make install PREFIX=/opt/osrm_infrastructure/LuaJIT-2.0.2

#Installing Tbb
cd /home/osrm
tar -zxf tbb43_20150611oss_src.tgz
cd tbb43_20150611oss
make

mkdir -p /usr/include/serial
cp -a include/serial/* /usr/include/serial/

mkdir -p /usr/include/tbb
cp -a include/tbb/* /usr/include/tbb/

cp build/linux_intel64_gcc_cc4.7.3_libc2.12_kernel2.6.32_release/libtbb.so.2 /usr/lib64/
ln -s /usr/lib64/libtbb.so.2 /usr/lib64/libtbb.so

#Installing OSM-binary package
cd /home/osrm
git clone https://github.com/scrosby/OSM-binary.git
cd OSM-binary
mkdir build
cd build
cmake ..
make
make install

#Installing OSRM package
cd /home/osrm
wget -O Project-OSRM-0.3.7.zip https://github.com/DennisOSRM/Project-OSRM/archive/v0.3.7.zip
unzip Project-OSRM-0.3.7.zip
cd osrm-backend-0.3.7
sed -i 's| -pedantic||' CMakeLists.txt
mkdir build
cd build
cmake -DLUABIND_INCLUDE_DIR=/opt/osrm_infrastructure/luabind-0.9.1/include -DLUABIND_LIBRARY=/opt/osrm_infrastructure/luabind-0.9.1/lib/libluabindd.so -DLUAJIT_LIBRARIES=/opt/osrm_infrastructure/LuaJIT-2.0.2/lib/libluajit-5.1.so -DLUAJIT_INCLUDE_DIR=/opt/osrm_infrastructure/LuaJIT-2.0.2/include/ -DSTXXL_LIBRARY=/opt/osrm_infrastructure/stxx/lib/libstxxl.a -DSTXXL_INCLUDE_DIR=/opt/osrm_infrastructure/stxx/include -DOSMPBF_LIBRARY=/home/osrm/OSM-binary/build/src/libosmpbf.a -DOSMPBF_INCLUDE_DIR=/home/osrm/OSM-binary/include -DBOOST_ROOT=/home/osrm/boost_1_57_0 -DBOOST_LIBRARYDIR=/home/osrm/boost_1_57_0/lib ..
make

echo ""
echo "Script finished"