#!/bin/sh


echo "<a href=\""$1".html \">
<div class=\"imgframe\">
<img class=\"image\" src=\""$1"\" alt="$(basename "$1")"><br>
<span class=\"legend\">\""$(basename "$1")"<br>"$("$2"/exiftags  "$3"/$(basename "$1") 2>/dev/null | grep 'Created')"\"</span>
</div>
</a>"

# $3 contient le chemin vers les images du dossier source. Ainsi, lors de l'appel de exiftags dans le makefile, les informatations  sont colléctées sur les fichiers sources et non sur les fichiers cibles qui ne sont pas encore créés.
