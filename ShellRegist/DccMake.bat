@echo off

echo * Compiling ShellRegist Resources *
start /i /wait RescComp.bat
echo.

echo * Compiling ShellRegist *
dcc32 SKShlReg.dpr
echo.

exit