@echo off
setlocal enableDelayedExpansion
set HERE=%~dp0
:: set current directory if called by 2click
cd /d %HERE%
set SRCDIR=..\polemos\
set DESTDIR=.\
echo Gongora, transformation : graphes 
for /r %%F in (%SRCDIR%*.xml) do (
  set FILENAME=%%~nF
  echo %DESTDIR%%%~nF.xml
)
PAUSE
