* README.txt
* tao

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

-------------------------------------------------------------------------------
2. CONFIGURE
-------------------------------------------------------------------------------
1. run configure.bat
2. edit configure.user.bat
3. convert if necessary Visual Studio solution into target platform manually
   (to do it just open TAO_ACE.sln in target Visual Studio and approve
   convertion procedure)

-------------------------------------------------------------------------------
3. BUILD
-------------------------------------------------------------------------------
run build.bat

-------------------------------------------------------------------------------
4. CLEANUP
-------------------------------------------------------------------------------
To cleanup a target including stage directories:
  cleanup_<target>.bat
To cleanup only build cache w/o stage directories:
  cleanup_temp.bat
