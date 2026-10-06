#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/xiaomi/gold/device.mk)

PRODUCT_NAME := omni_gold
PRODUCT_DEVICE := gold
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi Note 13 5G
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_RELEASE_NAME := gold

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi