#! /bin/sh

. ./utilities.sh

cd "$1"

html_head "Galerie"
html_title "Galerie"

for f in *.inc ;do
    cat "$f"
done

html_tail