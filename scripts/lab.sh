#!/bin/sh

cat > test <<EOF
#cpp
../lab5-1.dat\n
../lab5-2.dat\n
EOF

ORI=`ls *.zip`
IFS=' ' read -a arr <<< `ls *.zip`
DIR=${arr[0]}${arr[1]}${arr[2]}
cp *.zip $DIR'.zip'
mkdir $DIR
tar -xvf $DIR'.zip' -C $DIR'/'
rm $DIR'.zip'

python ../processD2L.py $DIR
cp data/* $DIR'Grade'
./grade.sh  $DIR'Grade'
rm -f test
