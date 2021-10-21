# Copyright (C) 2006-2021 Istituto Italiano di Tecnologia (IIT)
# All rights reserved.
#
# This software may be modified and distributed under the terms of the
# BSD-3-Clause license. See the accompanying LICENSE file for details.

add_custom_target(funnyThingsApp ALL)

# Build the app running the npm commands
add_custom_command(TARGET funnyThingsApp POST_BUILD
  COMMAND npm install --prefix ${CMAKE_CURRENT_SOURCE_DIR}
  COMMAND npm run build --prefix ${CMAKE_CURRENT_SOURCE_DIR}
  COMMAND mv ${CMAKE_CURRENT_SOURCE_DIR}/dist/funnyThingsApp.AppImage ${CMAKE_BINARY_DIR}/bin/
  DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/package.json"
  COMMENT "Building funnyThingsApp....."
  VERBATIM
)

install(PROGRAMS ${CMAKE_BINARY_DIR}/bin/funnyThingsApp.AppImage DESTINATION bin)
