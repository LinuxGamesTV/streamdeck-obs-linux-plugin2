# Stream Deck - OBS Studio Linux Plugin 2.0

This is the source code of the Stream Deck OBS Studio plugin for Windows, macOS and Linux.

# Building
## Windows
1. Install any necessary prerequisites:
    - [Git for Windows](https://git-scm.com/download/win)
    - [CMake](https://cmake.org/) (minimum 3.8, recommended 3.11+)
    - [Visual Studio 2019](https://visualstudio.microsoft.com/downloads/) (Community or higher)
2. Clone the project including all submodules
    `git clone --recurse-submodules <url> <dir>`
3. Configure the project with [CMake](https://cmake.org/), either using `cmake-gui` or `cmake`.
    - `cmake`:
        1. Navigate to the cloned directory:
            `cd /D <dir>`
        2. Configure the project with cmake:
            `cmake -H. -Bbuild -G"Visual Studio 16 2019"`
        3. Build the project with cmake:
            `cmake --build "build" --config RelWithDebInfo`
        4. If you change any files, all you have to do is re-run step 3 in the correct directory.
    - `cmake-gui`:
        1. Change the source directory to the cloned project.
        2. Change the build directory to any directory you want.
        3. Click `Configure` and set things up for Visual Studio.
        4. Click `Generate` and wait.
        5. Click `Open Project` which opens up Visual Studio with the current project.
        6. Build the project with Visual Studio.
        7. If you change any files, just rebuild with Visual Studio.
4. or go in the cloned dir: "streamdeck-obs-linux-plugin2\ci" and execute windows_x86-64.bat
 
## Linux
1. Install any necessary prerequisites:
    - Debian-based:
        ```
        apt-get install \
         build-essential checkinstall pkg-config \
         git cmake ninja-build \
         qt5base5-dev libqt5svg5-dev libqt5x11extras5-dev
        ```
    - openSUSE:
        ```
        zypper in \
         build-essential checkinstall pkg-config \
         git cmake ninja-build gcc gcc-c++ \
         libqt5-qtbase-devel libqt5-qtx11extras-devel
        ```
    - Red Hat / Fedora-based:
        ```
        apt-get install \
         gcc gcc-c++ \
         git cmake ninja-build \
         qt5-qtbase-devel qt5-qtx11extras-devel qt5-qtsvg-devel
        ```
2. Clone the project including all submodules
    `git clone --recurse-submodules <url> <dir>`
3. Configure the project with [CMake](https://cmake.org/), either using `cmake-gui` or `cmake`.
    - `cmake`:
        1. Navigate to the cloned directory:
            `cd <dir>`
        2. Configure the project with cmake:
            `cmake -H. -Bbuild -G"Ninja"`
        3. Build the project with cmake:
            `cmake --build "build" --config RelWithDebInfo`
        4. If you change any files, all you have to do is re-run step 3 in the correct directory.
    - `cmake-gui`:
        1. Change the source directory to the cloned project.
        2. Change the build directory to any directory you want.
        3. Click `Configure` and set things up for the compiler and IDE of choice.
        4. Click `Generate` and wait.
        5. Click `Open Project` which opens up the IDE for further editing.

## macOS
1. Install any necessary prerequisites:
    - Xcode 12
    - [CMake](https://cmake.org/)
    - [Packages](http://s.sudre.free.fr/Software/Packages/about.html) to build the installer
2. Clone the project including all submodules
    `git clone --recurse-submodules <url> <dir>`
3. Configure the project with [CMake](https://cmake.org/), either using `cmake-gui` or `cmake`.
    - `cmake`:
        1. Navigate to the cloned directory:
            `cd <dir>`
        2. Configure the project with cmake:
            `cmake -H. -Bbuild -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15`
        3. Build the project with cmake:
            `cmake --build "build" --config RelWithDebInfo`
        4. If you change any files, all you have to do is re-run step 3 in the correct directory.
    - `cmake-gui`:
        1. Change the source directory to the cloned project.
        2. Change the build directory to any directory you want.
        3. Click `Configure` and set things up for the compiler and IDE of choice (Xcode most likely).
        4. Change the entry `CMAKE_OSX_DEPLOYMENT_TARGET` to `10.15`.
        5. Click `Generate` and wait.
        6. Click `Open Project` which opens up the IDE for further editing.

#  Install
## Linux
works with all distributions:

1. download the obs-streamdeck-linux-plugin-opensuse.tar.gz for opensuse and obs-streamdeck-linux-plugin.tar.gz for all other distributions and unpack it in downloads.
2. Move in "obs-streamdeck-linux-plugin" and copy now the "/usr" folder to "/" as root/su/sudo. 
3. If you want build the Plugin from source, you must go to your build folder.
4. Now start opendeck, install the Elgato OBS-Studio 2.2.4 Plugin from the Elgato Marketplace (with this Linux fix: https://github.com/LinuxGamesTV/elgato-obsstudio-Linux-plugin (no more need it) ) and then start obs-studio. If you see the plugin in obs under tools you are done.
5. The Flatpak Version from this PlugIn you can get at Flathub or the the realese Section and install with: `flatpak install com.obsproject.Studio.Plugin.StreamDeckOBSStudioLinuxPlugin`.

## Windows
works with all distributions:

1. download the obs-streamdeck-win64-plugin.tar.gz and unpack it in downloads.
2. Move in "obs-streamdeck-win64-plugin" and copy now the "plugins" folder to "C:\ProgramData\obs-studio" as Administrator.


<img width="1920" height="1080" alt="OBS-StreamdeckPlugin2" src="https://github.com/user-attachments/assets/e3bd7844-b507-473a-a7cb-b22aa539e329" />
<img width="1920" height="1080" alt="OBS-StreamdeckPlugin1" src="https://github.com/user-attachments/assets/f0954bee-30a1-46fc-aced-f424b674b0e0" />

