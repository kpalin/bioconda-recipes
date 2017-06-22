#!/bin/bash

#  Mon Apr 10 10:23:25 2017
#  kpalin@merit.ltdk.helsinki.fi

# For debugging
#set -o verbose 

# Die on unset variables
set -o nounset
# Die on errors
set -o errexit
# Die if any part of a pipe fails
set -o pipefail


BASE=${PWD}
PREFIX=${PREFIX:-$PWD}
CONDA_PREFIX=${CONDA_PREFIX:-$PREFIX}

export CPLUS_INCLUDE_PATH=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib
export MACOSX_RPATH="ON"

cd ${BASE}/bamtools
mkdir -p build
cd build
cmake ..
make

cd ${BASE}

export CPATH=${BASE}/bamtools/include/:${BASE}/bamtools/src/:${CONDA_PREFIX:-}/include/
export LIBRARY_PATH=${BASE}/bamtools/lib:${CONDA_PREFIX}/lib/

make all

cp ${BASE}/bamtools/lib/libbamtools.so* ${PREFIX}/lib
cp ${BASE}/bin/HLA-PRG-LA ${PREFIX}/bin/
cp ${BASE}/HLA-PRG-LA.pl ${PREFIX}/bin/
cp ${BASE}/make_reference_hlaprgla.py ${PREFIX}/bin/


# Download
#mkdir -p ${PREFIX}/share/graphs
#cd ${PREFIX}/share/graphs
#if [ ! -e ${PREFIX}/share/graphs/PRG_MHC_GRCh38_withIMGT.downloaded ] 
#then
#    wget -O - http://www.well.ox.ac.uk/PRG_MHC_GRCh38_withIMGT.tar.gz|tar -zxv
#    touch PRG_MHC_GRCh38_withIMGT.downloaded
#fi

