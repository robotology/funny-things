# Copyright: (C) 2015 iCub Facility - Istituto Italiano di Tecnologia
# Author: Ugo Pattacini & Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 3.5)
project(iCubBlinker)

include(YarpIDL)

set(idl_files ${PROJECT_NAME}.thrift)

yarp_add_idl(IDL_GEN_FILES ${PROJECT_NAME}.thrift)

source_group("IDL Files" FILES ${idl_files})

add_executable(${PROJECT_NAME} main.cpp ${IDL_GEN_FILES} ${idl_files})
target_link_libraries(${PROJECT_NAME} ${YARP_LIBRARIES})
install(TARGETS ${PROJECT_NAME} DESTINATION bin)
