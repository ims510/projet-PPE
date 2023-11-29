#!/usr/bin/env bash


FILE_PATH_IN=$1 #/home/karmin/Documents/ppe_projet/projet-PPE/projet-PPE/urls/ru.txt
FILE_PATH_OUT=$2 #/home/karmin/Documents/ppe_projet/projet-PPE/projet-PPE/tableaux/tableau_ru.html

if [ $# -ne 2 ] # verifier si le script a un argument
then
	echo "ce programme demande deux arguments: le chemin vers le fichier ru.txt et un argument pour le chemin vers le fichier html"
	exit
fi

N=1
TABLE=""
while read -r line;
do
	ASPIRATION=$(curl -s -L ${line} > ../aspirations/url_ru_$N.html)
	DUMP=$(lynx -dump -nolist --display_charset=utf-8 ../aspirations/url_ru_$N.html > ../dumps-text/dump_ru_$N.txt)
	WORDCOUNT=$(cat ../dumps-text/dump_ru_$N.txt | egrep -o "[Вв]ойн((а)|(ы)|(у)|(ой)|(е)|(ам)|(ами)|(ах))?"| wc -w)
	cat ../dumps-text/dump_ru_$N.txt | sed '/^$/d'| egrep -C 1 "[Вв]ойн((а)|(ы)|(у)|(ой)|(е)|(ам)|(ами)|(ах))?" > ../contexte/contexte_ru_$N.txt
	#obtenir le code HTTP and store it in a variable
	CURL=$(curl -s -I -L ${line} | tr -d "\r" ) #obtenir les headers
	HTTPCODE=$(echo "$CURL" | grep "^HTTP" | egrep -o "[[:digit:]]{3}" | tail -n 1)
	ENCODING=$(echo "$CURL" | grep "^content-type:" | egrep -o "charset=[^;]*" | cut -f 2 -d =)
	TABLEROW="<tr><td>$N</td><td>$HTTPCODE</td><td><a href=${line}>${line}</a></td><td>$ENCODING</td><td><a href="../aspirations/url_ru_$N.html">aspiration</a></td><td><a href="../dumps-text/dump_ru_$N.txt">dump</a></td><td>$WORDCOUNT</td><td><a href="../contexte/contexte_ru_$N.txt">contexte</a></td></tr>"
	TABLE+="$TABLEROW\n"
	N=$(expr $N + 1)
done < "$FILE_PATH_IN"

sed "s|<!-- Table -->|$TABLE|g" template_russe.html > "$FILE_PATH_OUT"

