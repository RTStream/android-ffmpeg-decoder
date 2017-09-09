#!/bin/bash
# pushd jni
# ./android_build.sh
# popd

. jni/settings.sh

${ANDROID_NDK}/ndk-build clean
${ANDROID_NDK}/ndk-build NDK_APPLICATION_MK=./Application.mk
