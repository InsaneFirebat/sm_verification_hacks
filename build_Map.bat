@echo off

cd build
echo Building True Completion Verification hack
cp sm_orig.sfc sm_VerifyMap.sfc && cd ..\src && ..\tools\asar.exe --no-title-check --symbols=wla --symbols-path=..\build\Debug_Symbols.sym ..\src\Map_Verify.asm ..\build\sm_VerifyMap.sfc && cd ..

PAUSE
