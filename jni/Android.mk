LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := videodecoder
LOCAL_SRC_FILES := h264decoder.c

$(warning "the value of LOCAL_PATH is $(LOCAL_PATH)")
$(warning "the value of TARGET_ARCH_ABI is $(TARGET_ARCH_ABI)")

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
	LOCAL_C_INCLUDES := $(LOCAL_C_INCLUDES) $(LOCAL_PATH)/ffmpeg-android/armeabi-v7a/include
	LOCAL_LDFLAGS := -L$(LOCAL_PATH)/ffmpeg-android/armeabi-v7a/lib
endif

ifeq ($(TARGET_ARCH_ABI),armeabi)
	LOCAL_C_INCLUDES := $(LOCAL_C_INCLUDES) $(LOCAL_PATH)/ffmpeg-android/armv5te/include
	LOCAL_LDFLAGS := -L$(LOCAL_PATH)/ffmpeg-android/armv5te/lib
endif

ifeq ($(TARGET_ARCH_ABI),x86)
	LOCAL_C_INCLUDES := $(LOCAL_C_INCLUDES) $(LOCAL_PATH)/ffmpeg-android/i686/include
	LOCAL_LDFLAGS := -L$(LOCAL_PATH)/ffmpeg-android/i686/lib
endif

LOCAL_CFLAGS := -std=c99 -Wall -fvisibility=hidden
LOCAL_LDFLAGS := $(LOCAL_LDFLAGS) -Wl,--gc-sections 
LOCAL_LDLIBS := -llog -lavformat -lavcodec -lswscale -lavutil 

include $(BUILD_SHARED_LIBRARY)
