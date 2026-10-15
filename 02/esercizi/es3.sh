#!/bin/sh
# es.3 - file cercadir [directoryassoluta] file

# Verifica se l'utente ha specificato la directory e il file (2 arg) o solo il file (1 arg)
case $# in
    1) 
        d=`pwd`
        f=$1
        ;;
    2) 
        d=$1
        f=$2
        ;;
    *) 
        echo "errore. Usa $0 [directory] file"
        exit 2
        ;;
esac

# Spostamento nella directory richiesta
cd "$d" || exit

# Se il file cercato esiste nella directory corrente
if test -f "$f"
then
    echo "il file $f è in $d"
fi

# Ricorsione sulle sottodirectory
for i in *
do
    if test -d "$i" -a ! -h "$i"
    then
        # Chiamata ricorsiva del comando cercadir sulla sottodirectory
        cercadir "`pwd`/$i" "$f"
    fi
done