#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from B5_Pro device
$(call inherit-product, device/micromax/B5_Pro/device.mk)

PRODUCT_DEVICE := B5_Pro
PRODUCT_NAME := omni_B5_Pro
PRODUCT_BRAND := Micromax
PRODUCT_MODEL := Micromax B5 Pro
PRODUCT_MANUFACTURER := micromax

PRODUCT_GMS_CLIENTID_BASE := android-micromax

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="B5_Pro_BD-user 8.1.0 O11019 1531802765 release-keys"

BUILD_FINGERPRINT := Micromax/B5_Pro_BD/B5_Pro:8.1.0/O11019/1531802765:user/release-keys
