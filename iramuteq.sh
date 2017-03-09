mkdir -p export
for SRCFILE in ../polemos/*_*.xml
do
  FILENAME="${SRCFILE##*/}"
  NAME=${FILENAME%.*}
  DESTFILE=iramuteq/"$NAME"_ira.txt
  xsltproc ../Teinte/tei2iramuteq.xsl $SRCFILE >> export/polemos.txt
done
