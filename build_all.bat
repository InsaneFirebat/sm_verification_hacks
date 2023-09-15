@echo off

echo Building all distributed patches
cd resources
python create_dummies.py 00.sfc ff.sfc

echo Building True Completion Verification hack
copy *.sfc ..\build
..\tools\asar --no-title-check ..\src\TC_Verify.asm ..\build\00.sfc
..\tools\asar --no-title-check ..\src\TC_Verify.asm ..\build\ff.sfc
python create_ips.py ..\build\00.sfc ..\build\ff.sfc ..\build\TrueCompletionVerification_v1.2.ips

echo Building Map Completion Verification hack
copy *.sfc ..\build
..\tools\asar --no-title-check ..\src\Map_Verify.asm ..\build\00.sfc
..\tools\asar --no-title-check ..\src\Map_Verify.asm ..\build\ff.sfc
python create_ips.py ..\build\00.sfc ..\build\ff.sfc ..\build\MapCompletionVerification_v1.2.ips

echo Building All Doors Verification hack
copy *.sfc ..\build
..\tools\asar --no-title-check ..\src\Doors_Verify.asm ..\build\00.sfc
..\tools\asar --no-title-check ..\src\Doors_Verify.asm ..\build\ff.sfc
python create_ips.py ..\build\00.sfc ..\build\ff.sfc ..\build\AllDoorsVerification_v1.1.ips

del 00.sfc ff.sfc ..\build\00.sfc ..\build\ff.sfc
cd ..
PAUSE
