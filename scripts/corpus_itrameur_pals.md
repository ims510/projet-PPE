---
layout: page
id: corpus_itrameur_pals.md
---

Pour pouvoir utiliser les outils comme iTrameur ou le script PALS, il a fallu adapter les textes pour qu'ils soient dans le format reconnu par ces outils. 

Dans le cas d'iTrameur, il a fallu ajouter des balises à la fin et au debut de chaque dump textuel. POur ce qui est du script PALS, il a fallu structurer le texte pour avoir un mot par ligne et une ligne vide entre chaque phrase.

Voici les scripts utilisés :

### Script pour la creation du corpus iTrameur:

```
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
```

### Script pour la creation du corpus PALS:

```
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
```