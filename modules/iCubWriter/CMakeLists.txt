# Copyright: (C) 2013 iCub Facility - Istituto Italiano di Tecnologia
# Authors: Ugo Pattacini
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 2.8)
set(PROJECTNAME iCubWriter)
project(${PROJECTNAME})

set(TinyXML_INCLUDE_DIRS "$ENV{YARP_ROOT}/extern/tinyxml/tinyxml" CACHE PATH "TinyXML include directory")
set(TinyXML_CODE ${TinyXML_INCLUDE_DIRS}/tinystr.cpp
                 ${TinyXML_INCLUDE_DIRS}/tinyxml.cpp
                 ${TinyXML_INCLUDE_DIRS}/tinyxmlerror.cpp
                 ${TinyXML_INCLUDE_DIRS}/tinyxmlparser.cpp)

source_group("Source Files" FILES main.cpp)

include_directories(${YARP_INCLUDE_DIRS} ${ICUB_INCLUDE_DIRS} ${TinyXML_INCLUDE_DIRS})
add_executable(${PROJECTNAME} main.cpp ${TinyXML_CODE})
target_link_libraries(${PROJECTNAME} ${YARP_LIBRARIES} actionPrimitives icubmod)
install(TARGETS ${PROJECTNAME} DESTINATION bin)

