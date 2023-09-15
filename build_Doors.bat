@echo off

cd build
echo Building All Doors Verification hack
cp sm_orig.sfc sm_VerifyDoor.sfc && cd ..\src && ..\tools\asar.exe --no-title-check --symbols=wla --symbols-path=..\build\Debug_Symbols.sym ..\src\Doors_Verify.asm ..\build\sm_VerifyDoor.sfc && cd ..

PAUSE
