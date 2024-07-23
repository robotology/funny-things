# Copyright: (C) 2014 iCub Facility - Istituto Italiano di Tecnologia
# Authors: Alessandro Roncone
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 3.5)

file(GLOB scripts  ${CMAKE_CURRENT_SOURCE_DIR}/scripts/*.template)
file(GLOB conf_ini ${CMAKE_CURRENT_SOURCE_DIR}/conf/*.ini ${CMAKE_CURRENT_SOURCE_DIR}/conf/*.lua)
file(GLOB conf_svg ${CMAKE_CURRENT_SOURCE_DIR}/conf/drawings/*.svg)
file(GLOB lua_bin  ${CMAKE_CURRENT_SOURCE_DIR}/scripts/lua/*.lua)

yarp_install(FILES ${conf_ini} DESTINATION ${ICUBCONTRIB_CONTEXTS_INSTALL_DIR}/${PROJECTNAME})
yarp_install(FILES ${conf_svg} DESTINATION ${ICUBCONTRIB_CONTEXTS_INSTALL_DIR}/${PROJECTNAME}/drawings)
yarp_install(FILES ${scripts}  DESTINATION ${ICUBCONTRIB_APPLICATIONS_TEMPLATES_INSTALL_DIR})

add_custom_target(copy_lua_in_build ALL)
foreach(_bin IN ITEMS ${lua_bin})
  get_filename_component(_bin_name ${_bin} NAME)
  add_custom_command(TARGET copy_lua_in_build POST_BUILD
                     COMMAND ${CMAKE_COMMAND} -E copy ${_bin} ${CMAKE_BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/${_bin_name}
                     COMMENT "Copying ${_bin} to ${CMAKE_BINARY_DIR}/bin/${CMAKE_CFG_INTDIR}/${_bin_name}")
endforeach()
install(PROGRAMS ${lua_bin} DESTINATION bin)

# CER app folders
if(ENABLE_R1_APPS)
  add_subdirectory(greeting)
  if(CREATE_R1_GESTICULATE)
    add_subdirectory(gesticulate)
  endif()
  if(CREATE_R1_IDLEMANAGER)
    add_subdirectory(idleManager)
  endif()
endif()