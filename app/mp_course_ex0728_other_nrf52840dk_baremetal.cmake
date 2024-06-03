#
# Copyright (c) 2022 Sung Ho Park and CSOS
#
# SPDX-License-Identifier: Apache-2.0
#

# ubinos_config_info {"name_base": "mp_course_ex0728_other", "build_type": "cmake_ubinos", "app": true}

include(${PROJECT_UBINOS_DIR}/config/ubinos_nrf52840dk_baremetal.cmake)

####

set(INCLUDE__APP TRUE)
set(APP__NAME "mp_course_ex0728_other")

get_filename_component(_tmp_source_dir "${CMAKE_CURRENT_LIST_DIR}/${APP__NAME}" ABSOLUTE)

file(GLOB_RECURSE _tmp_sources
    "${_tmp_source_dir}/*.c"
    "${_tmp_source_dir}/*.cpp"
    "${_tmp_source_dir}/*.cc"
    "${_tmp_source_dir}/*.S")

set(PROJECT_APP_SOURCES ${PROJECT_APP_SOURCES} ${_tmp_sources})

add_compile_options(-Wno-error=unused-variable -Wno-error=unused-function -Wno-error=unused-const-variable -Wno-error=unused-but-set-variable)

