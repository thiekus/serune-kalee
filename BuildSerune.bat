@echo off

echo * Cleaning files and old compiler output *
start /i /wait CleanUp.bat
echo.

echo * Compiling Serune Kalee Engine *
cd SeruneEngine
start /i /wait DccMake.bat
cd..
echo.

echo * Compiling Serune Kalee Main UI Frontend *
cd MainUI
start /i /wait DccMake.bat
cd..
echo.

echo * Compiling Serune Kalee Event Editor *
cd EventEdit
start /i /wait DccMake.bat
cd.. 
echo.

echo * Compiling Serune Kalee Shell Registator *
cd ShellRegist
start /i /wait DccMake.bat
cd..
echo.

echo * Striping unused relocation section *
StripReloc /b Serunee.exe 
StripReloc /b SKEventEdit.exe
StripReloc /b SKShlReg.exe
echo.

echo # DONE! #
exit