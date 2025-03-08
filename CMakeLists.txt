# Copyright: (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
# Author: Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 3.5...3.10)
project(funny-things)

set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED 11)

find_package(ICUBcontrib REQUIRED)
find_package(YARP 3.5.1 REQUIRED COMPONENTS os sig dev math gsl idl_tools)
list(APPEND CMAKE_MODULE_PATH ${ICUBCONTRIB_MODULE_PATH})

include(ICUBcontribHelpers)
include(ICUBcontribOptions)
icubcontrib_set_default_prefix()

#R1 app related options
option(ENABLE_R1_APPS "Enable R1 related apps" OFF)
if(ENABLE_R1_APPS)
  option(CREATE_R1_GESTICULATE "Build gesticulate (R1)" OFF)
  if(DEFINED ENV{R1_OBR_BUILD_DIR})
    option(CREATE_R1_IDLEMANAGER "Build idleManager (R1)" OFF)
  endif()
endif()

add_subdirectory(modules)
add_subdirectory(app)

icubcontrib_add_uninstall_target()
