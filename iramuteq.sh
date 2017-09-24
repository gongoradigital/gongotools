mkdir -p export
for SRCFILE in ../polemos/*.xml
do
  FILENAME="${SRCFILE##*/}"
  NAME=${FILENAME%.*}
  DESTFILE=iramuteq/"$NAME"_ira.txt
  xsltproc tei2iramuteq.xsl $SRCFILE >> export/polemos_iramuteq.txt
done
