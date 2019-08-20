#!/bin/bash

CURRENT="$PWD"
cd ..

echo "Cloning OpenNMT ..."
git clone 'https://github.com/OpenNMT/OpenNMT.git'
echo "Done cloning OpenNMT ..!!"

echo "Cloning Monoses ..."
git clone 'https://github.com/artetxem/monoses.git'
echo 'Done cloning Monoses ..!!'

cd 'monoses'
mkdir -p "third-party"
cd 'third-party'

echo 'Cloning dependencies for Monoses ...'

echo 'Cloning Fast Align ...'
git clone 'https://github.com/clab/fast_align.git'
echo 'Done cloning Fast Align ..!!'

echo 'Compiling Fast Align ...'
cd 'fast_align'
mkdir build
cd build
cmake ..
make
cd ..
echo 'Finished compiling fast align ..!!'

echo 'Cloning phrase2vec ...'
git clone 'https://github.com/artetxem/phrase2vec.git'
echo 'Done cloning phrase2vec ..!!'

echo 'Compiling phrase2vec ...'
cd phrase2vec
make
cd ..
echo 'Done compiling phrase2vec'

echo 'Cloning vecmap ...'
git clone 'https://github.com/artetxem/vecmap.git'
echo 'Done cloning vecmap ..!!'

echo 'Cloning Moses ...'
git clone 'https://github.com/moses-smt/mosesdecoder.git' moses
echo 'Done cloning Moses ..!!'

echo 'Compiling Moses ...'
cd 'moses'
make -f contrib/Makefiles/install-dependencies.gmake
sh ./compile.sh
echo 'Finished compiling moses ..!!'

cd "$CURRENT"

echo 'Finished downloading and compiling all dependencies'
