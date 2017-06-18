#!/bin/sh

html_head () {
    echo "<html>"
    echo "<head>" 
    echo "<title><$1></title>"
    echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
<style type=\"text/css\">
body {
    background-color: #000000;
}

.imgframe {
    float: left;
    background-color: #00FF00;
    border: dashed 1px #BBDDBB;
    margin: 1ex;
    padding: 1ex;
    text-align:center;
}

.image {
    margin: 1ex;
    border: solid 1px lightgrey;
}

.legend {
    font-style:italic;
    color: #002000;
}
</style>"

    echo "</head>" 
    echo "<body>" 

}

html_title () {
    echo "<FONT color=#00FF00><h1 align=center>"$1"</h1></FONT>
<br>" 
}

html_tail () {
    echo "</body>" 
    echo "</html>"
    
}


mode_verbe () {

    if [ "$1" = "--verb" ]; then

	if [ "$2" = "cd" ]; then
	    echo "navigation vers le dossier $(basename $3)" 

	elif [ "$2" = "cp" ]; then
	    echo "copie du fichier $3 de $(basename $4) vers $(basename $5)"

	elif [ "$2" = "convert" ]; then
	    echo "conversion au format 200*200 du fichier $(basename $3)"

	elif [ "$2" = "touch" ]; then
	    echo "création du fichier $3" 

	elif [ "$2" = "exec" ]; then
	    echo "redirection de l'entrée standard vers $3"

	elif [ "$2" = "image" ]; then
	    echo "Création de la vignette pour l'image $(basename $3)" 

	elif [ "$2" = "imagepleine" ]; then
	    echo "Création de la page html pour l'image $(basename $3)" 
	fi
    fi
}
