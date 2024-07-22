# Copyright: (C) 2014 RobotCub Consortium
# Author: Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

add_subdirectory(iCubBlinker)
add_subdirectory(iCubBreather)
add_subdirectory(funnyPostures)

option(CREATE_ICUBWRITER "Build iCubWriter" OFF)
option(CREATE_FUNNYTHINGSAPP "Build funnyThingsApp" OFF)
if(CREATE_ICUBWRITER)
add_subdirectory(iCubWriter)
endif()
if(CREATE_FUNNYTHINGSAPP)
add_subdirectory(funnyThingsApp)
endif()
if(ENABLE_CER_APPS)
  if(CREATE_GESTICULATE)
    add_subdirectory(gesticulate)
  endif()
  if(CREATE_IDLEMANAGER)
    add_subdirectory(idleManager)
  endif()
endif()