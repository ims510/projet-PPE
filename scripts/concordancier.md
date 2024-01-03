---
layout: page
id: concordancier.md
---

Pour obtenir les contextes droits et gauches de chaque repetition du mot cible dans chacune des pages aspirées et dans les 3 langues, nous avons utilisé les scripts suivants :

## Concordancier anglais

```
#!/usr/bin/env bash


INPUT_PATH=$1
OUTPUT_PATH=$2

WORD_REGEX="(wars?)|(WARS?)|(Wars?)"

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

CONCORDANCE_TABLE=$(cat $INPUT_PATH | sed '/^$/d'| egrep $WORD_REGEX | sed -E "s~(.*)($WORD_REGEX)(.*)~<tr><td>\1</td><td>\2</td><td>\6</td></tr>~g")
#1 = .*, 2 = WORD_</tr>REGEX (ici trois groupes), 5 = suite.

echo "$CONCORDANCE_TABLE" >> "$OUTPUT_PATH"

echo "      </tbody>
    </table>
  </body>
</html>" >> "$OUTPUT_PATH"

```
## Concordancier roumain

```
#!/usr/bin/env bash


INPUT_PATH=$1
OUTPUT_PATH=$2

WORD_REGEX="[Rr]ăzbo((iul)|(iului)|(aiele)|(aie)|(aielor)|i)"

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

```
## Concordancier russe

```
#!/usr/bin/env bash


INPUT_PATH=$1
OUTPUT_PATH=$2

WORD_REGEX="[Вв]ойн((ам?и?х?)|(ы)|(у)|(ой)|(е))?"

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
```

