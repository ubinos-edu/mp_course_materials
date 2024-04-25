#
# Copyright (c) 2021 Sung Ho Park and CSOS
#
# SPDX-License-Identifier: Apache-2.0
#

# ubinos_config_info {"name_base": "mp_course_ex0716_exclusive_access_2", "build_type": "cmake_ubinos", "app": true}

set_cache(UBINOS__BSP__USE_QEMU TRUE  BOOL)

include(${PROJECT_UBINOS_DIR}/config/ubinos_netduinoplus2.cmake)

####

set(INCLUDE__APP TRUE)
set(APP__NAME "mp_course_ex0716_exclusive_access_2")

get_filename_component(_tmp_source_dir "${CMAKE_CURRENT_LIST_DIR}/${APP__NAME}" ABSOLUTE)

file(GLOB_RECURSE _tmp_sources
    "${_tmp_source_dir}/*.c"
    "${_tmp_source_dir}/*.cpp"
    "${_tmp_source_dir}/*.cc"
    "${_tmp_source_dir}/*.S"
    "${_tmp_source_dir}/*.s")

set(PROJECT_APP_SOURCES ${PROJECT_APP_SOURCES} ${_tmp_sources})

