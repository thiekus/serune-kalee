@echo off

echo * Builiding Serune Kalee Simulator *
start /i /wait BuildSerune.bat
echo.

echo * Building Installer *
cd ISetup
"C:\Program Files\Inno Setup 5\ISCC" Setup.iss
echo.

echo # DONE! #
echo.

pause