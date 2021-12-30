FFmpeg builds for GNU/Linux & Windows (with Cygwin) 
===================================================

### FFmpeg 4.4.1 Builds:

  * **`GNU/Linux downloads (Static):`**
  
    * Generic (All distros):
    
      * [ffmpeg-4.4.1-linux-gnu-32bit-build.tar.bz2](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-linux-gnu-32bit-build.tar.bz2)
      * [ffmpeg-4.4.1-linux-gnu-64bit-build.tar.bz2](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-linux-gnu-64bit-build.tar.bz2)
     
     * DEB (Debian Based):
     
       * [ffmpeg-4.4.1-linux-gnu-32bit-build.deb](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-linux-gnu-32bit-build.deb)
       * [ffmpeg-4.4.1-linux-gnu-64bit-build.deb](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-linux-gnu-64bit-build.deb)
       
     * RPM (RedHat Based):
     
       * [ffmpeg-4.4.1-linux-gnu-32bit-build.rpm](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-linux-gnu-32bit-build.rpm)
       * [ffmpeg-4.4.1-linux-gnu-64bit-build.rpm](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-linux-gnu-64bit-build.rpm)
       
  * **`Windows downloads (with Cygwin):`**
  
    * [ffmpeg-4.4.1-win-32bit-build-cygwin.zip](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-win-32bit-build-cygwin.zip)
    * [ffmpeg-4.4.1-win-64bit-build-cygwin.zip](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-win-64bit-build-cygwin.zip)

### HOW TO INSTALL:

  * **GNU/Linux instructions:**
  
    * Open the terminal and type the following command:
    
      ```shell
      $ sudo tar jxvf ffmpeg-4.4.1-linux-gnu-[arch]-build.tar.bz2 -C /
      ````
    
    _Note: Replace `[arch]` with `linux32` or `linux64` depending on your architecture._
      
  * **Windows instructions:**
    
    * Download the package ([32 bits](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-win-32bit-build-cygwin.zip) or [64 bits](https://github.com/q3aql/ffmpeg-builds/releases/download/v4.4.1/ffmpeg-4.4.1-win-64bit-build-cygwin.zip))
    * Unzip the package with [7-zip](http://www.7-zip.org/) or [Winrar](http://www.rarlab.com/).
    * Copy the files to a folder. For example: `C:\Program Files\FFmpeg`
    * Add the path `C:\Program Files\FFmpeg` to [PATH](https://www.google.es/search?q=add+folder+to+PATH+on+Windows) variable.
    
### HOW TO CREATE YOUR BUILD:

  * **GNU/Linux instructions:**
  
    * Install dependencies in your Linux distro:
    * Dependencies: `wget`, `git`, `gcc`, `g++`, `yasm`, `nasm`, `make`, `meson`, `ninja`. `gperf`, `autoconf` and `libtool`
    * Type the following commands:

      ```shell
      $ git clone https://github.com/q3aql/ffmpeg-builds/
      $ cd ffmpeg-builds
      $ sudo ./ffmpeg-static-build-[arch].sh
      ````
    
    _Note: Replace `[arch]` with `linux32` or `linux64` depending on your architecture._
      
  * **Windows instructions:**
  
    * Install Cywin for [32bits](https://cygwin.com/setup-x86.exe) or [64bits](https://cygwin.com/setup-x86_64.exe).
    * During installation, configure the repository and install `git` and `wget`.
    * Open Cygwin terminal and type the following commands:
    
    ```shell
      $ git clone https://github.com/q3aql/ffmpeg-builds/
      $ cd ffmpeg-builds
      $ ./ffmpeg-share-build-[arch].sh
      ````
    
    _Note: Replace `[arch]` with `cygwin32` or `cygwin64` depending on your architecture._

### Related links:

  * [FFmpeg homepage](https://ffmpeg.org/)
  * [FFmpeg Linux builds by John](https://johnvansickle.com/ffmpeg/)
  * [FFmpeg Win64/Linux64 Builds by Btbn](https://github.com/BtbN/FFmpeg-Builds)
  * [FFmpeg Win32 Builds](https://github.com/sudo-nautilus/FFmpeg-Builds-Win32)

