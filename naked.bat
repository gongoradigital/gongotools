@echo off 
setlocal enableDelayedExpansion 
set HERE=%~dp0
:: set current directory if called by 2click
cd /d %HERE%
set SRCDIR=..\polemos\
set DESTDIR=..\polemos-naked\naked\
echo Gongora, transformation : naked 
for /r %%F in (%SRCDIR%*.xml) do (
  set FILENAME=%%~nF
  echo %DESTDIR%%%~nF.xml
  %HERE%xsltproc\xsltproc -o %DESTDIR%%%~nF.xml %HERE%tei2naked.xsl %%F
)
PAUSE