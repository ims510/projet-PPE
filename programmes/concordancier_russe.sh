#!/usr/bin/env bash


INPUT_PATH=$1
OUTPUT_PATH=$2

WORD_REGEX="[Вв]ойн((а)|(ы)|(у)|(ой)|(е)|(ам)|(ами)|(ах))?"

echo "<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Concordances</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
  </head>

  <body>
    <h1 class="title is-1">Tableau d'URLs</h1>
    <table class="table is-striped is-hoverable is-fullwidth">
      <thead>
        <tr><th>Contexte gauche</th><th>Mot</th><th>Contexte droit</th></tr>
      </thead>
      <tbody>" > "$OUTPUT_PATH"

CONCORDANCE_TABLE=$(cat $INPUT_PATH | sed '/^$/d'| egrep $WORD_REGEX | sed -E "s~(.*)($WORD_REGEX)(.*)~<tr><td>\1</td><td>\2</td><td>\9</td></tr>~g")

echo "$CONCORDANCE_TABLE" >> "$OUTPUT_PATH"

echo "      </tbody>
    </table>
  </body>
</html>" >> "$OUTPUT_PATH"


#sed "s|<!--Table-->|$CONCORDANCE_TABLE|g" concordances_template_roumain.html > "$OUTPUT_PATH"




