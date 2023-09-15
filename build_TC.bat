@echo off

cd build
echo Building True Completion Verification hack
cp sm_orig.sfc sm_VerifyTC.sfc && cd ..\src && ..\tools\asar.exe --no-title-check --symbols=wla --symbols-path=..\build\Debug_Symbols.sym ..\src\TC_Verify.asm ..\build\sm_VerifyTC.sfc && cd ..

PAUSE
