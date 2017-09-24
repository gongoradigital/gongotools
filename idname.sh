for SRCFILE in ../polemos/*.xml
do
  echo $SRCFILE
  xsltproc -o $SRCFILE idname.xsl $SRCFILE
done
