#!/usr/bin/env bash

mkdir build
cd build

if [[ "$target_platform" == linux-* ]]; then
  export CXXFLAGS="$CXXFLAGS -lGL -lGLU"
fi

export WORKBENCH_USE_QT5=FALSE
export WORKBENCH_USE_QT6=TRUE

cmake $CMAKE_ARGS -GNinja \
  -DWORKBENCH_USE_QT5:BOOL=$WORKBENCH_USE_QT5 \
  -DWORKBENCH_USE_QT6:BOOL=$WORKBENCH_USE_QT6 \
  -DWORKBENCH_MESA_DIR:STRING=$PREFIX \
  -DCMAKE_BUILD_TYPE:STRING=Release \
  -DCMAKE_INSTALL_PREFIX:STRING=$PREFIX \
  -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
  ../src

cmake --build .

ctest --extra-verbose --output-on-failure .

cmake --install .
