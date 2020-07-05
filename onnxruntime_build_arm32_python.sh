#!/bin/bash

SECONDS=0

echo UPDATE Start

sudo apt update

echo UPDATE End

echo UPGRADE Start

sudo apt -y upgrade

echo UPGRADE End

echo AUTOREMOVE Start

sudo apt -y autoremove

echo AUTOREMOVE End

sudo apt install -y \
    sudo \
    build-essential \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    wget \
    python3 \
    python3-pip \
    python3-dev \
    git \
    tar \
    libatlas-base-dev \
    protobuf-compiler \
    cmake

pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install --upgrade wheel
pip3 install numpy

mkdir code
cd code

git clone --recursive https://github.com/Microsoft/onnxruntime

cd onnxruntime

echo 'set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} -latomic")' >> ./cmake/CMakeLists.txt

echo ---------------------
echo ---- Build Start ----
echo ---------------------

./build.sh --config MinSizeRel --arm --enable_pybind --build_wheel

ls -l build/Linux/MinSizeRel/*.so
ls -l build/Linux/MinSizeRel/dist/*.whl

echo ---------------------
echo ---- Build End ------
echo ---------------------

time=$SECONDS

echo $time" sec"
echo finish
