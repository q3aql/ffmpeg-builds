#!/bin/bash

########################################################
# Script to install FFmpeg on GNU/Linux                #
# Website: https://www.johnvansickle.com/ffmpeg/       #
# Created by q3aql (q3aql@protonmail.ch)               #
# Builds by John Van Sickle (john.vansickle@gmail.com) #
# Licensed by GPL v2.0                                 #
# Date: 27-03-2021                                     #
########################################################
VERSION="v2.0"
M_DATE="270321"

# Variables
URL="https://www.johnvansickle.com/ffmpeg/"
URL_RELEASES="https://johnvansickle.com/ffmpeg/releases/"
URL_BUILDS="https://johnvansickle.com/ffmpeg/builds/"
TMP_DIR=/tmp
PATH_INSTALL=/usr/bin/
# Downloader
APP_DOWNLOAD="x"
NAME_APP_DOWNLOAD="x"


# Function to check root permission
function rootMessage() {
  mkdir -p /etc/root &> /dev/null
  administrator=$?
  if [ ${administrator} -eq 0 ] ; then
    rm -rf /etc/root
  else
    echo ""
    echo "* ffmpeg-install ${VERSION} (${M_DATE}) (GPL v2.0)"
    echo ""
    echo "+ Root permissions are required!"
    echo ""
    exit
fi
}

# Function to detect "kernel" name
function kernelCheck() {
  KERNEL=$(uname -s)
  if   [ $KERNEL == "Linux" ]; then
    KERNEL=linux
  else
    echo ""
    echo "* ffmpeg-install ${VERSION} (${M_DATE}) (GPL v2.0)"
    echo ""
    echo "+ Unsupported OS ($KERNEL)"
    echo ""
    exit
  fi
}

# Function to detect "arch" system.
function archCheck() {
  archs=$(uname -m)
  case "${archs}" in
    i?86)
      ARCH=i686
    ;;
    x86_64)
      ARCH=amd64
    ;;
    *)
    echo ""
    echo "* ffmpeg-install ${VERSION} (${M_DATE}) (GPL v2.0)"
    echo ""
    echo "+ Unsupported Arquitecture (${archs})"
    echo ""
    exit
  esac
}

# Function to check if 'curl' is installed.
function curlCheck () {
  curl --help &> /dev/null
  if [ "$?" -eq 0 ] ; then
    echo "OK" > /dev/null
  else
    echo ""
    echo "* ffmpeg-install ${VERSION} (${M_DATE}) (GPL v2.0)"
    echo ""
    echo "+ Error: You must install 'curl'."
    echo ""
    exit
  fi
}

# Function to check available downloaders (wget, axel or aria2c).
function checkDownloader() {
# Check wget installed
  wget --help &> /dev/null
  checkWget="$?"
  # Check axel installed
  axel --help &> /dev/null
  checkAxel="$?"
  # Check aria2c installed
  aria2c --help &> /dev/null
  checkAria2="$?"
  # Check variables
  if [ ${checkAria2} -eq 0 ] ; then
    APP_DOWNLOAD='aria2c --check-certificate=false'
    NAME_APP_DOWNLOAD="aria2c"
  elif [ ${checkAxel} -eq 0 ] ; then
    APP_DOWNLOAD='axel'
    NAME_APP_DOWNLOAD="axel"
  elif [ ${checkWget} -eq 0 ] ; then
    APP_DOWNLOAD='wget -c'
    NAME_APP_DOWNLOAD="wget"
  elif [ "x${APP_DOWNLOAD}" = "x" ] ; then
    echo ""
    echo "* ffmpeg-install ${VERSION} (${M_DATE}) (GPL v2.0)"
    echo ""
    echo "+ Error: You must install 'wget' or 'axel' or 'aria2'."
    echo ""
    exit
  fi
}

# Check all configs
rootMessage
kernelCheck
archCheck
curlCheck
checkDownloader

# Sintax to install, update and uninstall FFmpeg.
case ${1} in
  --install|-install|--update|-update)
    cd ${TMP_DIR}
    rm -rf ffmpeg-*
    echo ""
    echo "* ffmpeg-install ${VERSION} (${M_DATE}) (GPL v2.0)"
    echo ""
    if [ "${2}" == "release" ] ; then
      curl ${URL} | grep "${URL_RELEASES}" | cut -d '"' -f 2 | grep "${ARCH}" | head -1 > $TMP_DIR/ffmpeg-url
      if [ "$?" -eq 0 ] ; then
        echo "OK" > /dev/null
      else
        echo "+ Connection problem!"
        echo "* Exiting..."
        exit
      fi
    else
      curl ${URL} | grep "${URL_BUILDS}" | cut -d '"' -f 2 | grep "${ARCH}" | head -1 > $TMP_DIR/ffmpeg-url
      if [ "$?" -eq 0 ] ; then
        echo "OK" > /dev/null
      else
        echo "+ Connection problem!"
        echo "* Exiting..."
      exit
      fi
    fi
    URL_PACKAGE=`cat $TMP_DIR/ffmpeg-url`
    NAME_PACKAGE=`cat /tmp/ffmpeg-url | cut -d "/" -f 6`
    #clear
    echo "* Downloading ${NAME_PACKAGE} (${NAME_APP_DOWNLOAD})"
    ${APP_DOWNLOAD} ${URL_PACKAGE}
    if [ "$?" -eq 0 ] ; then
      echo "OK" > /dev/null
    else
      echo ""
      echo "+ Connection problem!"
      echo "* Exiting..."
      exit
    fi
    tar Jxvf ${NAME_PACKAGE}
    rm -f ffmpeg-url ffmpeg*xz
    cd ffmpeg-*
    cp -rfv ffmpeg ${PATH_INSTALL}
    cp -rfv ffprobe ${PATH_INSTALL}
    cd ..
    rm -rf ffmpeg-*
    echo "* Finished!"
    exit
  ;;
  --uninstall|-uninstall)
    echo ""
    echo "* ffmpeg-install ${VERSION} (${M_DATE}) (GPL v2.0)"
    echo ""
    echo "* Uninstalling FFmpeg..."
    sleep 3
    rm -rfv /usr/bin/ffmpeg
    rm -rfv /usr/bin/ffprobe
    echo "* Finished!"
  ;;
  --help|-help|-h|*)
    echo ""
    echo "* ffmpeg-install ${VERSION} (${M_DATE}) (GPL v2.0)"
    echo ""
    echo "* Script: q3aql (q3aql@protonmail.ch)"
    echo "* Builds: John Van Sickle (john.vansickle@gmail.com)"
    echo ""
    echo "+ Syntax:"
    echo ""
    echo " $ ffmpeg-install --install         --> Install FFmpeg (Git version)"
    echo " $ ffmpeg-install --install release --> Install FFmpeg (Stable version)"
    echo " $ ffmpeg-install --update          --> Update FFmpeg (Git version)"
    echo " $ ffmpeg-install --update release  --> Update FFmpeg (Stable version)"
    echo " $ ffmpeg-install --uninstall       --> Uninstall FFmpeg previously installed"
    echo " $ ffmpeg-install --help            --> Show help"
    echo ""
    exit
esac
