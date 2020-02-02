* README.txt
* boost

1. PREREQUISITES
2. CONFIGURE
3. BUILD
4. CLEANUP

-------------------------------------------------------------------------------
1. PREREQUISITES
-------------------------------------------------------------------------------
1. Install Microsoft Visual Studio:
    - msvc2010 for vc10_x86 + SP1Rel
    - msvc2013 for vc12_x86 + Update 5
    - msvc2015 for vc14_x86/vc14_x64 + Update 3
    - msvc2017 for x86/x64
2. Read internet:
   a. Unknown compiler version while compiling Boost with MSVC 14.0 (VS 2015):
      http://stackoverflow.com/questions/30760889/unknown-compiler-version-while-compiling-boost-with-msvc-14-0-vs-2015
3. patch boost directory if not done yet:
    - apply patches from /_patches directory into boost directory

-------------------------------------------------------------------------------
2. CONFIGURE
-------------------------------------------------------------------------------
1. run `bootstrap.bat` from the source directory.
2. run `preconfigure.bat` from the `_build` directory.
3. run `configure.bat` from the `_build` directory.
4. edit `configure.user.bat`.

-------------------------------------------------------------------------------
3. BUILD
-------------------------------------------------------------------------------
run `build.bat` from the `_build` directory.

-------------------------------------------------------------------------------
4. CLEANUP
-------------------------------------------------------------------------------
Just remove out of source build directory associated with particular
architecture:

  `<root>/<architecture>/%BUILD_DIR%`
