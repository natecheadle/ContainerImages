FROM ubuntu:latest
RUN apt-get update && apt-get upgrade -y 

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
build-essential tar zip unzip git wget \
ninja-build python c++filt xz-utils curl

RUN rm -rf /var/lib/apt/lists/* && \
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz && \
tar -xf clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz && \
mv clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04 llvm_13 && \
rm clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz

RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.3/cmake-3.21.3-linux-x86_64.tar.gz && \
tar -xf cmake-3.21.3-linux-x86_64.tar.gz && \
mv cmake-3.21.3-linux-x86_64 cmake_3_21 && \
rm cmake-3.21.3-linux-x86_64.tar.gz

ENV PATH="/llvm_13/bin:/cmake_3_21/bin:${PATH}"
ENV LD_LIBRARY_PATH="/llvm_13/lib:${PATH}"
