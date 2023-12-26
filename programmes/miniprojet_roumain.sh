#!/usr/bin/env bash

FILE_PATH_IN_UKRAINE=$1
FILE_PATH_IN_ISRAEL=$2
FILE_PATH_IN_GENERAL=$3
FILE_PATH_OUT=$4

if [ $# -ne 4 ]; then
    echo "This script requires four arguments: paths to the files ro_ukraine.txt, ro_israel.txt, ro_general.txt, and the output HTML file."
    exit 1
fi

process_file() {
    local FILE_PATH=$1
    local TABLE=""
    local TYPE=$2
    local N=1

    while read -r line; 
    do
        echo "Processing link $N for $FILE_PATH..."
        ASPIRATION=$(curl -s -L "${line}" > ../aspirations/url_ro_${TYPE}_$N.html)
        DUMP=$(links -dump ../aspirations/url_ro_${TYPE}_$N.html > ../dumps-text/dump_ro_${TYPE}_$N.txt)
        WORDCOUNT=$(cat ../dumps-text/dump_ro_${TYPE}_$N.txt | egrep -o "[Rr]ăzbo((iul)|(iului)|(aiele)|(aie)|(aielor)|i)"| wc -w)
        cat ../dumps-text/dump_ro_${TYPE}_$N.txt | sed '/^$/d'| egrep -C 1 "[Rr]ăzbo((iul)|(iului)|(aiele)|(aie)|(aielor)|i)" > ../contexte/contexte_ro_${TYPE}_$N.txt
        ./concordancier_roumain.sh ../dumps-text/dump_ro_${TYPE}_$N.txt ../tableaux/concordances_roumain_${TYPE}_$N.html
        #obtenir le code HTTP and store it in a variable 
        CURL=$(curl -s -I -L "${line}" | tr -d "\r" ) #obtenir les headers
        HTTPCODE=$(echo "$CURL" | grep "^HTTP" | egrep -o "[[:digit:]]{3}" | tail -n 1)
        ENCODING=$(echo "$CURL" | grep "^content-type:" | egrep -o "charset=[^;]*" | cut -f 2 -d =)

        TABLEROW="<tr><td>$N</td>\n"
        TABLEROW+="<td>$HTTPCODE</td>\n"
        TABLEROW+="<td><a href=\"${line}\">${line}</a></td>\n"
        TABLEROW+="<td>$ENCODING</td>\n"
        TABLEROW+="<td><a href=\"../aspirations/url_ro_${TYPE}_$N.html\">aspiration</a></td>\n"
        TABLEROW+="<td><a href=\"../dumps-text/dump_ro_${TYPE}_$N.txt\">dump</a></td>\n"
        TABLEROW+="<td>$WORDCOUNT</td>\n"
        TABLEROW+="<td><a href=\"../contexte/contexte_ro_${TYPE}_$N.txt\">contexte</a></td>\n"
        TABLEROW+="<td><a href=\"../tableaux/concordances_roumain_${TYPE}_$N.html\">concordances</a></td>\n"
        TABLEROW+="</tr>"
        TABLE+="$TABLEROW\n"

        N=$((N + 1))
    done < "$FILE_PATH"

    # Replace the placeholder in the HTML template using awk
    awk -v table="$TABLE" '/<!-- Table '"$TYPE"' -->/{print table; next} 1' "$FILE_PATH_OUT" > "$FILE_PATH_OUT.tmp"
    mv "$FILE_PATH_OUT.tmp" "$FILE_PATH_OUT"
}


generate_file() {
    cat template_roumain.html > "$FILE_PATH_OUT"
}

# Process each file separately
generate_file
process_file "$FILE_PATH_IN_UKRAINE" "ukraine"
process_file "$FILE_PATH_IN_ISRAEL" "israel"
process_file "$FILE_PATH_IN_GENERAL" "general"
