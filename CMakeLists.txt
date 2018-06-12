# Copyright: (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
# Author: Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 3.5)
set(PROJECTNAME funny-things)
project(${PROJECTNAME})

set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED 11)

find_package(YARP REQUIRED COMPONENTS OS sig dev math gsl)
find_package(ICUB REQUIRED)
find_package(ICUBcontrib REQUIRED)

list(APPEND CMAKE_MODULE_PATH ${YARP_MODULE_PATH})
list(APPEND CMAKE_MODULE_PATH ${ICUB_MODULE_PATH})
list(APPEND CMAKE_MODULE_PATH ${ICUBCONTRIB_MODULE_PATH})

include(YarpInstallationHelpers)
include(ICUBcontribHelpers)
include(ICUBcontribOptions)
icubcontrib_set_default_prefix()

add_subdirectory(modules)
add_subdirectory(app)

icubcontrib_add_uninstall_target()
