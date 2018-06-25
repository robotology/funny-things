# Copyright: (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
# Authors: Ugo Pattacini
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 3.5)
project(funnyPostures)

set(source main.cpp)
source_group("Source Files" FILES ${source})
add_executable(${PROJECT_NAME} ${source})
target_link_libraries(${PROJECT_NAME} ${YARP_LIBRARIES} ctrlLib)
install(TARGETS ${PROJECT_NAME} DESTINATION bin)
