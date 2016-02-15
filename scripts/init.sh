#!/usr/bin/env bash

# Initialization for a python client.
set -e

# Set version tags. Please check the corresponding git repo
# for correct tags.
PROTOBUF_VERSION="v3.0.0-beta-1"
# 02/12/2016 Currently grpc has compile error using protobuf v3 beta 2.
GRPC_VERSION="release-0_12_0"
GRPC_JAVA_VERSION="v0.12.0"

# Set folder.
SCRIPT_CWD=$PWD
CWD="$(dirname ${SCRIPT_CWD})"
echo $CWD
mkdir $CWD/dep

# Download packages from Github.
# https://github.com/google/protobuf/releases
cd ${CWD}/dep
rm -rf protobuf
git clone https://github.com/google/protobuf
cd protobuf
git checkout tags/${PROTOBUF_VERSION}

# The C++ based grpc stack, including python and other languages.
# https://github.com/grpc/grpc
cd ${CWD}/dep
rm -rf grpc
git clone https://github.com/grpc/grpc
cd grpc
git checkout tags/${GRPC_VERSION}
git submodule update --init

# Java grpc library.
cd ${CWD}/dep
git clone https://github.com/grpc/grpc-java
cd grpc-java
git checkout tags/${GRPC_JAVA_VERSION}

# Make protobuf.
# Generate configuration files
cd ${CWD}/dep/protobuf
./autogen.sh
./configure
make
make check

cd java
mvn test
mvn package
# sudo make install
# To delete the system-level installation
# make uninstall

# Make grpc.
cd ${CWD}/dep/grpc
make
#sudo make install

# Install Python modules.
# Update pip.
pip install -U pip

# Protobuf Python module.
cd ${CWD}/dep/protobuf/python
python setup.py install

# Grpc python library.
# We don't install from the codes since it lacks setup.py.
# Some instructions: https://github.com/grpc/grpc/blob/master/INSTALL
# Not very clear.
cd ${CWD}
pip install grpcio

# Grpc java library.
cd ${CWD}/dep/grpc-java/compiler
# To build, https://github.com/grpc/grpc-java/blob/master/COMPILING.md
# The plugin binds the rpc stack with protobuf
# https://github.com/grpc/grpc-java/tree/master/compiler
# Change to the compiler directory:
# To compile the plugin:
../gradlew java_pluginExecutable
# To test the plugin with the compiler:
../gradlew test
