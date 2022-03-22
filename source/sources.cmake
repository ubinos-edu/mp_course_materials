#
# Copyright (c) 2022 Sung Ho Park and CSOS
#
# SPDX-License-Identifier: Apache-2.0
#

if(INCLUDE__MP_COURSE_EXAMPLES)

    get_filename_component(_tmpdir "${CMAKE_CURRENT_LIST_DIR}" ABSOLUTE)

    file(GLOB_RECURSE _tmpsrc
        "${_tmpdir}/*.c"
        "${_tmpdir}/*.cc"
        "${_tmpdir}/*.cpp"
        "${_tmpdir}/*.S")

    set(PROJECT_SOURCES ${PROJECT_SOURCES} ${_tmpsrc})

endif(INCLUDE__MP_COURSE_EXAMPLES)

