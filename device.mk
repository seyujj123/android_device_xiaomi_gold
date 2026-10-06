#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/gold

# ---------------------------------------------------------------
# A/B OTA postinstall
# ---------------------------------------------------------------
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# ---------------------------------------------------------------
# Boot control HAL（A/B 设备需要）
# ---------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    bootctrl.mt6833

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.mt6833 \
    libgptutils \
    libz \
    libcutils

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# ---------------------------------------------------------------
# 原厂 vendor_boot ramdisk 内容
# fstab.mt6833 + lib/modules 全部拷到 vendor_ramdisk
# ---------------------------------------------------------------
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/first_stage_ramdisk/fstab.mt6833:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.mt6833

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root/lib/modules,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules)