#!/usr/bin/env bash

LANG=$1
FILE=$2

if [ $# -ne 2 ] # verifier si le script a un argument
then
	echo "ce programme demande deux arguments: le chemin vers le fichier ro.txt et un argument pour le chemin vers le fichier dumps créé" 
	exit
fi

echo "<lang='ro'>" >$FILE #can I use single quotes here?

N=1

while read -r line;
do
	echo "<page='ro-$N'>" >> $FILE
	echo "<text>" >> $FILE
	cat ../dumps-text/dump_ro_$N.txt | sed "s|&|&amp|g" | sed "s|<|&lt|g" | sed "s|>|&gt|g" >> $FILE
	echo "</text>" >> $FILE
	echo "</page>§" >> $FILE
	N=$(expr $N + 1)
done < $LANG

echo "</lang>" >> $FILE