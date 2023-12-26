---
layout: page
id: creation_tableaux.md
---

Pour obtenir les tableaux qui se trouvent [ici](../tableaux) on a utilisé les scripts bash suivants pour les 3 langues. Ensuite, on a mis les resultats de ces scripts dans un template html, pour que tout s'affiche sous la forme d'une page web. 


## Creation tableaux anglais

```
#!/usr/bin/env bash

FILE_PATH_IN_UKRAINE=$1 
FILE_PATH_IN_ISRAEL=$2 
FILE_PATH_IN_GENERAL=$3 
FILE_PATH_OUT=$4 

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
process_file "$FILE_PATH_IN_UKRAINE" "ukraine"
process_file "$FILE_PATH_IN_ISRAEL" "israel"
process_file "$FILE_PATH_IN_GENERAL" "general"

```

## Creation tableaux roumain

```
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

```

## Creation tableaux russe

```
#!/usr/bin/env bash

FILE_PATH_IN_UKRAINE=$1 
FILE_PATH_IN_ISRAEL=$2 
FILE_PATH_IN_GENERAL=$3 
FILE_PATH_OUT=$4 

if [ $# -ne 4 ]; then
    echo "Ce script nécessite 4 arguments : les chemins vers ru_ukraine.txt, ru_israel.txt, ru_general.txt, et le fichier HTML en output"
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
		ASPIRATION=$(curl -s -L ${line} > ../aspirations/url_ru_${TYPE}_$N.html)
		DUMP=$(links -dump ../aspirations/url_ru_${TYPE}_$N.html > ../dumps-text/dump_ru_${TYPE}_$N.txt)
		WORDCOUNT=$(cat ../dumps-text/dump_ru_${TYPE}_$N.txt | egrep -o "[Вв]ойн((ам?и?х?)|(ы)|(у)|(ой)|(е))?"| wc -w)
		cat ../dumps-text/dump_ru_${TYPE}_$N.txt | sed '/^$/d'| egrep -C 1 "[Вв]ойн((ам?и?х?)|(ы)|(у)|(ой)|(е))?" > ../contexte/contexte_ru_${TYPE}_$N.txt
		./concordancier_russe.sh ../dumps-text/dump_ru_${TYPE}_$N.txt ../tableaux/concordances_russe_${TYPE}_$N.html
		#obtenir le code HTTP and store it in a variable
		CURL=$(curl -s -I -L "${line}" | tr -d "\r" ) #obtenir les headers
		HTTPCODE=$(echo "$CURL" | grep "^HTTP" | egrep -o "[[:digit:]]{3}" | tail -n 1)
		ENCODING=$(echo "$CURL" | grep "^content-type:" | egrep -o "charset=[^;]*" | cut -f 2 -d =)

		TABLEROW="<tr><td>$N</td>\n"
		TABLEROW+="<td>$HTTPCODE</td>\n"
		TABLEROW+="<td><a href=\"${line}\">${line}</a></td>\n"
		TABLEROW+="<td>$ENCODING</td>\n"
		TABLEROW+="<td><a href=\"../aspirations/url_ru_${TYPE}_$N.html\">aspiration</a></td>\n"
		TABLEROW+="<td><a href=\"../dumps-text/dump_ru_${TYPE}_$N.txt\">dump</a></td>\n"
		TABLEROW+="<td>$WORDCOUNT</td>\n"
		TABLEROW+="<td><a href=\"../contexte/contexte_ru_${TYPE}_$N.txt\">contexte</a></td>\n"
		TABLEROW+="<td><a href=\"../tableaux/concordances_russe_${TYPE}_$N.html\">concordances</a></td>\n"
		TABLEROW+="</tr>"
		TABLE+="$TABLEROW\n"

		N=$((N + 1))
	done < "$FILE_PATH"

	# Replace the placeholder in the HTML template using awk
    awk -v table="$TABLE" '/<!-- Table '"$TYPE"' -->/{print table; next} 1' "$FILE_PATH_OUT" > "$FILE_PATH_OUT.tmp"
    mv "$FILE_PATH_OUT.tmp" "$FILE_PATH_OUT"
}


generate_file() {
    cat template_russe.html > "$FILE_PATH_OUT"
}

# Process each file separately
generate_file
process_file "$FILE_PATH_IN_UKRAINE" "ukraine"
process_file "$FILE_PATH_IN_ISRAEL" "israel"
process_file "$FILE_PATH_IN_GENERAL" "general"

```

## Template html

```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tableau d'URLs</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
</head>

<body>
    <section class="section">
        <div class="container">
            <nav class="breadcrumb" aria-label="breadcrumbs">
                <ul>
                    <li><a href="/projet-PPE/">Page d'accueil</a></li>
                    <li><a href="/projet-PPE/tableaux/">Tableaux</a></li>
                    <li class="is-active"><a href="#" aria-current="page">Tableau d'URLs - Roumain</a></li>
                </ul>
            </nav>
            <h1 class="title is-1">Tableau d'URLs - Roumain</h1>

            <hr> <!-- Add a horizontal line -->

            <h3 class="title is-3">Guerre en Ukraine </h3>

            <table class="table is-striped is-hoverable is-fullwidth">
                <thead>
                    <tr><th>Nombre</th><th>Code HTTP</th><th>URL</th><th>Encodage</th><th>Aspirations</th><th>Dumps</th><th>Nombre d'occurences</th><th>Contexte</th><th>Concordances</th></tr>
                </thead>
                <tbody>
                    <!-- Table ukraine -->
                </tbody>
            </table>

            <hr> <!-- Add another horizontal line -->

            <h3 class="title is-3">Guerre en Palestine</h3>
            <table class="table is-striped is-hoverable is-fullwidth">
                <thead>
                    <tr><th>Nombre</th><th>Code HTTP</th><th>URL</th><th>Encodage</th><th>Aspirations</th><th>Dumps</th><th>Nombre d'occurences</th><th>Contexte</th><th>Concordances</th></tr>
                </thead>
                <tbody>
                    <!-- Table israel -->
                </tbody>
            </table>

            <hr> <!-- Add another horizontal line -->

            <h3 class="title is-3">Général</h3>
            <table class="table is-striped is-hoverable is-fullwidth">
                <thead>
                    <tr><th>Nombre</th><th>Code HTTP</th><th>URL</th><th>Encodage</th><th>Aspirations</th><th>Dumps</th><th>Nombre d'occurences</th><th>Contexte</th><th>Concordances</th></tr>
                </thead>
                <tbody>
                    <!-- Table general -->
                </tbody>
            </table>

        </div>
    </section>
</body>
</html>

```