#!/bin/bash

###########################################
# Script for build FFmpeg on Linux x86_64 #
# Author: q3aql                           #
# Contact: q3aql@duck.com                 #
###########################################

# IMPORTANT
# YOU NEED INSTALL:
#  - wget
#  - git
#  - gcc/g++
#  - yasm/nasm
#  - make
#  - meson/ninja
#  - gperf
#  - autoconf
#  - libtool
#  - gcc-mingw-w64-i686 
#  - g++-mingw-w64-i686
#  - zip
#  - zstd

# Build variables
dir_build="/opt/ffmpeg-builds/build/mingw32"
dir_build_libs="/opt/ffmpeg-builds/lib/mingw32"
dir_build_packages="/opt/ffmpeg-builds/packages"

# FFmpeg version
ffmpeg_package="https://ffmpeg.org/releases/ffmpeg-4.4.1.tar.bz2"
ffmpeg_package_name="ffmpeg-4.4.1.tar.bz2@ffmpeg-4.4.1"

# Build parameters
ffmpeg_pre_parameters="PKG_CONFIG_PATH=\"${dir_build_libs}/lib/pkgconfig\""
ffmpeg_parameters="--prefix=\"${dir_build}/usr\" --extra-cflags=\"-I${dir_build_libs}/include\" \
--extra-ldflags=\"-L${dir_build_libs}/lib\" --extra-libs=\"-lpthread -lm -lz\" --extra-ldexeflags=\"-static\" \
--enable-gpl --enable-nonfree --enable-version3 --enable-static --disable-debug --disable-indev=sndio \
--disable-outdev=sndio --cc=gcc --enable-fontconfig --enable-frei0r --enable-openssl --enable-libgme \
--enable-libaom --enable-libfribidi --enable-libass --enable-libfreetype --enable-libmp3lame --disable-shared \
--enable-libopenjpeg --enable-libsoxr --enable-libspeex --enable-libvorbis --enable-libopus --enable-libtheora \
--enable-libvidstab --enable-libvo-amrwbenc --enable-libvpx --enable-libwebp --enable-libx264 --enable-libx265 \
--enable-libdav1d --enable-libxvid --enable-libfdk-aac"

# COMPILER VARIABLES
HOST=i686-w64-mingw32
CC=${HOST}-gcc 
CXX=${HOST}-g++
AR=${HOST}-ar 
RANLIB=${HOST}-ranlib

# URL Libraries Variables
lib_zlib="http://sourceforge.net/projects/libpng/files/zlib/1.2.11/zlib-1.2.11.tar.gz"
lib_zlib_name="zlib-1.2.11.tar.gz@zlib-1.2.11"

lib_expat="https://github.com/libexpat/libexpat/releases/download/R_2_4_1/expat-2.4.1.tar.bz2"
lib_expat_name="expat-2.4.1.tar.bz2@expat-2.4.1"

lib_png="http://prdownloads.sourceforge.net/libpng/libpng-1.6.37.tar.gz"
lib_png_name="libpng-1.6.37.tar.gz@libpng-1.6.37"

lib_fontconfig="https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.94.tar.gz"
lib_fontconfig_name="fontconfig-2.13.94.tar.gz@fontconfig-2.13.94"

lib_frei0r="https://files.dyne.org/frei0r/frei0r-plugins-1.7.0.tar.gz"
lib_frei0r_name="frei0r-plugins-1.7.0.tar.gz@frei0r-plugins-1.7.0"

lib_openssl="https://www.openssl.org/source/openssl-1.1.1m.tar.gz"
lib_openssl_name="openssl-1.1.1m.tar.gz@openssl-1.1.1m"

lib_harfbuzz="https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-1.4.6.tar.bz2"
lib_harfbuzz_name="harfbuzz-1.4.6.tar.bz2@harfbuzz-1.4.6"  

lib_fribidi="https://github.com/fribidi/fribidi/releases/download/v1.0.11/fribidi-1.0.11.tar.xz"
lib_fribidi_name="fribidi-1.0.11.tar.xz@fribidi-1.0.11"
lib_fribidi_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-fribidi-1.0.11-1-any.pkg.tar.zst"
lib_fribidi_msys_name="mingw-w64-i686-fribidi-1.0.11-1-any.pkg.tar.zst@mingw32"
#https://packages.msys2.org/package/mingw-w64-i686-fribidi

lib_ass="https://github.com/libass/libass/releases/download/0.15.2/libass-0.15.2.tar.gz"
lib_ass_name="libass-0.15.2.tar.gz@libass-0.15.2"

lib_freetype="https://download.savannah.gnu.org/releases/freetype/freetype-2.11.1.tar.gz"
lib_freetype_name="freetype-2.11.1.tar.gz@freetype-2.11.1"

lib_mp3lame="https://sourceforge.net/projects/lame/files/lame/3.100/lame-3.100.tar.gz"
lib_mp3lame_name="lame-3.100.tar.gz@lame-3.100"

lib_fdkaac="https://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-2.0.2.tar.gz"
lib_fdkaac_name="fdk-aac-2.0.2.tar.gz@fdk-aac-2.0.2"

lib_openjpeg="https://github.com/uclouvain/openjpeg/archive/refs/tags/v2.1.2.tar.gz"
lib_openjpeg_name="v2.1.2.tar.gz@openjpeg-2.1.2"
lib_openjpeg_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-openjpeg2-2.4.0-2-any.pkg.tar.zst"
lib_openjpeg_msys_name="mingw-w64-i686-openjpeg2-2.4.0-2-any.pkg.tar.zst@mingw32"
#https://packages.msys2.org/package/mingw-w64-i686-openjpeg2

lib_soxr="https://sourceforge.net/projects/soxr/files/soxr-0.1.3-Source.tar.xz"
lib_soxr_name="soxr-0.1.3-Source.tar.xz@soxr-0.1.3-Source"
lib_soxr_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-libsoxr-0.1.3-2-any.pkg.tar.zst"
lib_soxr_msys_name="mingw-w64-i686-libsoxr-0.1.3-2-any.pkg.tar.zst@mingw32"
#https://packages.msys2.org/package/mingw-w64-i686-libsoxr

lib_speex="http://downloads.us.xiph.org/releases/speex/speex-1.2.0.tar.gz"
lib_speex_name="speex-1.2.0.tar.gz@speex-1.2.0"

lib_ogg="https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.tar.gz"
lib_ogg_name="libogg-1.3.5.tar.gz@libogg-1.3.5"

lib_vorbis="https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.gz"
lib_vorbis_name="libvorbis-1.3.7.tar.gz@libvorbis-1.3.7"

lib_opus="https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz"
lib_opus_name="opus-1.3.1.tar.gz@opus-1.3.1"
lib_opus_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-opus-1.3.1-4-any.pkg.tar.zst"
lib_opus_msys_name="mingw-w64-i686-opus-1.3.1-4-any.pkg.tar.zst@mingw32"
#https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-opus
lib_opusenc_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-libopusenc-0.2.1-1-any.pkg.tar.xz"
lib_opusenc_msys_name="mingw-w64-i686-libopusenc-0.2.1-1-any.pkg.tar.xz@mingw32"
#https://packages.msys2.org/package/mingw-w64-i686-libopusenc
lib_opusfile_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-opusfile-0.12-2-any.pkg.tar.zst"
lib_opusfile_msys_name="mingw-w64-i686-opusfile-0.12-2-any.pkg.tar.zst@mingw32"
#https://packages.msys2.org/package/mingw-w64-i686-opusfile

lib_theora="http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2"
lib_theora_name="libtheora-1.1.1.tar.bz2@libtheora-1.1.1"

lib_vistab="https://github.com/georgmartius/vid.stab/archive/refs/tags/v1.1.0.tar.gz"
lib_vistab_name="v1.1.0.tar.gz@vid.stab-1.1.0"

lib_vpx="https://github.com/webmproject/libvpx/archive/refs/tags/v1.11.0.tar.gz"
lib_vpx_name="v1.11.0.tar.gz@libvpx-1.11.0"

lib_webp="https://github.com/webmproject/libwebp/archive/refs/tags/v1.2.1.tar.gz"
lib_webp_name="v1.2.1.tar.gz@libwebp-1.2.1"

lib_x264="https://code.videolan.org/videolan/x264"
lib_x264_name="x264"

lib_x265="http://download.openpkg.org/components/cache/x265/x265_3.4.tar.gz"
lib_x265_name="x265_3.4.tar.gz@x265_3.4"
lib_x265_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-x265-3.5-1-any.pkg.tar.zst"
lib_x265_msys_name="mingw-w64-i686-x265-3.5-1-any.pkg.tar.zst@mingw32"
#https://packages.msys2.org/package/mingw-w64-i686-x265

lib_dav1d="https://code.videolan.org/videolan/dav1d.git"
lib_dav1d_name="dav1d"
lib_dav1d_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-dav1d-0.9.2-1-any.pkg.tar.zst"
lib_dav1d_msys_name="mingw-w64-i686-dav1d-0.9.2-1-any.pkg.tar.zst@mingw32"
#https://packages.msys2.org/package/mingw-w64-i686-dav1d

lib_xvid="https://downloads.xvid.com/downloads/xvidcore-1.3.7.tar.gz"
lib_xvid_name="xvidcore-1.3.7.tar.gz@xvidcore"
lib_xvid_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-xvidcore-1.3.7-2-any.pkg.tar.zst"
lib_xvid_msys_name="mingw-w64-i686-xvidcore-1.3.7-2-any.pkg.tar.zst@mingw32"
#https://packages.msys2.org/package/mingw-w64-i686-xvidcore

lib_aom="https://aomedia.googlesource.com/aom"
lib_aom_name="aom"
lib_aom_msys="https://mirror.msys2.org/mingw/mingw32/mingw-w64-i686-aom-3.2.0-1-any.pkg.tar.zst"
lib_aom_msys_name="mingw-w64-i686-aom-3.2.0-1-any.pkg.tar.zst@mingw32"
#https://packages.msys2.org/package/mingw-w64-i686-aom

# Check root permission 
mkdir -p /etc/root &> /dev/null
administrador=$?
if [ ${administrador} -eq 0 ] ; then
  rm -rf /etc/root
else
  echo ""
  echo "* ${0}"
  echo ""
  echo "* Administrator permissions are required."
  echo ""
  exit
fi

# Create directories
mkdir -p ${dir_build}
mkdir -p ${dir_build_libs}
mkdir -p ${dir_build_packages}

# Build zlib
if [ -f ${dir_build_libs}/lib/pkgconfig/zlib.pc ] ; then
  echo "* Zlib was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  name_package=$(echo ${lib_zlib_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_zlib_name} | cut -d "@" -f 2)
  wget -c "${lib_zlib}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --static
  make
  make install
  sleep 10
fi

# Build expat
if [ -f ${dir_build_libs}/lib/pkgconfig/expat.pc ] ; then
  echo "* Expat was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_expat_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_expat_name} | cut -d "@" -f 2)
  wget -c "${lib_expat}"
  tar jxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --enable-shared --without-docbook
  make
  make install
  sleep 10
fi

# Build libpng16
if [ -f ${dir_build_libs}/lib/pkgconfig/libpng.pc ] ; then
  echo "* LibPNG was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  cd ${dir_build_libs}
  name_package=$(echo ${lib_png_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_png_name} | cut -d "@" -f 2)
  wget -c "${lib_png}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --enable-shared
  make
  make install
  sleep 10
fi

# Build frei0r
#if [ -d ${dir_build_libs}/lib/frei0r-1 ] ; then
#  echo "* Frei0r was compiled previously"
#  sleep 1
#else
#  cd ${dir_build_libs}
#  rm -rfv ${name_package}
#  rm -rfv ${name_folder}
#  name_package=$(echo ${lib_frei0r_name} | cut -d "@" -f 1)
#  name_folder=$(echo ${lib_frei0r_name} | cut -d "@" -f 2)
#  wget -c "${lib_frei0r}"
#  tar zxvf ${name_package}
#  cd "${name_folder}"
#  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static
#  make
#  make install
#  sleep 10
#fi

# Build OpenSSL
if [ -f ${dir_build_libs}/lib/pkgconfig/libssl.pc ] ; then
  echo "* OpenSSL was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_openssl_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_openssl_name} | cut -d "@" -f 2)
  wget -c "${lib_openssl}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  ./Configure mingw --cross-compile-prefix=${HOST}- --prefix=${dir_build_libs} shared
  make
  make install
  sleep 10
fi

# Build Harfbuzz
if [ -f ${dir_build_libs}/lib/pkgconfig/harfbuzz.pc ] ; then
  echo "* Harfbuzz was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_harfbuzz_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_harfbuzz_name} | cut -d "@" -f 2)
  wget -c "${lib_harfbuzz}"
  tar jxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  make
  make install
  sleep 10
fi

# Build fribidi
if [ -f ${dir_build_libs}/lib/pkgconfig/fribidi.pc ] ; then
  echo "* Fribidi was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  #name_package=$(echo ${lib_fribidi_name} | cut -d "@" -f 1)
  #name_folder=$(echo ${lib_fribidi_name} | cut -d "@" -f 2)
  name_package=$(echo ${lib_fribidi_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_fribidi_msys_name} | cut -d "@" -f 2)
  #wget -c "${lib_fribidi}"
  cd /tmp
  wget -c "${lib_fribidi_msys}"
  #tar Jxvf ${name_package}
  #cd "${name_folder}"
  #CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-docs --disable-shared
  #make
  #make install
  tar --use-compress-program=unzstd -xvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  sleep 10
fi

# Build freetype
if [ -f ${dir_build_libs}/lib/pkgconfig/freetype2.pc ] ; then
  echo "* Freetype2 was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_freetype_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_freetype_name} | cut -d "@" -f 2)
  wget -c "${lib_freetype}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  make
  make install
  sleep 10
fi

# Build fontconfig
if [ -f ${dir_build_libs}/lib/pkgconfig/fontconfig.pc ] ; then
  echo "* Fontconfig was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_fontconfig_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_fontconfig_name} | cut -d "@" -f 2)
  wget -c "${lib_fontconfig}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-docs --disable-shared
  make
  make install
  sleep 10
fi

# Build ass
if [ -f ${dir_build_libs}/lib/pkgconfig/libass.pc ] ; then
  echo "* Ass was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_ass_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_ass_name} | cut -d "@" -f 2)
  wget -c "${lib_ass}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  make
  make install
  sleep 10
fi

# Build mp3lame
if [ -f ${dir_build_libs}/lib/libmp3lame.a ] ; then
  echo "* MP3Lame was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_mp3lame_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_mp3lame_name} | cut -d "@" -f 2)
  wget -c "${lib_mp3lame}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  make
  make install
  sleep 10
fi

# Build fdk-aac
if [ -f ${dir_build_libs}/lib/pkgconfig/fdk-aac.pc  ] ; then
  echo "* FDK-AAC was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_fdkaac_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_fdkaac_name} | cut -d "@" -f 2)
  wget -c "${lib_fdkaac}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  make
  make install
  sleep 10
fi

# Build openjpeg
if [ -f ${dir_build_libs}/lib/pkgconfig/libopenjp2.pc ] ; then
  echo "* OpenJPEG was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  #name_package=$(echo ${lib_openjpeg_name} | cut -d "@" -f 1)
  #name_folder=$(echo ${lib_openjpeg_name} | cut -d "@" -f 2)
  name_package=$(echo ${lib_openjpeg_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_openjpeg_msys_name} | cut -d "@" -f 2)
  #wget -c "${lib_openjpeg}"
  cd /tmp
  wget -c "${lib_openjpeg_msys}"
  #tar zxvf ${name_package}
  #cd "${name_folder}"
  #CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ cmake -DCMAKE_INSTALL_PREFIX="${dir_build_libs}" -DBUILD_SHARED_LIBS:bool=off
  #make
  #make install
  tar --use-compress-program=unzstd -xvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  sleep 10
fi

# Build soxr
if [ -f ${dir_build_libs}/lib/pkgconfig/soxr.pc ] ; then
  echo "* Soxr was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  #name_package=$(echo ${lib_soxr_name} | cut -d "@" -f 1)
  #name_folder=$(echo ${lib_soxr_name} | cut -d "@" -f 2)
  name_package=$(echo ${lib_soxr_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_soxr_msys_name} | cut -d "@" -f 2)
  #wget -c "${lib_soxr}"
  cd /tmp
  wget -c "${lib_soxr_msys}"
  #tar Jxvf ${name_package}
  #cd "${name_folder}"
  #CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${dir_build_libs}" -DBUILD_SHARED_LIBS:bool=off -DWITH_OPENMP:bool=off -DBUILD_TESTS:bool=off
  #make
  #make install
  tar --use-compress-program=unzstd -xvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  sleep 10
fi

# Build speex
if [ -f ${dir_build_libs}/lib/pkgconfig/speex.pc ] ; then
  echo "* Speex was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  name_package=$(echo ${lib_speex_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_speex_name} | cut -d "@" -f 2)
  wget -c "${lib_speex}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  make
  make install
  sleep 10
fi

# Build ogg
if [ -f ${dir_build_libs}/lib/pkgconfig/ogg.pc ] ; then
  echo "* Ogg was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_ogg_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_ogg_name} | cut -d "@" -f 2)
  wget -c "${lib_ogg}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig LD_LIBRARY_PATH=${dir_build_libs}/lib ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  make
  make install
fi

# Build vorbis
if [ -f ${dir_build_libs}/lib/pkgconfig/vorbis.pc ] ; then
  echo "* Vorbis was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_vorbis_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_vorbis_name} | cut -d "@" -f 2)
  wget -c "${lib_vorbis}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  make
  make install
  sleep 10
fi

# Build opus
if [ -f ${dir_build_libs}/lib/pkgconfig/opus.pc ] ; then
  echo "* Opus was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  #name_package=$(echo ${lib_opus_name} | cut -d "@" -f 1)
  #name_folder=$(echo ${lib_opus_name} | cut -d "@" -f 2)
  name_package=$(echo ${lib_opus_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_opus_msys_name} | cut -d "@" -f 2)
  #wget -c "${lib_opus}"
  cd /tmp
  wget -c "${lib_opus_msys}"
  #tar zxvf ${name_package}
  #cd "${name_folder}"
  #CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  #make
  #make install
  tar --use-compress-program=unzstd -xvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  # Opusenc
  name_package=$(echo ${lib_opusenc_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_opusenc_msys_name} | cut -d "@" -f 2)
  cd /tmp
  wget -c "${lib_opusenc_msys}"
  tar Jxvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  # Opufile
   name_package=$(echo ${lib_opusfile_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_opusfile_msys_name} | cut -d "@" -f 2)
  cd /tmp
  wget -c "${lib_opusfile_msys}"
  tar --use-compress-program=unzstd -xvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  sleep 10
fi

# Build theora
if [ -f ${dir_build_libs}/lib/pkgconfig/theora.pc ] ; then
  echo "* Theora was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  name_package=$(echo ${lib_theora_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_theora_name} | cut -d "@" -f 2)
  wget -c "${lib_theora}"
  tar jxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared --with-pic --disable-asm --disable-oggtest --disable-vorbistest --disable-examples --enable-valgrind-testing
  make
  make install
  sleep 10
fi

# Build vid.stab
#if [ -f ${dir_build_libs}/lib/pkgconfig/vidstab.pc ] ; then
#  echo "* Vid.Stab was compiled previously"
#  sleep 1
#else
#  cd ${dir_build_libs}
#  rm -rfv ${name_package}
#  rm -rfv ${name_folder}
#  name_package=$(echo ${lib_vistab_name} | cut -d "@" -f 1)
#  name_folder=$(echo ${lib_vistab_name} | cut -d "@" -f 2)
#  wget -c "${lib_vistab}"
#  tar zxvf ${name_package}
#  cd "${name_folder}"
#  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${dir_build_libs}" 
#  make
#  make install
#fi

# Build vpx
if [ -f ${dir_build_libs}/lib/pkgconfig/vpx.pc ] ; then
  echo "* Vpx was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_vpx_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_vpx_name} | cut -d "@" -f 2)
  wget -c "${lib_vpx}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --target=x86-win32-gcc --enable-static --disable-examples --disable-unit-tests --enable-pic
  make
  make install
  sleep 10
fi

# Build webp
if [ -f ${dir_build_libs}/lib/pkgconfig/libwebp.pc ] ; then
  echo "* Webp was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_webp_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_webp_name} | cut -d "@" -f 2)
  wget -c "${lib_webp}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  ./autogen.sh
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-shared
  make
  make install
  sleep 10
fi

# Build x264
if [ -f ${dir_build_libs}/lib/pkgconfig/x264.pc ] ; then
  echo "* x264 was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_folder=$(echo ${lib_x264_name})
  name_package=$(echo ${lib_x264_name})
  git clone ${lib_x264}
  cd "${name_folder}"
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs} --host=${HOST} --enable-static --disable-opencl --enable-pic 
  make
  make install
  sleep 10
fi

# Build x265
if [ -f ${dir_build_libs}/lib/pkgconfig/x265.pc ] ; then
  echo "* x265 was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  #name_package=$(echo ${lib_x265_name} | cut -d "@" -f 1)
  #name_folder=$(echo ${lib_x265_name} | cut -d "@" -f 2)
  name_package=$(echo ${lib_x265_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_x265_msys_name} | cut -d "@" -f 2)
  #wget -c "${lib_x265}"
  cd /tmp
  wget -c "${lib_x265_msys}"
  #tar zxvf ${name_package}
  #cd "${name_folder}"
  #cd build/linux
  #CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${dir_build_libs}" -DENABLE_SHARED:BOOL=OFF -DSTATIC_LINK_CRT:BOOL=ON -DENABLE_CLI:BOOL=OFF ../../source
  #sed -i 's/-lgcc_s/-lgcc_eh/g' x265.pc 
  #make
  #make install
  tar --use-compress-program=unzstd -xvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  sleep 10
fi

# Build dav1d
if [ -f ${dir_build_libs}/lib/pkgconfig/dav1d.pc ] ; then
  echo "* Dav1d was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  #name_folder=$(echo ${lib_dav1d_name})
  #name_package=$(echo ${lib_dav1d_name})
  name_package=$(echo ${lib_dav1d_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_dav1d_msys_name} | cut -d "@" -f 2)
  #git clone ${lib_dav1d}
  #cd "${name_folder}"
  #mkdir build
  #cd build
  #CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ meson .. --default-library=static
  #meson configure -Dprefix="${dir_build_libs}"
  #ninja
  #ninja install
  #ln -s ${dir_build_libs}/lib/x86_64-linux-gnu/pkgconfig/dav1d.pc ${dir_build_libs}/lib/pkgconfig/dav1d.pc
  cd /tmp
  wget ${lib_dav1d_msys}
  tar --use-compress-program=unzstd -xvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  sleep 10
fi

# Build xvid
if [ -f ${dir_build_libs}/lib/xvidcore.a ] ; then
  echo "* Xvid was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  #name_package=$(echo ${lib_xvid_name} | cut -d "@" -f 1)
  #name_folder=$(echo ${lib_xvid_name} | cut -d "@" -f 2)
  name_package=$(echo ${lib_xvid_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_xvid_msys_name} | cut -d "@" -f 2)
  #wget -c "${lib_xvid}"
  cd /tmp
  wget -c "${lib_xvid_msys}"
  #tar zxvf ${name_package}
  #cd "${name_folder}"/build/generic
  #CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib/ ./configure --prefix=${dir_build_libs}  --host=i386-mingw32 --build=i386-pc-linux-gnu --disable-shared
  #make
  #make install
  tar --use-compress-program=unzstd -xvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  sleep 10
fi

# Build aom
if [ -f ${dir_build_libs}/lib/pkgconfig/aom.pc ] ; then
  echo "* Aom was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  #name_folder=$(echo ${lib_aom_name})
  #name_package=$(echo ${lib_aom_name})
  name_package=$(echo ${lib_aom_msys_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_aom_msys_name} | cut -d "@" -f 2)
  #git clone ${lib_aom}
  #cd "${name_folder}"
  #rm -rf CMakeCache.txt CMakeFiles
  #mkdir -p build
  #cd build
  #CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib cmake -DCMAKE_INSTALL_PREFIX="${dir_build_libs}" ..
  #make
  #make install
  cd /tmp
  wget ${lib_aom_msys}
  tar --use-compress-program=unzstd -xvf ${name_package}
  cd ${name_folder}
  cp -rfv * ${dir_build_libs}/
  cd ..
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  sleep 10
fi

# Download FFmpeg
echo "* Building FFmpeg using system libraries"
cd ${dir_build_libs}
name_package=$(echo ${ffmpeg_package_name} | cut -d "@" -f 1)
name_folder=$(echo ${ffmpeg_package_name} | cut -d "@" -f 2)
wget -c ${ffmpeg_package}
tar jxvf ${name_package}
cd ${name_folder}
chmod +x configure
CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib ./configure --prefix="${dir_build}/" --cross-prefix=i686-w64-mingw32- --arch=i686 --target-os=mingw32 --disable-w32threads --extra-ldexeflags="-static" --pkg-config-flags="--static" --extra-cflags="-I${dir_build_libs}/include" --extra-ldflags="-L${dir_build_libs}/lib" --extra-libs="-lpthread -lm -lz" --extra-ldexeflags="-static" --enable-gpl --enable-nonfree --enable-version3 --disable-debug --disable-indev=sndio --disable-outdev=sndio --enable-fontconfig --enable-openssl --enable-libaom --enable-libfribidi --enable-libass --enable-libfreetype --enable-libmp3lame --enable-libopenjpeg --enable-libsoxr --enable-libspeex --enable-libvorbis --enable-libopus --enable-libtheora --disable-libvidstab --enable-libvpx --enable-libwebp --enable-libx264 --enable-libx265 --enable-libdav1d --enable-libxvid --enable-libfdk-aac --enable-ffplay --enable-pic
build_error=$?
if [ ${build_error} -eq 0 ] ; then
  echo ""
  echo "* Build configuration ready"
  #sleep 5
else
  echo ""
  echo "* Build configuration failed"
  echo "* Trying with build config without errors."
  echo "* Disabling the following libraries:"
  echo "   - fribidi"
  echo "   - openjpeg2"
  echo "   - soxr"
  echo "   - opus"
  echo "   - xvid"
  echo "   - x265"
  echo ""
  #sleep 5
  CC=${HOST}-gcc CXX=${HOST}-g++ AR=${HOST}-ar RANLIB=${HOST}-ranlib PKG_CONFIG_PATH=${dir_build_libs}/lib/pkgconfig  LD_LIBRARY_PATH=${dir_build_libs}/lib ./configure --prefix="${dir_build}/" --cross-prefix=i686-w64-mingw32- --arch=i686 --target-os=mingw32 --disable-w32threads --extra-ldexeflags="-static" --pkg-config-flags="--static" --extra-cflags="-I${dir_build_libs}/include" --extra-ldflags="-L${dir_build_libs}/lib" --extra-libs="-lpthread -lm -lz" --extra-ldexeflags="-static" --enable-gpl --enable-nonfree --enable-version3 --disable-debug --disable-indev=sndio --disable-outdev=sndio --enable-fontconfig --enable-openssl --enable-libaom --disable-libfribidi --enable-libass --enable-libfreetype --enable-libmp3lame --disable-libopenjpeg --disable-libsoxr --enable-libspeex --enable-libvorbis --disable-libopus --enable-libtheora --disable-libvidstab --enable-libvpx --enable-libwebp --enable-libx264 --disable-libx265 --enable-libdav1d --disable-libxvid --enable-libfdk-aac --enable-ffplay --enable-pic
fi
sleep 5
make
rm -rf ${dir_build}/*
make install

# Remove packages
echo "* Remove temporal files"
cd ..
rm -rfv ${name_package}
rm -rfv ${name_folder}

# Create package
echo "* Creating package"
cd ${dir_build}
zip ${name_folder}-win-32bit-build.zip -r *
rm -rf ${dir_build_packages}/${name_folder}-win-32bit-build.zip
mv ${name_folder}-win-32bit-build.zip ${dir_build_packages}
echo ""
echo "* Your build: ${dir_build_packages}/${name_folder}-win-32bit-build.zip"
echo ""
chmod 775 -R ${dir_build_packages}


