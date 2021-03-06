@echo off
:: GetNuTool via batch
:: Copyright (c) 2015-2018,2020  Denis Kuzmin [ x-3F@outlook.com ]
:: https://github.com/3F/GetNuTool

set gntcore=.\gnt.core
if not exist %gntcore% goto error

for %%v in (4.0, 14.0, 12.0, 3.5, 2.0) do (
    for /F "usebackq tokens=2* skip=2" %%a in (
        `reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSBuild\ToolsVersions\%%v" /v MSBuildToolsPath 2^> nul`
    ) do if exist %%b (
        set msbuildexe="%%~b\MSBuild.exe"
        goto found
    )
)

:error
echo MSBuild or %gntcore% was not found. Try manually: msbuild %gntcore% {arguments}` 1>&2

exit /B 2

:found

:: echo MSBuild Tools: %msbuildexe%

%msbuildexe% %gntcore% /nologo /v:m /m:4 %*
REM /noconlog