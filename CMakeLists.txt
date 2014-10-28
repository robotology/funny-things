# Copyright: (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
# Author: Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 2.8)
project(deaMovements)

find_package(YARP REQUIRED)
find_package(ICUB REQUIRED)
find_package(ICUBcontrib REQUIRED)

list(APPEND CMAKE_MODULE_PATH ${YARP_MODULE_PATH})
list(APPEND CMAKE_MODULE_PATH ${ICUB_MODULE_PATH})
list(APPEND CMAKE_MODULE_PATH ${ICUBCONTRIB_MODULE_PATH})

include(ICUBcontribHelpers)
include(ICUBcontribOptions)
icubcontrib_set_default_prefix()

include(YarpInstallationHelpers)   # pick up yarp's cmake scripts

icubcontrib_add_uninstall_target()

add_subdirectory(modules)

## add apps
add_subdirectory(app)

## install script (it does not work)
# install(TARGETS ./app/scripts/dea-scriping.sh DESTINATION bin)