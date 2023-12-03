#!/usr/bin/env bash

FOLDER=$1
LANG=$2
URL_FILE="../urls/$LANG.txt"

if [ $# -ne 2 ] # verifier si le script a un argument
then
	echo "ce programme demande deux arguments: un argument pour le chemin vers le dossier itrameur et la langue (version courte)" 
	exit
fi

echo "<lang='$LANG'>" >$FOLDER/dump-$LANG.txt
echo "<lang='$LANG'>" >$FOLDER/contexte-$LANG.txt

N=1

while read -r line;
do
	echo "<page='$LANG-$N'>" >> $FOLDER/dump-$LANG.txt
	echo "<page='$LANG-$N'>" >> $FOLDER/contexte-$LANG.txt
	echo "<text>" >> $FOLDER/dump-$LANG.txt
	echo "<text>" >> $FOLDER/contexte-$LANG.txt
	cat ../dumps-text/dump_${LANG}_$N.txt | sed "s|&|&amp;|g" | sed "s|<|&lt;|g" | sed "s|>|&gt;|g" >> $FOLDER/dump-$LANG.txt
	cat ../contexte/contexte_${LANG}_$N.txt | sed "s|&|&amp;|g" | sed "s|<|&lt;|g" | sed "s|>|&gt;|g" >> $FOLDER/contexte-$LANG.txt
	echo "</text>" >> $FOLDER/dump-$LANG.txt
	echo "</text>" >> $FOLDER/contexte-$LANG.txt
	echo "</page>§" >> $FOLDER/dump-$LANG.txt
	echo "</page>§" >> $FOLDER/contexte-$LANG.txt
	N=$(expr $N + 1)
done < $URL_FILE

echo "</lang>" >> $FOLDER/dump-$LANG.txt
echo "</lang>" >> $FOLDER/contexte-$LANG.txt