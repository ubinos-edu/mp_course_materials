#
# Copyright (c) 2020 Sung Ho Park and CSOS
# 
# SPDX-License-Identifier: Apache-2.0
#

LIBRARY_DIR ?= ../..

include $(LIBRARY_DIR)/ubinos/make/common.mk
-include $(LIBRARY_DIR)/ubinos/make/custom.mk

%: common-% ;

