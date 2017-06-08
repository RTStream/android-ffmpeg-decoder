#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd ffmpeg

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    CPU='cortex-a8'
  ;;
  x86)
    CPU='i686'
  ;;
esac

make clean

echo preparing...

./configure \
--target-os="$TARGET_OS" \
--enable-cross-compile \
--cross-prefix="$CROSS_PREFIX" \
--arch="$NDK_ABI" \
--cpu="$CPU" \
--enable-runtime-cpudetect \
--sysroot="$NDK_SYSROOT" \
--enable-pic \
--enable-pthreads \
--disable-debug \
--enable-jni \
--enable-mediacodec \
--enable-version3 \
--enable-hardcoded-tables \
--enable-gpl \
--enable-yasm \
--disable-doc \
--disable-shared \
--enable-static \
--enable-small \
--disable-ffplay \
--disable-ffmpeg \
--disable-ffprobe \
--disable-network \
--disable-avfilter \
--disable-avdevice \
--disable-ffserver \
--disable-everything \
--enable-decoder=h264 \
--enable-decoder=h264_mediacodec \
--enable-hwaccel=h264_mediacodec \
--enable-demuxer=h264 \
--enable-parser=h264 \
--enable-decoder=hevc \
--enable-decoder=hevc_mediacodec \
--enable-hwaccel=hevc_mediacodec \
--enable-demuxer=hevc \
--enable-parser=hevc \
--enable-decoder=aac \
--enable-demuxer=aac \
--enable-parser=aac \
--enable-muxer=mp4 \
--pkg-config="${2}/ffmpeg-pkg-config" \
--prefix="${2}/build/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-libs="-lm" \
--extra-cxxflags="$CXX_FLAGS" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1

popd
