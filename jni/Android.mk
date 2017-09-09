LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := videodecoder
LOCAL_SRC_FILES := h264decoder.c

TARGET_PLATFORM := android-21
TARGET_ARCH_ABI := armeabi-v7a

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
	LOCAL_C_INCLUDES := $(LOCAL_C_INCLUDES) $(LOCAL_PATH)/ffmpeg-android/armeabi-v7a/include
	LOCAL_LDFLAGS := -L$(LOCAL_PATH)/ffmpeg-android/armeabi-v7a/lib
	LOCAL_LIB_PATH := $(LOCAL_PATH)/ffmpeg-android/armeabi-v7a/lib
endif

ifeq ($(TARGET_ARCH_ABI),armeabi)
	LOCAL_C_INCLUDES := $(LOCAL_C_INCLUDES) $(LOCAL_PATH)/ffmpeg-android/armv5te/include
	LOCAL_LDFLAGS := -L$(LOCAL_PATH)/ffmpeg-android/armv5te/lib
	LOCAL_LIB_PATH := $(LOCAL_PATH)/ffmpeg-android/armv5te/lib
endif

ifeq ($(TARGET_ARCH_ABI),x86)
	LOCAL_C_INCLUDES := $(LOCAL_C_INCLUDES) $(LOCAL_PATH)/ffmpeg-android/i686/include
	LOCAL_LDFLAGS := -L$(LOCAL_PATH)/ffmpeg-android/i686/lib
	LOCAL_LIB_PATH := $(LOCAL_PATH)/ffmpeg-android/i686/lib
endif

LOCAL_CFLAGS := -std=c99 -Wall -fvisibility=hidden -DDEBUG
LOCAL_LDFLAGS := $(LOCAL_LDFLAGS) -Wl,--gc-sections
LOCAL_LDLIBS := -llog -lavformat -lavcodec -lswscale -lavutil -lz -lm
include $(BUILD_SHARED_LIBRARY)
