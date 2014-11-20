# Copyright: (C) 2014 RobotCub Consortium
# Author: Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

add_subdirectory(iCubBlinker)
add_subdirectory(iCubBreather)
add_subdirectory(funnyPostures)

option(CREATE_ICUBWRITER "include iCubWriter module" OFF)
if (CREATE_ICUBWRITER)
    add_subdirectory(iCubWriter)
endif()
