#!/bin/sh

ORI=`ls *.zip`
IFS=' ' read -a arr <<< `ls *.zip`
DIR=${arr[0]}${arr[1]}${arr[2]}
mkdir $DIR
cp -r scripts/* $DIR
mv *.zip $DIR
#cd $DIR
#make
