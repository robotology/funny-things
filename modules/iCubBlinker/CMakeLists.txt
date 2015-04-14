# Copyright: (C) 2015 iCub Facility - Istituto Italiano di Tecnologia
# Author: Ugo Pattacini & Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 2.8)
set(PROJECTNAME iCubBlinker)
project(${PROJECTNAME})

include(YarpIDL)

set(header_files ${CMAKE_CURRENT_SOURCE_DIR}/${PROJECTNAME}_IDL.h)
set(source_files ${CMAKE_CURRENT_SOURCE_DIR}/${PROJECTNAME}_IDL.cpp
                 ${PROJECTNAME}.cpp)
set(idl_files    ${PROJECTNAME}.thrift)

yarp_idl_to_dir(${idl_files} ${CMAKE_CURRENT_SOURCE_DIR})

source_group("Header Files" FILES ${header_files})
source_group("Source Files" FILES ${source_files})
source_group("IDL Files"    FILES ${idl_files})

include_directories(${CMAKE_CURRENT_SOURCE_DIR}
                    ${YARP_INCLUDE_DIRS})

add_executable(${PROJECTNAME} ${header_files} ${source_files} ${idl_files})
target_link_libraries(${PROJECTNAME} ${YARP_LIBRARIES})
install(TARGETS ${PROJECTNAME} DESTINATION bin)
