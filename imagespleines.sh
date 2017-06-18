#! /bin/sh

DIR=$(cd "$(dirname "$0")" && pwd)
. "$DIR"/utilities.sh

html_head  "$(basename "$1")" 
html_title "$(basename "$1")"
echo "<div class=\"imgframe\">
<img class=\"image\" src=\""$1"\" alt="$(basename "$1")">
</div>"

html_tail 


