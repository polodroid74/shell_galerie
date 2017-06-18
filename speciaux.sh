#! /bin/sh

chaine=$(echo "$(basename "$1")" | sed "s/\"/\&quot;/g")
chaine=$(echo "$chaine" | sed "s/>/\&gt;/g")   #encodage caractères spéciaux pour html
chaine=$(echo "$chaine" | sed "s/</\&lt;/g")
# Le caractère dont le codage correpsond à &lt (par exemple) est un "<" mais non reconnu comme spécial en html: c'est un simple caractère texte. Ainsi, on ne génère pas d'erreurs dans la page HTML

chaine=$(echo "$chaine" | sed "s/#/%23/g")   #encodage des caractères spéciaux pour l'URL
chaine=$(echo "$chaine" | sed "s/?/%3F/g")
echo "$chaine"

#De même, les caractères "#" et "?" étant spéciaux dans une adresse URL (ici le chemin des images), on les remplace par les mêmes caractères mais non spéciaux.