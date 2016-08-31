#!/bin/sh

y=$(date +"%Y")
m=$(date +"%m")

dest="images/$y/$m"

echo "Create: $dest"
mkdir -p $dest
