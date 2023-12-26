#!/usr/bin/env bash

FILE_PATH_IN_UKRAINE=$1 #/home/karmin/Documents/ppe_projet/projet-PPE/projet-PPE/urls/en_ukraine.txt
FILE_PATH_IN_ISRAEL=$2 #/home/karmin/Documents/ppe_projet/projet-PPE/projet-PPE/urls/en_israel.txt
FILE_PATH_IN_GENERAL=$3 #/home/karmin/Documents/ppe_projet/projet-PPE/projet-PPE/urls/en_general.txt
FILE_PATH_OUT=$4 #/home/karmin/Documents/ppe_projet/projet-PPE/projet-PPE/tableaux/tableau_anglais.html

if [ $# -ne 4 ]; then
    echo "Ce script nécessite 4 arguments : les chemins vers en_ukraine.txt, en_israel.txt, en_general.txt, et le fichier HTML en output"
    exit 1
fi

process_file() {
    local FILE_PATH=$1
    local TABLE=""
    local TYPE=$2
    local N=1

	while read -r line;
	do
		echo "Manipulation lien ${N} pour $FILE_PATH..."
		ASPIRATION=$(curl -s -L ${line} > ../aspirations/url_en_${TYPE}_$N.html)
		DUMP=$(links -dump ../aspirations/url_en_${TYPE}_$N.html > ../dumps-text/dump_en_${TYPE}_$N.txt)
		WORDCOUNT=$(cat ../dumps-text/dump_en_${TYPE}_$N.txt | egrep -o "(W|w)ars?"| wc -w)
		cat ../dumps-text/dump_en_${TYPE}_$N.txt | sed '/^$/d'| egrep -C 1 "(W|w)ars?" > ../contexte/contexte_en_${TYPE}_$N.txt
		./concordancier_anglais.sh ../dumps-text/dump_en_${TYPE}_$N.txt ../tableaux/concordances_anglais_${TYPE}_$N.html
		#obtenir le code HTTP and store it in a variable
		CURL=$(curl -s -I -L "${line}" | tr -d "\r" ) #obtenir les headers
		HTTPCODE=$(echo "$CURL" | grep "^HTTP" | egrep -o "[[:digit:]]{3}" | tail -n 1)
		ENCODING=$(echo "$CURL" | grep "^content-type:" | egrep -o "charset=[^;]*" | cut -f 2 -d =)

		TABLEROW="<tr><td>$N</td>\n"
		TABLEROW+="<td>$HTTPCODE</td>\n"
		TABLEROW+="<td><a href=\"${line}\">${line}</a></td>\n"
		TABLEROW+="<td>$ENCODING</td>\n"
		TABLEROW+="<td><a href=\"../aspirations/url_en_${TYPE}_$N.html\">aspiration</a></td>\n"
		TABLEROW+="<td><a href=\"../dumps-text/dump_en_${TYPE}_$N.txt\">dump</a></td>\n"
		TABLEROW+="<td>$WORDCOUNT</td>\n"
		TABLEROW+="<td><a href=\"../contexte/contexte_en_${TYPE}_$N.txt\">contexte</a></td>\n"
		TABLEROW+="<td><a href=\"../tableaux/concordances_anglais_${TYPE}_$N.html\">concordances</a></td>\n"
		TABLEROW+="</tr>"
		TABLE+="$TABLEROW\n"

		N=$((N + 1))
	done < "$FILE_PATH"

	 # Replace the placeholder in the HTML template using awk
    awk -v table="$TABLE" '/<!-- Table '"$TYPE"' -->/{print table; next} 1' "$FILE_PATH_OUT" > "$FILE_PATH_OUT.tmp"
    mv "$FILE_PATH_OUT.tmp" "$FILE_PATH_OUT"
}


generate_file() {
    cat template_anglais.html > "$FILE_PATH_OUT"
}

# Process each file separately
generate_file
process_file "$FILE_PATH_IN_UKRAINE" "Ukraine"
process_file "$FILE_PATH_IN_ISRAEL" "Israel"
process_file "$FILE_PATH_IN_GENERAL" "General"


