#############################################################################
#  This file is part of the software project.
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
#  Copyright 2017, Jan Broeckhove, CoMP group, Universiteit Antwerpen.
#
#############################################################################
#
#	Meta makefile calls cmake to do the heavy lifting.
#
#############################################################################

#============================================================================
#   Configuring Make invocations.
#============================================================================
ifeq ($(PARALLEL_MAKE),)
	PARALLEL_MAKE = -j4
endif

#============================================================================
# 	CMake command for Mac OSX or *nix
#============================================================================
ifeq ($(CMAKE),)
	CMAKE = cmake
endif
ifeq ($(CMAKE_GENERATOR),)
	CMAKE_GENERATOR = "Unix Makefiles"
endif

#============================================================================
#   MACRO definitions to pass on to cmake
#============================================================================
CMAKE_ARGS += -DCMAKE_GENERATOR="Unix Makefiles"
#
ifneq ($(CMAKE_BUILD_TYPE),)
	CMAKE_ARGS += -DCMAKE_BUILD_TYPE:STRING=$(CMAKE_BUILD_TYPE)
endif
ifneq ($(CMAKE_CXX_COMPILER),)
	CMAKE_ARGS += -DCMAKE_CXX_COMPILER=$(CMAKE_CXX_COMPILER)
endif
ifneq ($(CMAKE_CXX_FLAGS),)
	CMAKE_ARGS += -DCMAKE_CXX_FLAGS=$(CMAKE_CXX_FLAGS)
endif
ifneq ($(CMAKE_INSTALL_PREFIX),)
	CMAKE_ARGS += -DCMAKE_INSTALL_PREFIX:PATH=$(CMAKE_INSTALL_PREFIX)
endif
ifneq ($(GOBELIJN_BOOST_ROOT),)
	CMAKE_ARGS += -DGOBELIJN_BOOST_ROOT:PATH=$(GOBELIJN_BOOST_ROOT)
endif
ifneq ($(GOBELIJN_INCLUDE_DOC),)
	CMAKE_ARGS += -DGOBELIJN_INCLUDE_DOC:BOOL=$(GOBELIJN_INCLUDE_DOC)
endif
ifneq ($(GOBELIJN_VERBOSE_TESTING),)
	CMAKE_ARGS += -DGOBELIJN_VERBOSE_TESTING:BOOL=$(GOBELIJN_VERBOSE_TESTING)
endif
ifeq ($(BUILD_DIR),)
	BUILD_DIR = build
endif

#============================================================================
#   Targets
#============================================================================
.PHONY: configure all install install_main install_test  
.PHONY: clean distclean test installcheck format

help:
	@ cmake -E echo " "
	@ cmake -E echo " Read INSTALL.txt in this directory for a brief overview."
	@ cmake -E echo "    "
	@ cmake -E echo " Current macro values are (cmake will use an appropriate"
	@ cmake -E echo " default for any macro that has not been set):"
	@ cmake -E echo " "
	@ cmake -E echo "   PARALLEL_MAKE             : " $(PARALLEL_MAKE)
	@ cmake -E echo " "
	@ cmake -E echo "   BUILD_DIR                 : " $(BUILD_DIR)
	@ cmake -E echo " "
	@ cmake -E echo "   CMAKE_BUILD_TYPE          : " $(CMAKE_BUILD_TYPE)
	@ cmake -E echo "   CMAKE_CXX_COMPILER        : " $(CMAKE_CXX_COMPILER)
	@ cmake -E echo "   CMAKE_CXX_FLAGS           : " $(CMAKE_CXX_FLAGS)
	@ cmake -E echo "   CMAKE_INSTALL_PREFIX      : " $(CMAKE_INSTALL_PREFIX)
	@ cmake -E echo " "
	@ cmake -E echo "   GOBELIJN_BOOST_ROOT       : " $(GOBELIJN_BOOST_ROOT)
	@ cmake -E echo "   GOBELIJN_INCLUDE_DOC      : " $(GOBELIJN_INCLUDE_DOC)
	@ cmake -E echo "   GOBELIJN_VERBOSE_TESTING  : " $(GOBELIJN_VERBOSE_TESTING)
	@ cmake -E echo " "
				
configure:
	cmake -E make_directory $(BUILD_DIR)
	cmake -E chdir $(BUILD_DIR) cmake $(CMAKE_ARGS) ..

all: configure
	$(MAKE) $(PARALLEL_MAKE) -C $(BUILD_DIR) all

install: configure
	$(MAKE) $(PARALLEL_MAKE) -C $(BUILD_DIR) --no-print-directory install   
	
install_main:
	$(MAKE) $(PARALLEL_MAKE) -C $(BUILD_DIR)/main --no-print-directory install
	
install_test: install_main
	$(MAKE) $(PARALLEL_MAKE) -C $(BUILD_DIR)/test --no-print-directory install

distclean clean:
	cmake -E remove_directory $(BUILD_DIR)

test installcheck: install_test
	$(MAKE) $(PARALLEL_MAKE) -C $(BUILD_DIR) run_ctest
	
format:
	resources/bash/clang-format-all .
	
#############################################################################
