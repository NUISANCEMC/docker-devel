#!/bin/sh
# Script that downlaods the standard CentOS tarballs and unpacks them ready for use.
# Also checks that it can recompile NUISANCE by running make install

# Run this script anywhere you want NUISANCE to be built.

echo "Downloading pre-built NUISANCE-docker-devel tarball to current directory"
wget https://www.dropbox.com/s/jzrpjmi3blweetk/nuisance-v2r8-gcc4.8.5-centos7.tar.gz?dl=0
tar -zxvf nuisance-v2r8-gcc4.8.5-centos7.tar.gz\?dl\=0
cd nuisance-v2r8-gcc4.8.5-centos7
source setupnuisance.sh
rm -rf $NUISANCE/build/
mkdir $NUISANCE/build/
cd $NUISANCE/build/
cmake ../ -DUSE_GENIE=1 -DBUILD_GEVGEN=1 -DUSE_MINIMIZER=1 -DUSE_NuWro=1 -DUSE_NuWro_RW=1 -DCMAKE_BUILD_TYPE=RELEASE -DLIBXML2_LIB=/usr/lib64/ -DLIBXML2_INC=/usr/include/libxml2/
make install
