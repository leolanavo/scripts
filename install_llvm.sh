#!/bin/bash

# This script should be executed as super user

cd /lib

# LLVM
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm
cd llvm/tools

# Clang
svn co http://llvm.org/svn/llvm-project/cfe/trunk clang
cd ../..

# Clang tools
cd llvm/tools/clang/tools
svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
cd ../../../..

# Compiler-RT
cd llvm/projects
svn co http://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt
cd ../

# Build LLVM and Clang
mkdir build
cd build
cmake -G "Unix Makefiles" ../
make
