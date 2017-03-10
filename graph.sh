DESTDIR=graph/
mkdir -p $DESTDIR
for SRCFILE in ../polemos/*_*.xml
do
  FILENAME="${SRCFILE##*/}"
  NAME=${FILENAME%.*}
  DESTFILE=$DESTDIR"$NAME"
  echo $NAME
  xsltproc -o "$DESTFILE"-nodes.tsv polemos2nodes.xsl $SRCFILE
  xsltproc -o "$DESTFILE"-edges.tsv polemos2edges.xsl $SRCFILE
done
