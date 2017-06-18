#! /bin/sh


HERE=$(cd "$(dirname "$0")" && pwd)
PATH="$HERE/..:$PATH"


rm -fr source dest
mkdir -p source dest

make-img.sh source/aaa.jpg
make-img.sh source/bbb.jpg
make-img.sh source/ccc.jpg

cd ..

galerie-shell.sh --source ./tests/source --dest ./tests/dest #chemins relatifs

cd ./tests

if [ -f dest/index.html ]
then
    echo "Now run 'firefox dest/index.html' to check the result"
else
    echo "ERROR: dest/index.html was not generated"
fi
