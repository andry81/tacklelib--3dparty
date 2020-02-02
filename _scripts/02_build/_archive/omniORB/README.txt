* README.txt
* omniORB

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
2. Read omniORB documentatuion:
    - http://wiki.asoft/wiki/index.php/CrossFlow/Manuals/omniORBBuild
3. patch omniORB directory if not done yet:
    - copy all from /_patches/* directory into respective omniORB directory

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
cleanup_*.bat
