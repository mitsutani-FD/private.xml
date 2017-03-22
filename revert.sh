#!/bin/bash

find . -name "*.orig" |
while read name;do
  nn=$(sed -e s/\.orig$// <<< $name)
  rm $nn
  mv $name $nn
done
