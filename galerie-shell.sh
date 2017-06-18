#! /bin/sh

DIR=$(cd "$(dirname "$0")" && pwd)  #récupération du répertoire courant du script

. "$DIR"/utilities.sh #utilisation des fonctions de utilities.sh

s=''
d=''
f=''
h=''    #initilisation des variables avec des chaînes vides. Cela permet de contrôler la validité des paramètres.
index=''
v=''

while [ $# -ne 0 ];do

    case   "$1" in

	"--source")
	    s="$2"
	    shift
	    ;;
	"--dest")    #récupération des arguments
	    d="$2"
	    shift
	    ;;
	"--force")
	    force="force"
	    ;;
	"--help")
	    h="help"
	    ;;
	"--index")
	    index="$2"
	    shift
	    ;;
	"--verb")
	    v="$1"
	    ;;
    esac
    shift
done

if [ "$s" = '' ] || [ "$d" = '' ]; then #Vérification que la source et la destination ont été afféctées.
    echo "arguments manquants!" 

elif [ "$h" = "help" ]; then  #affichage des options disponibles lors de l'activation du mode help.

    echo "
Options disponibles: 

--Source répertoire source 
--Dest répertoire cible
--help :affiche l'aide  
--verb mode verbeux
--force :force création miniatures
--index  FICHIER: écrit le code html dans FICHIER
"

else

    if ! [ -d "$s" ] || ! [ -d "$d" ]; then
	echo "dossiers invalides !"  #Test de la validité des chemins fournis. 
    elif [ "$s" = "$d" ]; then
	echo "Destination identique à la source!"
    else 

	s=$(cd "$s" && pwd)
	d=$(cd "$d" && pwd) #Récupération des chemins absolus.
	cd "$s" 
	mode_verbe "$v" "cd" "$s"  # Appel du sous-script mode_verb afin d'afficher la commande en cours d'execution. 

	for f in  ./* ; do
	    case "$f" in
		*.jpg | *.JPG | *.jpeg | *.JPEG) # Prise en compte des différentes extensions jpeg.

		    if [ "$force" = "force" ] || ! [ -e "$d"/"$f" ]; then # Création des vignettes ssi le mode force est actif ou si les vignettes n'existent pas.
			cp "$s"/"$f" "$d"/"$f" 
			mode_verbe "$v" "cp" "$f" "$s" "$d"          #Création des vignettes.
			convert -resize 200x200 "$d"/"$f" "$d"/"$f" 
			mode_verbe "$v" "convert" "$f" 

		    fi
		    ;;
	    esac
	done
	cd "$d"  # On se place dans le répertoire cible.

	if ! [ "$index" = '' ] ; then # Création du fichier spécifié par l'utilisateur.

	    index=$(basename "$index" .html)
	    index=$(basename "$index" .htm) #Vérification de l'extension du fichier.
	    touch "$index".html
	    file="$index".html
	    mode_verbe "$v" "touch" "$index.html" 

	else         # Création par défault du fichier index.html (si aucunne précision de l'utilisateur).
            touch index.html
            file=index.html   
	    mode_verbe "$v" "touch" "index.html" 
	fi

	mode_verbe "$v" "exec" "$file" 
	exec 1> "$file" #Redirection de la sortie standard vers le fichier html.

	html_head "Galerie"  
	html_title "Galerie"

	for f in ./* ;do
	    case "$f" in
		*.jpg | *.JPG | *.jpeg | *.JPEG) #Ne prend en compte que les fichiers jpeg du répertoire destination.
		    
		    "$DIR"/generate-img-fragment.sh "$d"/"$("$DIR"/speciaux.sh "$f")" "$DIR" "$s" #"$("$DIR"/speciaux.sh "$f") permet de détecter les caractères spéciaux et de les remplacer par leur codes html ou URL équivalent.
		    mode_verbe "$v" "image" "$d"/"$f" >&2  #Pour afficher la sortie du script dans le terminal, on redirige vers la sortie d'erreur standard (la sortie standard est affectée au fichier html).

		    "$DIR"/imagespleines.sh "$s"/"$("$DIR"/speciaux.sh "$f")"  > "$f".html
		    mode_verbe "$v" "imagepleine" "$d"/"$f" >&2
		    ;;
	    esac
	done
	html_tail
    fi
fi



