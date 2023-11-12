@echo off

echo Checking for admin rights...
net session >nul 2>&1
if %errorLevel% == 0 (
  echo Admin rights granted.
) else (
  echo Admin rights required. Please run this script as an administrator.
  exit /b 1
)

echo Installing fonts...

set mainFontFolder="./../fonts/otf"

for /r "%mainFontFolder%" %%f in (*.ttf, *.otf, *.woff, *.woff2) do (
  copy "%%f" "%WINDIR%\Fonts"
  reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nxf (TrueType)" /t REG_SZ /d %%~nxf /f
)

set mainFontFolder="./../fonts/varible"

for /r "%mainFontFolder%" %%f in (*.ttf, *.otf, *.woff, *.woff2) do (
  copy "%%f" "%WINDIR%\Fonts"
  reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nxf (TrueType)" /t REG_SZ /d %%~nxf /f
)

echo All fonts installed successfully.