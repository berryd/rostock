#!/bin/bash
if [ -z $1 ]
    then
    echo "Usage:  $0 [FILE.stl]"
    exit
fi

FILE=`echo $1 | sed 's/.stl//i'`

echo 'projection(cut=true) import_stl("'$1'");' > TEMP_$FILE.scad

openscad -x $FILE.dxf TEMP_$FILE.scad

rm -f TEMP_$FILE.scad
