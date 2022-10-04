FFmpeg builds for GNU/Linux & Windows
=====================================

### FFmpeg 5.1.2 Builds:

  * **`GNU/Linux downloads (Static):`**
  
    * [ffmpeg-5.1.2-linux-gnu-32bit-build.tar.bz2](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-linux-gnu-32bit-build.tar.bz2) (Generic Linux x86)
    * [ffmpeg-5.1.2-linux-gnu-64bit-build.tar.bz2](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-linux-gnu-64bit-build.tar.bz2) (Generic Linux x86_64)
    * [ffmpeg-5.1.2-linux-gnu-32bit-build.deb](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-linux-gnu-32bit-build.deb) (Debian/Ubuntu x86)
    * [ffmpeg-5.1.2-linux-gnu-64bit-build.deb](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-linux-gnu-64bit-build.deb) (Debian/Ubuntu x86_64)
    * [ffmpeg-5.1.2-linux-gnu-32bit-build.rpm](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-linux-gnu-32bit-build.rpm) (RedHat/Fedora x86)
    * [ffmpeg-5.1.2-linux-gnu-64bit-build.rpm](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-linux-gnu-64bit-build.rpm) (RedHat/Fedora x86_64)
       
  * **`Windows downloads (Shared):`**
  
    * [ffmpeg-5.1.2-win-32bit-build.zip](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-win-32bit-build.zip)
    * [ffmpeg-5.1.2-win-64bit-build.zip](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-win-64bit-build.zip)

### HOW TO INSTALL:

  * **GNU/Linux instructions:**

    * Download the package ([32 bits](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-linux-gnu-32bit-build.tar.bz2) or [64 bits](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-linux-gnu-64bit-build.tar.bz2)).
    * Open the terminal and type the following command:
    
      ```shell
      $ sudo tar jxvf ffmpeg-5.1.2-linux-gnu-[arch]-build.tar.bz2 -C /
      ```
    
    _Note: Replace `[arch]` with `32bit` or `64bit` depending on your architecture._
      
  * **Windows instructions:**
    
    * Download the package ([32 bits](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-win-32bit-build.zip) or [64 bits](https://github.com/q3aql/ffmpeg-builds/releases/download/v5.1.2/ffmpeg-5.1.2-win-64bit-build.zip)).
    * Unzip the package with [7-zip](http://www.7-zip.org/) or [Winrar](http://www.rarlab.com/).
    * Copy the files to a folder. For example: `C:\Program Files\FFmpeg`
    * Add the path `C:\Program Files\FFmpeg` to [PATH](https://www.google.es/search?q=add+folder+to+PATH+on+Windows) variable.
    
### HOW TO CREATE YOUR BUILD:

  * **GNU/Linux instructions:**
  
    * Install dependencies in your GNU/Linux distro.
    * Dependencies: `wget`, `git`, `gcc`, `g++`, `yasm`, `nasm`, `make`, `meson`, `ninja`. `gperf`, `autoconf` and `libtool`
    * Type the following commands:

      ```shell
      $ git clone https://github.com/q3aql/ffmpeg-builds
      $ cd ffmpeg-builds
      $ sudo ./ffmpeg-static-build-[arch].sh
      ```
    
    _Note: Replace `[arch]` with `linux32` or `linux64` depending on your architecture._
      
  * **Windows instructions:**
  
    * Install Cygwin for [32bits](https://cygwin.com/setup-x86.exe) or [64bits](https://cygwin.com/setup-x86_64.exe).
    * During installation, `configure the repository` and install `git` and `wget`.
    * Open Cygwin terminal and type the following commands:
    
      ```shell
      $ git clone https://github.com/q3aql/ffmpeg-builds
      $ cd ffmpeg-builds
      $ ./ffmpeg-share-build-[arch].sh
      ```
    
    _Note: Replace `[arch]` with `cygwin32` or `cygwin64` depending on your architecture._

### Related links:

  * [FFmpeg homepage](https://ffmpeg.org/)
  * [FFmpeg Linux builds by John](https://johnvansickle.com/ffmpeg/)
  * [FFmpeg Win64/Linux64 Builds by Btbn](https://github.com/BtbN/FFmpeg-Builds)
  * [FFmpeg Win32 Builds](https://github.com/sudo-nautilus/FFmpeg-Builds-Win32)

