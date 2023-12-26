#!/usr/bin/env bash


FILE_PATH_IN=$1 #/home/karmin/Documents/ppe_projet/projet-PPE/projet-PPE/urls/en.txt
FILE_PATH_OUT=$2 #/home/karmin/Documents/ppe_projet/projet-PPE/projet-PPE/tableaux/tableau_anglais.html

if [ $# -ne 2 ] # verifier si le script a un argument
then
	echo "ce programme demande deux arguments: le chemin vers le fichier en.txt et un argument pour le chemin vers le fichier html"
	exit
fi

N=1
TABLE=""
while read -r line;
do
	echo "Manipulation lien ${N} ${line}"
	ASPIRATION=$(curl -s -L ${line} > ../aspirations/url_en_$N.html)
	DUMP=$(links -dump ../aspirations/url_en_$N.html > ../dumps-text/dump_en_$N.txt)
	WORDCOUNT=$(cat ../dumps-text/dump_en_$N.txt | egrep -o "(W|w)ars?"| wc -w)
	cat ../dumps-text/dump_en_$N.txt | sed '/^$/d'| egrep -C 1 "(W|w)ars?" > ../contexte/contexte_en_$N.txt
	./concordancier_anglais.sh ../dumps-text/dump_en_$N.txt ../tableaux/concordances_anglais_$N.html
	#obtenir le code HTTP and store it in a variable
	CURL=$(curl -s -I -L ${line} | tr -d "\r" ) #obtenir les headers
	HTTPCODE=$(echo "$CURL" | grep "^HTTP" | egrep -o "[[:digit:]]{3}" | tail -n 1)
	ENCODING=$(echo "$CURL" | grep "^content-type:" | egrep -o "charset=[^;]*" | cut -f 2 -d =)
	TABLEROW="<tr><td>$N</td>\n"
	TABLEROW+="<td>$HTTPCODE</td>\n"
	TABLEROW+="<td><a href=${line}>${line}</a></td>\n"
	TABLEROW+="<td>$ENCODING</td>\n"
	TABLEROW+="<td><a href="../aspirations/url_en_$N.html">aspiration</a></td>\n"
	TABLEROW+="<td><a href="../dumps-text/dump_en_$N.txt">dump</a></td>\n"
	TABLEROW+="<td>$WORDCOUNT</td>\n"
	TABLEROW+="<td><a href="../contexte/contexte_en_$N.txt">contexte</a></td>\n"
	TABLEROW+="<td><a href="../tableaux/concordances_anglais_$N.html">concordances</a></td>\n"
	TABLEROW+="</tr>"
	TABLE+="$TABLEROW\n"
	N=$(expr $N + 1)
done < "$FILE_PATH_IN"

sed "s|<!-- Table -->|$TABLE|g" template_anglais.html > "$FILE_PATH_OUT"

