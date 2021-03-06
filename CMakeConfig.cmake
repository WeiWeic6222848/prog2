#############################################################################
#  This file is part of the gobelijn software.
#  Gobelijn is free software: you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation, either version 3 of the License, or any later
#  version. Gobelijn is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
#  or FITNESS FOR A PARTICULAR PURPOSE.
#  See the GNU General Public License for details. You should have received
#  a copy of the GNU General Public License along with the software. If not,
#  see <http://www.gnu.org/licenses/>.
#
#  Copyright 2012-17, Jan Broeckhove, CoMP group, Universiteit Antwerpen.
#
#############################################################################
#
#	This file contains CMake configuration settings.
#
#############################################################################

#============================================================================
# Configuration for the CMake tool itself.
#============================================================================
set(CMAKE_ENABLE_COMPILE_COMMANDS      ON)
set(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS  TRUE)
set(CMAKE_COLOR_MAKEFILE               ON)
set(CMAKE_VERBOSE_MAKEFILE             OFF)
enable_testing()

#============================================================================
# Override system defaults.
#============================================================================
set(CMAKE_INSTALL_PREFIX  "${CMAKE_BINARY_DIR}/installed"
        CACHE PATH "Install prefix path.")
set(CMAKE_BUILD_TYPE          "Release"
        CACHE STRING "Build type: None Debug Release RelWithDebInfo MinSizeRel.")
set(CMAKE_PROGRAM_PATH  "$ENV{PATH}"
    CACHE PATH "Where to look with find_program." )

#============================================================================
# Using CCache if available.
#============================================================================
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM AND NOT FORCE_NO_CCHACHE)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()

#============================================================================
# Introduce Gobelijn specific variables.
#============================================================================
set(GOBELIJN_INCLUDE_DOC FALSE
        CACHE BOOL "Include building of documentation.")

#============================================================================
# Additional CMake modules.
#============================================================================
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/resources/cmake/")

#============================================================================
# Distinguish Linux from Aplle in UNIX family.
#============================================================================
if(UNIX AND NOT APPLE)
    set(LINUX TRUE)
endif()

#============================================================================
# Macro sets NAME to VALUE iff the NAME has not been defined yet:
#============================================================================
macro(set_if_null NAME VALUE)
    if( NOT DEFINED ${NAME} OR "${NAME}" STREQUAL "" )
        set( ${NAME}    "${VALUE}" )
    endif()
endmacro(set_if_null)

#############################################################################
