@echo off

echo * Compiling MainUI Resources *
start /i /wait RescComp.bat
echo.

echo * Compiling MainUI *
dcc32 Serunee.dpr
echo.

exit