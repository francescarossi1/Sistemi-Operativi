#!/bin/sh

# Francesca Rossi 211964

cartella="$1"
shift 
id_libro="$1"
shift 

cd "$cartella" 

for f in *.bib 
do
    if test -f "$f" -a -r "$f" 
    then
        grep "$id_libro" "$f" | cut -d "-" -f2,3 >> "$LOG"

       tot_righe=`wc -l < "$f"`
        max_attuale=`cat "$MAX_COUNT"` 

        if test "$tot_righe" -gt "$max_attuale"
        then 
            echo "$tot_righe" > "$MAX_COUNT" 
            echo "$f" > "$MAX_SEZIONE" 
        fi

    fi

done

for d in *
do 
    if test -d "$d" -a -x "$d"
    then 
        biblioteca_ric.sh "$d" "$id_libro"
    fi 
done