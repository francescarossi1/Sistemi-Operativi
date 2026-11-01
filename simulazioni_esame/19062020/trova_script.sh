#!/bin/sh

if test $# -ne 1
then
    echo "Uso: $0 dir"
    exit 1
fi

case "$1" in
    /*) ;;
    *) echo "Errore: serve un nome assoluto di directory"
       exit 2 ;;
esac

if test ! -d "$1" -o ! -x "$1"
then
    echo "Errore: directory inesistente o non attraversabile"
    exit 3
fi

PATH=$PATH:`pwd`
export PATH

script="$HOME/script.txt"
touch "$script"

MAX=/tmp/max$$
DIR_MAX=/tmp/dirmax$$
echo 0 > "$MAX"
> "$DIR_MAX"

export script MAX DIR_MAX

trova_script_ric.sh "$1"

cat "$DIR_MAX"

rm -f "$MAX" "$DIR_MAX"