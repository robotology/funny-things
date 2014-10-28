#!/bin/bash
##########################################################################################
# FLATWOKEN ICON THEME CONFIGURATION SCRIPT
# Copyright: (C) 2014 FlatWoken icons
# Author:  Alessandro Roncone
# email:   alecive87@gmail.com
# Permission is granted to copy, distribute, and/or modify this program
# under the terms of the GNU General Public License, version 2 or any
# later version published by the Free Software Foundation.
#  *
# A copy of the license can be found at
# http://www.robotcub.org/icub/license/gpl.txt
#  *
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details
##########################################################################################


##########################################################################################
# USEFUL FUNCTIONS:                                                                      #
##########################################################################################
usage() {
cat << EOF
******************************************************************************************
DEA SCRIPTING
Author:  Alessandro Roncone   <alessandro.roncone@iit.it> 

This script scripts through the commands available for the DeA Kids videos.

USAGE:
        $0 options

******************************************************************************************
OPTIONS:
    -p -> Panel icons (and any 22x22px icon that is not explicitly handled by the gtk theme)
    -f -> Folder colors (currently 7 different colors are available!)
    -r -> Restore configs
    -u -> update repository (WARNING: it will remove any customization)

******************************************************************************************
EXAMPLE USAGE:
./configure.sh -p \#646464 -> the panel_icons option requires a HEX color to use

******************************************************************************************
EOF
}

##########################################################################################
# FUNCTIONS:                                                                             #
##########################################################################################
blink_eyes() {
    echo "Buongiorno capo!" | yarp write ... /iSpeak
}

greet_like_god() {

}

smile() {

}

close_left_hand() {

}

close_right_hand() {

}

greet_with_thumb() {

}

take_apple() {

}

##########################################################################################
# "MAIN" FUNCTION:                                                                       #
##########################################################################################
echo "***********************************************************************************"
echo ""

TARGET_KEY=""
TARGET_SUBKEY=""

while getopts "hp:f:r:u" opt; do
    case $opt in
        h)
            usage
            exit 1
        ;;
        ##################################################################################
        u)
          TARGET_KEY="update"
          
          echo "Restoring the iconset to its original state..."
          restore_panel_icons
          restore_folder_colors
          
          echo "Updating the repository..."
          git pull origin master
        ;;
        ##################################################################################
        \?)
            echo "Invalid option: -$OPTARG" >&2
            echo ""
            usage
            exit 1
        ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            echo ""
            usage
            exit 1
        ;;
    esac
done

if [[ $# -eq 0 ]] ; then 
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi