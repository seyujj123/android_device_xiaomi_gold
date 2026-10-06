#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/gold

# ---------------------------------------------------------------
# 允许缺失依赖（TWRP 编译常见）
# ---------------------------------------------------------------
ALLOW_MISSING_DEPENDENCIES := true

# ---------------------------------------------------------------
# A/B + recovery 在 vendor_boot
# 本机无 recovery、无 init_boot 分区，boot.img 只有 kernel
# recovery 资源全在 vendor_boot.img 的 ramdisk 里
# ---------------------------------------------------------------
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    vendor_boot \
    dtbo \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    system \
    system_ext \
    vendor \
    product \
    mi_ext

# 关键：recovery 在 vendor_boot，不在 boot
BOARD_USES_VENDOR_BOOT_AS_RECOVERY := true

# ---------------------------------------------------------------
# 架构
# ---------------------------------------------------------------
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# ---------------------------------------------------------------
# Bootloader / Platform
# ---------------------------------------------------------------
TARGET_BOOTLOADER_BOARD_NAME := gold
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := mt6833

# ---------------------------------------------------------------
# 屏幕密度
# ---------------------------------------------------------------
TARGET_SCREEN_DENSITY := 480

# ---------------------------------------------------------------
# Kernel / boot header
# 参数来自原厂 vendor_boot.img 解包结果
# ---------------------------------------------------------------
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_BASE := 0x40078000
BOARD_RAMDISK_OFFSET := 0x11088000
BOARD_KERNEL_TAGS_OFFSET := 0x07c08000

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

BOARD_KERNEL_IMAGE_NAME := Image

# 预编译 kernel + dtb
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
endif

TARGET_KERNEL_CONFIG := gold_defconfig
TARGET_KERNEL_SOURCE := kernel/xiaomi/gold

# ---------------------------------------------------------------
# 分区大小（全部来自真机实测）
# ---------------------------------------------------------------
BOARD_FLASH_BLOCK_SIZE := 262144

BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864          # 64MB
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864   # 64MB
BOARD_DTBOIMAGE_PARTITION_SIZE := 8388608           # 8MB
BOARD_VBMETAIMAGE_PARTITION_SIZE := 8388608         # 8MB

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# 动态分区（super 实测 9126805504）
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_ext \
    vendor \
    product \
    mi_ext
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200

# ---------------------------------------------------------------
# Recovery / fstab
# ---------------------------------------------------------------
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# vendor_boot 中保留原厂 ramdisk 内容
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true

# ---------------------------------------------------------------
# 安全补丁 / anti-rollback
# ---------------------------------------------------------------
PLATFORM_VERSION := 15
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31

# ---------------------------------------------------------------
# Verified Boot
# ---------------------------------------------------------------
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# ---------------------------------------------------------------
# TWRP 配置
# ---------------------------------------------------------------
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := zh_CN
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FUSE_EXFAT := true
TW_INCLUDE_FUSE_NTFS := true
TW_HAS_MTP := true
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
TW_DEVICE_VERSION := gold-by-you

TW_NO_SCREEN_BLANK := false
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 128