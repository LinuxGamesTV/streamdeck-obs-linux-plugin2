@ECHO OFF

echo hi

REM Bootstrap
SET "ROOT=%~dp0"
PUSHD "%ROOT%" > NUL

SET "ARCH=%1"
SET "BUILD=%ROOT%..\build\windows_%ARCH%"
SET "BUILDQT6=%ROOT%..\build_x64"
SET "DISTRIB=%ROOT%..\build\distrib"

:: Make Distrib Directory
if NOT EXIST "%DISTRIB%" (
	mkdir "%DISTRIB%"
)

:: Configure Qt6
cmake -H.. -B"%BUILD%" ^
  -G"Visual Studio 18 2026" -A"%2" ^
  -DCMAKE_INSTALL_PREFIX="%BUILD%_install" ^
  -DDOWNLOAD_QT=ON ^
  -DENABLE_CLANG=OFF ^
  -DWITH_QT6=ON ^
  -DBUILD_OLD=YES ^
  -DBUILD_LOADER=YES ^
  -DPROJECT_SUFFIX=Qt6
if %ERRORLEVEL% NEQ 0 (
	PAUSE
)

:: Compile Qt6
cmake --build "%BUILD%" --config RelWithDebInfo --target INSTALL
if %ERRORLEVEL% NEQ 0 (
	PAUSE
)

pwsh ..\obs-scripts\scripts\Build-Windows.ps1 RelWithDebInfo x64 "Visual Studio 18 2026"

:: Configure Qt5
cmake -H.. -B"%BUILD%" ^
  -G"Visual Studio 18 2026" -A"%2" ^
  -DCMAKE_INSTALL_PREFIX="%BUILD%_install" ^
  -DDOWNLOAD_QT=ON ^
  -DWITH_QT6=ON ^
  -DBUILD_OLD=YES ^
  -DENABLE_CLANG=OFF ^
  -DBUILD_LOADER=YES ^
  -DPROJECT_SUFFIX=Qt5 ^
  -DASIO_PATH=third-party/asio
if %ERRORLEVEL% NEQ 0 (
	PAUSE
)

:: Compile Qt5
cmake --build "%BUILD%" --config RelWithDebInfo --target INSTALL
if %ERRORLEVEL% NEQ 0 (
	PAUSE
)

:: Configure OBS32
:: cmake -H.. -B"%BUILD%" ^
::   -G"Visual Studio 18 2026" -A"%2" ^
::   -DCMAKE_INSTALL_PREFIX="%BUILD%_install" ^
::   -DDOWNLOAD_QT=ON ^
::   -DWITH_QT6=OFF ^
::   -DBUILD_OLD=YES ^
::   -DENABLE_CLANG=OFF ^
::   -DBUILD_LOADER=YES ^
::   -DPROJECT_SUFFIX=OBS32 ^
:: if %ERRORLEVEL% NEQ 0 (
:: 	PAUSE
:: )

:: Compile OBS32
:: cmake --build "%BUILD%" --config RelWithDebInfo --target INSTALL
:: if %ERRORLEVEL% NEQ 0 (
:: 	PAUSE
:: )

:: Configure Loader
cmake -H.. -B"%BUILD%" ^
  -G"Visual Studio 18 2026" -A"%2" ^
  -DCMAKE_INSTALL_PREFIX="%BUILD%_install" ^
  -DDOWNLOAD_QT=ON ^
  -DWITH_QT6=ON ^
  -DBUILD_OLD=YES ^
  -DBUILD_LOADER=YES ^
  -DPROJECT_SUFFIX=
if %ERRORLEVEL% NEQ 0 (
	PAUSE
)

:: Compile Loader
cmake --build "%BUILD%" --config RelWithDebInfo --target INSTALL
if %ERRORLEVEL% NEQ 0 (
	PAUSE
)

POPD > NUL

:: Build Installer
PUSHD "%ROOT%../installer/Windows" > NUL

set "OBSPluginLocation=%BUILD%/RelWithDebInfo"
set "OBSPluginLocationQt6=%BUILDQT6%/RelWithDebInfo"
set BUILD_SETUP_CONFIGURATION=Setup
echo BUILD=%BUILD%
echo OBSPluginLocation=%OBSPluginLocation%
echo OBSPluginLocationQt6=%OBSPluginLocationQt6%
call Setup_Bamboo.bat

POPD > NUL
