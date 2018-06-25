# Copyright: (C) 2013 iCub Facility - Istituto Italiano di Tecnologia
# Authors: Ugo Pattacini
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 3.5)
project(iCubWriter)

set(TinyXML_INCLUDE_DIRS "$ENV{YARP_ROOT}/extern/tinyxml/tinyxml" CACHE PATH "TinyXML include directory")
set(TinyXML_CODE ${TinyXML_INCLUDE_DIRS}/tinystr.cpp
                 ${TinyXML_INCLUDE_DIRS}/tinyxml.cpp
                 ${TinyXML_INCLUDE_DIRS}/tinyxmlerror.cpp
                 ${TinyXML_INCLUDE_DIRS}/tinyxmlparser.cpp)

source_group("Source Files" FILES main.cpp)

include_directories(${TinyXML_INCLUDE_DIRS})
add_executable(${PROJECT_NAME} main.cpp ${TinyXML_CODE})
target_link_libraries(${PROJECT_NAME} ${YARP_LIBRARIES} actionPrimitives)
install(TARGETS ${PROJECT_NAME} DESTINATION bin)

