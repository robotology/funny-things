# Copyright: (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
# Author: Ugo Pattacini
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 2.8)
set(PROJECTNAME iCubBlinker)
project(${PROJECTNAME})

set(source iCubBlinker.cpp)
source_group("Source Files" FILES ${source})
include_directories(${YARP_INCLUDE_DIRS})
add_executable(${PROJECTNAME} ${source})
target_link_libraries(${PROJECTNAME} ${YARP_LIBRARIES})
install(TARGETS ${PROJECTNAME} DESTINATION bin)
