#!/bin/bash

###########################################
# Script for build FFmpeg on Linux x86    #
# Author: q3aql                           #
# Contact: q3aql@duck.com                 #
###########################################

# Build variables
dir_build="/opt/ffmpeg-builds/build/linux32"
dir_build_libs="/opt/ffmpeg-builds/lib/linux32"
dir_build_packages="/opt/ffmpeg-builds/packages"

# FFmpeg version
ffmpeg_package="https://ffmpeg.org/releases/ffmpeg-5.0.1.tar.bz2"
ffmpeg_package_name="ffmpeg-5.0.tar.bz2@ffmpeg-5.0.1"

# Build parameters 
ffmpeg_parameters="--prefix=${dir_build}/usr --enable-gpl --enable-nonfree --enable-version3 \
--enable-static --disable-debug --disable-indev=sndio --disable-outdev=sndio --cc=gcc \
--enable-fontconfig --enable-frei0r --enable-openssl --enable-libgme  --enable-libaom \
--enable-libfribidi --enable-libass --enable-libfreetype --enable-libmp3lame --disable-shared \
--enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopenjpeg --enable-librubberband \
--enable-libsoxr --enable-libspeex --enable-libvorbis --enable-libopus --enable-libtheora \
--enable-libvidstab --enable-libvo-amrwbenc --enable-libvpx --enable-libwebp --enable-libx264 \
--enable-libx265 --enable-libxml2 --enable-libdav1d --enable-libxvid --enable-libzvbi \
--enable-libwebp"

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
mkdir -p ${dir_build}/usr
mkdir -p ${dir_build_libs}
mkdir -p ${dir_build_packages}

# Install dependencies
echo "* Installing dependencies"
apt-get install gcc wget make libconfig-dev libfrei0r-ocaml-dev libssl-dev libgme-dev \
libaom-dev libfribidi-dev libass-dev libvmatch-dev libfreetype-dev libmp3lame-dev yasm \
libopencore-amrnb-dev libopencore-amrwb-dev libjpeg-dev librubberband-dev libsoxr-dev \
libspeex-dev libvorbis-dev libopus-dev libtheora-dev libvidstab-dev libvo-amrwbenc-dev \
libvpx-dev libwebp-dev libx264-dev libx265-dev libxml2-dev libdav1d-dev libxvidcore-dev \
libzvbi-dev nasm libogg-dev libwebp-dev zlib1g-dev

# Download FFmpeg
echo "* Building FFmpeg using system libraries"
name_package=$(echo ${ffmpeg_package_name} | cut -d "@" -f 1)
name_folder=$(echo ${ffmpeg_package_name} | cut -d "@" -f 2)
wget -c ${ffmpeg_package}
tar jxvf ${name_package}
cd ${name_folder}
chmod +x configure
./configure ${ffmpeg_parameters}
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
tar jcvf ${name_folder}-linux-gnu-32bit-build-native.tar.bz2 *
rm -rf ${dir_build_packages}/${name_folder}-linux-gnu-32bit-build-native.tar.bz2 
mv ${name_folder}-linux-gnu-32bit-build-native.tar.bz2 ${dir_build_packages}
echo ""
echo "* Your build: ${dir_build_packages}/${name_folder}-linux-gnu32bit-build-native.tar.bz2"
echo ""
chmod 775 -R ${dir_build_packages}
