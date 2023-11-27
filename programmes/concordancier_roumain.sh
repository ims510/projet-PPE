#!/usr/bin/env bash


INPUT_PATH=$1
OUTPUT_PATH=$2

WORD_REGEX="[Rr]ăzbo((iul)|(iui)|(aiele)|(aie)|(aielor)|i)"


CONCORDANCE_TABLE=$(cat $INPUT_PATH | sed '/^$/d'| egrep $WORD_REGEX | sed -E "s~(.*)($WORD_REGEX)(.*)~<tr><td>\1</td><td>\2</td><td>\9</td></tr>~g")

echo "$CONCORDANCE_TABLE"
sed "s|<!-- Table -->|$CONCORDANCE_TABLE|g" concordances_template_roumain.html > "$OUTPUT_PATH"




