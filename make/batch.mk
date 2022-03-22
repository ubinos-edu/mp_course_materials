#
# Copyright (c) 2020 Sung Ho Park and CSOS
#
# SPDX-License-Identifier: Apache-2.0
#

###############################################################################

%:
	@echo ""
	@echo ""


	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex0401_stm32vldisco_baremetal_qemu
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex0501_main_1_stm32vldisco_baremetal_qemu
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex0502_main_2_stm32vldisco_baremetal_qemu
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex0503_main_3_stm32vldisco_baremetal_qemu
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex0504_hello_world_1_stm32vldisco_baremetal_qemu
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex0505_hello_world_2_stm32vldisco_baremetal_qemu
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex0506_hello_world_3_stm32vldisco_baremetal_qemu
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex0507_allocating_space_1_stm32vldisco_baremetal_qemu
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex0508_allocating_space_2_stm32vldisco_baremetal_qemu

	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex9900_stm32vldisco_baremetal_qemu
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex9900_nrf52840dk_baremetal
	make -f makefile.mk $@ CONFIG_DIR=../app CONFIG_NAME=mp_course_ex9900_nucleof207zg_baremetal


	@echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	@echo ""

###############################################################################


