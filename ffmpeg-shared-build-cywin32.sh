#!/bin/bash

###########################################
# Script for build FFmpeg on Cygwin x86   #
# Author: q3aql                           #
# Contact: q3aql@duck.com                 #
###########################################

# IMPORTANT
# YOU NEED INSTALL:
#  - wget
#  - git

# Build variables
dir_build="/opt/ffmpeg-builds/build/cygwin32-shared"
dir_build_libs="/opt/ffmpeg-builds/lib/cygwin32-shared"
dir_build_packages="/opt/ffmpeg-builds/packages"

# FFmpeg version
ffmpeg_package="https://ffmpeg.org/releases/ffmpeg-4.4.1.tar.bz2"
ffmpeg_package_name="ffmpeg-4.4.1.tar.bz2@ffmpeg-4.4.1"

# COMPILER VARIABLES
C_COMPILER="gcc"
CXX_COMPILER="g++"

# URL Libraries Variables
lib_x264="https://code.videolan.org/videolan/x264"
lib_x264_name="x264"

lib_x265="http://download.openpkg.org/components/cache/x265/x265_3.4.tar.gz"
lib_x265_name="x265_3.4.tar.gz@x265_3.4"

lib_xvid="https://downloads.xvid.com/downloads/xvidcore-1.3.7.tar.gz"
lib_xvid_name="xvidcore-1.3.7.tar.gz@xvidcore"

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

# Install apt-cyg
if [ -f "/usr/bin/apt-cyg" ] ; then
  echo "* apt-cyg manager is ready"
  sleep 1
else
  cd /tmp
  git clone "https://github.com/q3aql/ffmpeg-builds"
  cd ffmpeg-builds
  cp -rfv apt-cyg /usr/bin
  echo "* apt-cyg installed"
fi

# Fix strafe.sh
if [ -f /usr/include/w32api/strsafe.h_fix ] ; then
  echo "* strsafe.h was fixed previously"
else
  cd /tmp
  git clone "https://github.com/q3aql/ffmpeg-builds"
  cd ffmpeg-builds
  cp -rfv /usr/include/w32api/strsafe.h /usr/include/w32api/strsafe.h.bck
  cp -rfv cygwin_fix_strsafe.h /usr/include/w32api/strsafe.h
  cp -rfv cygwin_fix_strsafe.h /usr/include/w32api/strsafe.h_fix
  echo "* strsafe.sh fixed"
fi

# Install dependencies
apt-cyg update
apt-cyg install wget
apt-cyg install nasm
apt-cyg install yasm
apt-cyg install zip
apt-cyg install fontconfig
apt-cyg install libass-devel
apt-cyg install libfreetype-devel
apt-cyg install libfontconfig-devel
apt-cyg install libbs2b-devel
apt-cyg install meson
apt-cyg install make
apt-cyg install gcc
apt-cyg install gcc-core
apt-cyg install gcc-g++
apt-cyg install libfribidi-devel
apt-cyg install libgme-devel
apt-cyg install libcaca++-devel
apt-cyg install libcaca-devel
apt-cyg install libtwolame-devel
apt-cyg install libmp3lame-devel
apt-cyg install libwebp-devel
apt-cyg install libsoxr-devel
apt-cyg install libvpx-devel
apt-cyg install libtheora-devel
apt-cyg install libxml2-devel
apt-cyg install libopenjpeg-devel
apt-cyg install libgnutls-devel
apt-cyg install libopus-devel
apt-cyg install openssl-devel
apt-cyg install libopusfile-devel
apt-cyg install libopenjp2-devel
apt-cyg install libtheora-devel
apt-cyg install speex-devel
apt-cyg install speexdsp-devel
apt-cyg install cmake
apt-cyg install libgc-devel
apt-cyg install autoconf
apt-cyg install libtool
apt-cyg install ninja

# Build x264
if [ -f /usr/lib/pkgconfig/x264.pc ] ; then
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
  ./configure --prefix=/usr --enable-static --disable-opencl --disable-cli 
  make
  make install
fi

# Build x265
if [ -f /usr/lib/pkgconfig/x265.pc ] ; then
  echo "* x265 was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_x265_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_x265_name} | cut -d "@" -f 2)
  wget -c "${lib_x265}"
  tar zxvf ${name_package}
  cd "${name_folder}"
  cd build/linux
  cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr -DSTATIC_LINK_CRT:BOOL=ON -DENABLE_CLI:BOOL=OFF ../../source
  sed -i 's/-lgcc_s/-lgcc_eh/g' x265.pc 
  make
  make install
fi

# Build xvid
if [ -f /usr/lib/xvidcore.a ] ; then
  echo "* Xvid was compiled previously"
  sleep 1
else
  cd ${dir_build_libs}
  rm -rfv ${name_package}
  rm -rfv ${name_folder}
  name_package=$(echo ${lib_xvid_name} | cut -d "@" -f 1)
  name_folder=$(echo ${lib_xvid_name} | cut -d "@" -f 2)
  wget -c "${lib_xvid}"
  tar zxvf ${name_package}
  cd "${name_folder}"/build/generic
  ./configure --prefix=/usr
  make
  make install
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
./configure --prefix=${dir_build} --enable-gpl --enable-nonfree --disable-ffplay --disable-w32threads --enable-openssl --enable-libass --enable-libbs2b --enable-libcaca --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libmp3lame --enable-libopenjpeg --enable-libopus --enable-libsoxr --enable-libtheora --enable-libtwolame --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libxml2 --enable-libxvid --enable-libspeex --enable-libx264 --enable-libx265 --enable-static --enable-version3 --enable-doc --disable-indev=dshow
sleep 20
make
rm -rf ${dir_build}/*
make install

# Remove packages
echo "* Remove temporal files"
cd ..
rm -rfv ${name_package}
rm -rf ${name_folder}

# Copy libraries
mkdir -p ${dir_build}/bin
cp -rfv /usr/bin/xvidcore.dll ${dir_build}/bin/ # (0xf00000)
cp -rfv /usr/bin/cygcaca-*.dll ${dir_build}/bin/ # (0x68a40000)
cp -rfv /usr/bin/cygSDL*.dll ${dir_build}/bin/ # (0x6aca0000)
cp -rfv /usr/bin/cygiconv-*.dll ${dir_build}/bin/ # (0x693b0000)
cp -rfv /usr/bin/cygopenjp2-*.dll ${dir_build}/bin/ # (0x70a40000)
cp -rfv /usr/bin/cygmp3lame-*.dll ${dir_build}/bin/ # (0x6b540000)
cp -rfv /usr/bin/cygopus-*.dll ${dir_build}/bin/ # (0x67100000)
cp -rfv /usr/bin/cygspeex-*.dll ${dir_build}/bin/ # (0x66840000)
cp -rfv /usr/bin/cygtheoradec-*.dll ${dir_build}/bin/ # (0x64880000)
cp -rfv /usr/bin/cygtwolame-*.dll ${dir_build}/bin/ # (0x65a80000)
cp -rfv /usr/bin/cygtheoraenc-*.dll ${dir_build}/bin/ # (0x69100000)
cp -rfv /usr/bin/cygvorbis-*.dll ${dir_build}/bin/ # (0x67360000)
cp -rfv /usr/bin/cygvorbisenc-*.dll ${dir_build}/bin/ # (0x672d0000)
cp -rfv /usr/bin/cygvpx-*.dll ${dir_build}/bin/ # (0x702c0000)
cp -rfv /usr/bin/cygwebpmux-*.dll ${dir_build}/bin/ # (0x66c80eso000)
cp -rfv /usr/bin/cygx265-*.dll ${dir_build}/bin/ # (0x68080000)
cp -rfv /usr/bin/cygass-*.dll ${dir_build}/bin/ # (0x686c0000)
cp -rfv /usr/bin/cygbs2b-*.dll ${dir_build}/bin/ # (0x6f3c0000)
cp -rfv /usr/bin/cygfontconfig-*.dll ${dir_build}/bin/ # (0x694c0000)
cp -rfv /usr/bin/cygfreetype-*.dll ${dir_build}/bin/ # (0x675c0000)
cp -rfv /usr/bin/cygfribidi-*.dll ${dir_build}/bin/ # (0x6cf00000)
cp -rfv /usr/bin/cygwebp-*.dll ${dir_build}/bin/ # (0x67240000)
cp -rfv /usr/bin/cygssl-*.dll ${dir_build}/bin/ # (0x67870000)
cp -rfv /usr/bin/cygcrypto-*.1.dll ${dir_build}/bin/ # (0x6a500000)
cp -rfv /usr/bin/xvidcore.dll ${dir_build}/bin/ # (0xf00000)
cp -rfv /usr/bin/cygGL-*.dll ${dir_build}/bin/ # (0x6fef0000)
cp -rfv /usr/bin/cygGLU-*.dll ${dir_build}/bin/ # (0x701c0000)
cp -rfv /usr/bin/cygglut-*.dll ${dir_build}/bin/ # (0x65640000)
cp -rfv /usr/bin/cygX11-*.dll ${dir_build}/bin/ # (0x6aaf0000)
cp -rfv /usr/bin/cygogg-*.dll ${dir_build}/bin/ # (0x68640000)
cp -rfv /usr/bin/xvidcore.dll ${dir_build}/bin/ # (0xf00000)
cp -rfv /usr/bin/cygintl-8.dll ${dir_build}/bin/ # (0x69320000)
cp -rfv /usr/bin/cygexpat-*.dll ${dir_build}/bin/ # (0x6a0d0000)
cp -rfv /usr/bin/cygbrotlidec-*.dll ${dir_build}/bin/ # (0x6a810000)
cp -rfv /usr/bin/cyguuid-*.dll ${dir_build}/bin/ # (0x673c0000)
cp -rfv /usr/bin/cygpng*.dll ${dir_build}/bin/ # (0x67fb0000)
cp -rfv /usr/bin/cygbz2-*.dll ${dir_build}/bin/ # (0x6a7f0000)
cp -rfv /usr/bin/cygglib-*.0-*.dll ${dir_build}/bin/ # (0x69a60000)
cp -rfv /usr/bin/cygxcb-*.dll ${dir_build}/bin/ # (0x67200000)
cp -rfv /usr/bin/cygX11-xcb-*.dll ${dir_build}/bin/ # (0x6aae0000)
cp -rfv /usr/bin/cygXext-*.dll ${dir_build}/bin/ # (0x6aa80000)
cp -rfv /usr/bin/cygglapi-*.dll ${dir_build}/bin/ # (0x69b80000)
cp -rfv /usr/bin/cygXi-*.dll ${dir_build}/bin/ # (0x6aa50000)
cp -rfv /usr/bin/cygXrandr-*.dll ${dir_build}/bin/ # (0x6aa20000)
cp -rfv /usr/bin/cygbrotlicommon-*.dll ${dir_build}/bin/ # (0x6a830000)
cp -rfv /usr/bin/cygpcre-*.dll ${dir_build}/bin/ # (0x68480000)
cp -rfv /usr/bin/cygXau-*.dll ${dir_build}/bin/ # (0x6aad0000)
cp -rfv /usr/bin/cygXdmcp-*.dll ${dir_build}/bin/ # (0x6aaa0000)
cp -rfv /usr/bin/cygxcb-glx-*.dll ${dir_build}/bin/ # (0x671e0000)
cp -rfv /usr/bin/cygXrender-*.dll ${dir_build}/bin/ # (0x6aa00000)
cp -rfv /usr/bin/xvidcore.dll ${dir_build}/bin/ # (0xf00000)
cp -rfv /usr/bin/cygncursesw-*.dll ${dir_build}/bin/ # (0x700000)
cp -rfv /usr/bin/cygxml2-*.dll ${dir_build}/bin/ # (0x1020000)
cp -rfv /usr/bin/cygstdc++-*.dll ${dir_build}/bin/ # (0x1170000)
cp -rfv /usr/bin/cygstdc++-*.dll ${dir_build}/bin/ # (0x1380000)
cp -rfv /usr/bin/cygharfbuzz-*.dll ${dir_build}/bin/ # (0x1590000)
cp -rfv /usr/bin/cygsoxr-*.dll ${dir_build}/bin/ # (0x6b900000)
cp -rfv /usr/bin/cyglzma-*.dll ${dir_build}/bin/ # (0x68d30000)
cp -rfv /usr/bin/cyggomp-*.dll ${dir_build}/bin/ # (0x760000)
cp -rfv /usr/bin/cyggomp-*.dll ${dir_build}/bin/ # (0x760000)
cp -rfv /usr/bin/cyggomp-*.dll ${dir_build}/bin/ # (0x760000)
cp -rfv /usr/bin/cyggraphite*.dll ${dir_build}/bin/ # (0x7a0000)
strip --strip-all ${dir_build}/bin/*
cp -rfv /usr/bin/cyggcc_s-*.dll ${dir_build}/bin/ # (0x69e70000)
cp -rfv /usr/bin/cygwin1.dll ${dir_build}/bin/ # (0x61000000)
cp -rfv /usr/bin/cygz.dll ${dir_build}/bin/ # (0x67030000)

# Create package
echo "* Creating package"
cd ${dir_build}
rm -rf lib
rm -rf include
zip ${name_folder}-win-32bit-build-cygwin.zip -r *
rm -rf ${dir_build_packages}/${name_folder}-win-32bit-build-cygwin.zip
mv ${name_folder}-win-32bit-build-cygwin.zip ${dir_build_packages}
echo ""
echo "* Your build: ${dir_build_packages}/${name_folder}-win-32bit-build-cygwin.zip"
echo ""
chmod 775 -R ${dir_build_packages}


