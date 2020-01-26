* README.txt
* qwt

1. PREREQUISITES
2. CONFIGURE
3. BUILD
4. POSTINSTALL
5. CLEANUP

-------------------------------------------------------------------------------
1. PREREQUISITES
-------------------------------------------------------------------------------
1. Install Microsoft Visual Studio:
    - msvc2010 for vc10_x86 + SP1Rel
    - msvc2013 for vc12_x86 + Update 5
    - msvc2015 for vc14_x86/vc14_x64 + Update 3
    - msvc2017 for vc2017_x86
2. Install QT before build the QWT
3. patch QWT directory if not done yet:
    - copy all from /_patches/QT* directory into respective QT directory

-------------------------------------------------------------------------------
2. CONFIGURE
-------------------------------------------------------------------------------
1. run `configure.bat` from the `_build` directory.
2. edit `configure.user.bat`.

-------------------------------------------------------------------------------
3. BUILD
-------------------------------------------------------------------------------
run `build.bat` from the `_build` directory

-------------------------------------------------------------------------------
4. POSTINSTALL
-------------------------------------------------------------------------------
Copy or use the `c:\Qwt-<version>` resulting directory.

-------------------------------------------------------------------------------
5. CLEANUP
-------------------------------------------------------------------------------
Just remove out of source build directory associated with particular
architecture:

  `<root>/<architecture>/%SRC_BASE_DIR%/%SRC_DIR%`
