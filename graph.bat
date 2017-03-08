@echo off
setlocal enableDelayedExpansion
set HERE=%~dp0
:: set current directory if called by 2click
cd /d %HERE%
set SRCDIR=..\polemos\
set DESTDIR=.\graph\
if not exist %DESTDIR% mkdir %DESTDIR%
echo Gongora, transformation : graphes 
for /r %%F in (%SRCDIR%*.xml) do (
  set DESTNAME=%%~nF
  %HERE%xsltproc\xsltproc -o %DESTDIR%%%~nF-nodes.csv %HERE%polemos2nodes.xsl %%F
  %HERE%xsltproc\xsltproc -o %DESTDIR%%%~nF-edges.csv %HERE%polemos2edges.xsl %%F
)
PAUSE
