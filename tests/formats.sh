#! /bin/sh


HERE=$(cd "$(dirname "$0")" && pwd)
PATH="$HERE/..:$PATH"

rm -fr source dest
mkdir -p source dest

make-img.sh source/image1.png
make-img.sh source/image2.jpg
make-img.sh source/image3.png
make-img.sh source/image1.JPEG
make-img.sh source/image2.JPG
make-img.sh source/image3.jpeg


galerie-shell.sh --source source --dest dest

if [ -f dest/index.html ]
then
    echo "Now run 'firefox dest/index.html' to check the result"
else
    echo "ERROR: dest/index.html was not generated"
fi
