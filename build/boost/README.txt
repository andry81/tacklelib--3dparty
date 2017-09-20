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
    - msvc2015 for vc14_x64 + Update 3
    - msvc2015 for vc14_x86 + Update 3
2. Read internet:
   a. Unknown compiler version while compiling Boost with MSVC 14.0 (VS 2015):
      http://stackoverflow.com/questions/30760889/unknown-compiler-version-while-compiling-boost-with-msvc-14-0-vs-2015
3. patch boost directory if not done yet:
    - apply patches from /_patches directory into boost directory

-------------------------------------------------------------------------------
2. CONFIGURE
-------------------------------------------------------------------------------
1. run configure.bat
2. edit configure.user.bat

-------------------------------------------------------------------------------
3. BUILD
-------------------------------------------------------------------------------
run build.bat

-------------------------------------------------------------------------------
4. CLEANUP
-------------------------------------------------------------------------------
To cleanup all including stage directories:
  cleanup_all.bat
To cleanup only build cache w/o stage directories:
  cleanup_temp.bat
