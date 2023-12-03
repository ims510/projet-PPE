#!/usr/bin/env bash

FOLDER=$1
LANG=$2
URL_FILE="../urls/$LANG.txt"

if [ $# -ne 2 ] # verifier si le script a un argument
then
	echo "ce programme demande deux arguments: un argument pour le chemin vers le dossier itrameur et la langue (version courte)" 
	exit
fi

N=1

while read -r line;
do
	cat ../dumps-text/dump_${LANG}_$N.txt | tr -cs "[:alpha:].ĂăÂâÎîȘșȚț" "\n" | sed "s/\./\n/g" >> $FOLDER/dump-pals-$LANG.txt
	cat ../contexte/contexte_${LANG}_$N.txt | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" >> $FOLDER/contexte-pals-$LANG.txt
	N=$(expr $N + 1)
done < $URL_FILE
