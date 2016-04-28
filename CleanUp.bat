@echo off

cd dcu
del /q *.*
cd..
cd SeruneEngine
del /q *.~*
cd..
cd MainUI
del /q *.~*
cd..
cd SoundBundle
del /q *.~*
cd..
cd ShellRegist
del /q *.~*
cd..
cd EventEdit
del /q *.~*

exit