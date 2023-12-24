#!/usr/bin/env bash

FOLDER=$1
URL_LANG=$2
URL_FILE="../urls/$URL_LANG.txt"

if [ $# -ne 2 ] # verifier si le script a un argument
then
	echo "ce programme demande deux arguments: un argument pour le chemin vers le dossier itrameur et le fichier text format ro_ukraine, ro_israel, ro_general"  
	exit
fi

echo "<lang='$URL_LANG'>" >$FOLDER/dump-$URL_LANG.txt
echo "<lang='$URL_LANG'>" >$FOLDER/contexte-$URL_LANG.txt

N=1

while read -r line;
do
	echo "<page='$URL_LANG-$N'>" >> $FOLDER/dump-$URL_LANG.txt
	echo "<page='$URL_LANG-$N'>" >> $FOLDER/contexte-$URL_LANG.txt
	echo "<text>" >> $FOLDER/dump-$URL_LANG.txt
	echo "<text>" >> $FOLDER/contexte-$URL_LANG.txt
	cat ../dumps-text/dump_${URL_LANG}_$N.txt | sed "s|&|&amp;|g" | sed "s|<|&lt;|g" | sed "s|>|&gt;|g" >> $FOLDER/dump-$URL_LANG.txt
	cat ../contexte/contexte_${URL_LANG}_$N.txt | sed "s|&|&amp;|g" | sed "s|<|&lt;|g" | sed "s|>|&gt;|g" >> $FOLDER/contexte-$URL_LANG.txt
	echo "</text>" >> $FOLDER/dump-$URL_LANG.txt
	echo "</text>" >> $FOLDER/contexte-$URL_LANG.txt
	echo "</page>§" >> $FOLDER/dump-$URL_LANG.txt
	echo "</page>§" >> $FOLDER/contexte-$URL_LANG.txt
	N=$(expr $N + 1)
done < $URL_FILE

echo "</lang>" >> $FOLDER/dump-$URL_LANG.txt
echo "</lang>" >> $FOLDER/contexte-$URL_LANG.txt