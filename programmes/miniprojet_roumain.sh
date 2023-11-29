#!/usr/bin/env bash

FILE_PATH_IN=$1
FILE_PATH_OUT=$2

if [ $# -ne 2 ] # verifier si le script a un argument
then
	echo "ce programme demande deux arguments: le chemin vers le fichier ro.txt et un argument pour le chemin vers le fichier html" 
	exit
fi

N=1
TABLE=""
while read -r line;
do
	ASPIRATION=$(curl -s -L ${line} > ../aspirations/url_ro_$N.html)
	DUMP=$(lynx -dump -nolist --display_charset=utf-8 ../aspirations/url_ro_$N.html > ../dumps-text/dump_ro_$N.txt)
	WORDCOUNT=$(cat ../dumps-text/dump_ro_$N.txt | egrep -o "[Rr]ăzbo((iul)|(iului)|(aiele)|(aie)|(aielor)|i)"| wc -w)
	cat ../dumps-text/dump_ro_$N.txt | sed '/^$/d'| egrep -C 1 "[Rr]ăzbo((iul)|(iului)|(aiele)|(aie)|(aielor)|i)" > ../contexte/contexte_ro_$N.txt
	./concordancier_roumain.sh dump_ro_$N.txt ../tableaux/concordances_roumain_$N.html
	#obtenir le code HTTP and store it in a variable 
	CURL=$(curl -s -I -L ${line} | tr -d "\r" ) #obtenir les headers
	HTTPCODE=$(echo "$CURL" | grep "^HTTP" | egrep -o "[[:digit:]]{3}" | tail -n 1)
	ENCODING=$(echo "$CURL" | grep "^content-type:" | egrep -o "charset=[^;]*" | cut -f 2 -d =)
	TABLEROW="<tr><td>$N</td>
				  <td>$HTTPCODE</td>
				  <td><a href=${line}>${line}</a></td>
				  <td>$ENCODING</td>
				  <td><a href="../aspirations/url_ro_$N.html">aspiration</a></td>
				  <td><a href="../dumps-text/dump_ro_$N.txt">dump</a></td>
				  <td>$WORDCOUNT</td>
				  <td><a href="../contexte/contexte_ro_$N.txt">contexte</a></td>
				  <td><a href="../tableaux/concordances_roumain_$N.html">concordances</a></td>
				  </tr>"
	TABLE+="$TABLEROW\n"
	N=$(expr $N + 1)
done < "$FILE_PATH_IN"

sed "s|<!-- Table -->|$TABLE|g" template_roumain.html > "$FILE_PATH_OUT"
