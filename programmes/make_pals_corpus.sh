#!/usr/bin/env bash

FOLDER=$1
URL=$2
URL_FILE="../urls/$URL.txt"

if [ $# -ne 2 ] # verifier si le script a un argument
then
	echo "ce programme demande deux arguments: un argument pour le chemin vers le dossier itrameur et le fichier text format ro_ukraine, ro_israel, ro_general" 
	exit
fi

N=1
#supprimer les fichier avant de commencer, pour ne pas avoir les memes fichier plusieurs fois si on execute le script de nouveau
echo "" > $FOLDER/dump-pals-$URL.txt
echo "" > $FOLDER/contexte-pals-$URL.txt

while read -r line;
do
	cat ../dumps-text/dump_${URL}_$N.txt | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" >> $FOLDER/dump-pals-$URL.txt
	cat ../contexte/contexte_${URL}_$N.txt | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" >> $FOLDER/contexte-pals-$URL.txt
	N=$(expr $N + 1)
done < $URL_FILE
