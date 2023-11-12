@echo off

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