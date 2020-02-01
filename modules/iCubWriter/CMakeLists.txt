# Copyright: (C) 2013 iCub Facility - Istituto Italiano di Tecnologia
# Authors: Ugo Pattacini
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 3.5)
find_package(ICUB REQUIRED)
find_package(tinyxml REQUIRED)

project(iCubWriter)
add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} ${YARP_LIBRARIES} tinyxml actionPrimitives)
install(TARGETS ${PROJECT_NAME} DESTINATION bin)
