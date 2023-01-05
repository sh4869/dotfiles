#!/bin/sh
for x in "$@"
do
  sh $x/.install.sh
done
