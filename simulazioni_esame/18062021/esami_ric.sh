#!/bin/sh

genere="$1"
shift 
tipo="$1"
shift 
anno="$1"
shift 

cd "$anno"

for f in *.txt
do
    if test -f "$f" -a -r "$f"
    then
        grep "$genere" "$f" | grep "$tipo" | cut -d "," -f1,3,6 >> "$risultati"

        numero=`grep "$genere" "$f" | grep "$tipo" | wc -l`
        max_attuale=`cat "$max"`

        if test "$numero" -gt "$max_attuale"
        then
            echo "$numero" > "$max"
            echo "$f" | cut -d "." -f1 > "$mese_max"
        fi
    fi
done

for d in *
do 
    if test -d "$d" -a -x "$d"
    then 
        esami_ric.sh "$genere" "$tipo" "$d"
    fi 
done