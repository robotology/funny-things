# Copyright: (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
# Author: Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 2.8)
project(iCubBreather)

file(GLOB source *.cpp)
file(GLOB header *.h)

source_group("Source Files" FILES ${source})
source_group("Header Files" FILES ${header})

add_executable(iCubBreather ${source} ${header})

target_link_libraries(iCubBreather ${YARP_LIBRARIES})

install(TARGETS iCubBreather DESTINATION bin)

