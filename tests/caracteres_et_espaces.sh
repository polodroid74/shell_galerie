#! /bin/sh


HERE=$(cd "$(dirname "$0")" && pwd)
PATH="$HERE/..:$PATH"

rm -fr source dest
mkdir -p source dest

make-img.sh source/\".jpg
make-img.sh source/!.jpg
make-img.sh source/"aaa aaa".jpg
make-img.sh source/"<head>".jpg  #test insertion de balises html dans les noms
make-img.sh source/"\****".jpg
make-img.sh source/"#".jpg  # # est un caractère spécial pour l'URL
make-img.sh source/"¤$£ù%*µ!§ï~\"'{".jpg 
make-img.sh source/"²&+-*^,0123456789".jpg
make-img.sh source/"a.jpeg.JPEG.JPG".jpg   

galerie-shell.sh --source source --dest dest

if [ -f dest/index.html ]
then
    firefox ./dest/index.html &
else
    echo "ERROR: dest/index.html was not generated"
fi
