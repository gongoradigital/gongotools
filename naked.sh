home=`dirname $0`
if [ home = "" ]
  then home = "."
fi
for srcfile in $home/../polemos/*.xml
do
  destfile=$home/../polemos-naked/`basename $srcfile`
  echo $destfile
  xsltproc -o $destfile $home/tei4txm.xsl $srcfile
done
