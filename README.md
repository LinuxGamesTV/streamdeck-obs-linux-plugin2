
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

# Install
-
        1. download the libStreamDeckPlugin.tar.gz and unpack it in downloads
        2. If you want build the Plugin from source, you must go to your build folder
        3. now copy the libStreamDeckPlugin.so to "/usr/lib64/obs-plugins" (opensuse) or to the path where your system sore the obs plugins global. You must install it global!
        4. Now start opendeck and then obs-studio, if you see the plugin in obs under tools you are done
		
	<img width="1449" height="663" alt="obs2" src="https://github.com/user-attachments/assets/b519e224-ebaf-443e-b537-eb5af9d2ac60" />

       
