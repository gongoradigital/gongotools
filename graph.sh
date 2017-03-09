DESTDIR=graph/
mkdir -p $DESTDIR
for SRCFILE in ../polemos/*_*.xml
do
  FILENAME="${SRCFILE##*/}"
  NAME=${FILENAME%.*}
  DESTFILE=$DESTDIR"$NAME"
  xsltproc -o "$DESTFILE"-nodes.csv polemos2nodes.xsl $SRCFILE
  xsltproc -o "$DESTFILE"-edges.csv polemos2edges.xsl $SRCFILE
done
