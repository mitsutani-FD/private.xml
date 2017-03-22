#!/bin/bash
set -eux
thisdir=$(cd $(dirname $0); pwd)
cd $thisdir

if [ $# -gt 0 ]; then
    echo $1
    KarabinerDir=$(cd "$1"; pwd)
else
    echo "KarabinerDir is not given."
    echo "the program guess the directory."
    KarabinerDir=$(dirname "$(find $HOME/Library -name "private.xml")")
fi
echo -n "KarabinerDir is set $KarabinerDir. ok? [Y/n]: "
read ans
if [ "x$ans" == "xn" ]; then
  exit
fi


for xmlpath in $(ls *.xml)
do
    xmlbase=$(basename $xmlpath)
    srcfile="$thisdir/$xmlbase"
    distfile="$KarabinerDir/$xmlbase"
    if [ -f "$distfile" ]; then
        echo "File '${distfile}' is alredy exist."
        echo "the program rename it to ${distfile}.orig"
        mv "$distfile" "${distfile}.orig"
    fi
    ln -s "$srcfile" "$distfile"
    echo "link $srcfile to $distfile"
done
