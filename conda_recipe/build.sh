CC=${PREFIX}/bin/gcc
CXX=${PREFIX}/bin/g++

./autogen.sh
./configure --prefix=$PREFIX
make
make install
