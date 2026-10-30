#!/bin/sh

categoria="$1"
archivio="$2"

cd "$archivio"

# mese.txt : numero contenuti , categoria 
# log : numero contenuti , mese

occorenze=0
numeroContenuti=0
max_count=0
for i in *.txt
do 
    if test -f "$i" -a -r "$i"
    then 
        occorenze=$(grep -c "$categoria" "$i")

        if test "$occorenze" -gt 0
        then 
            numeroContenuti=$(grep "$categoria" "$i" | cut -f 1 -d " ")
            echo "$numeroContenuti" >> "$LOG"
            echo $(echo "$i" | cut -f 1 -d ".") >> "$LOG"
        fi

        max_count=$(sort -n "$i" | tail -n 1 | cut -f 1 -d " ")
        if test "$max_count" -gt $(cat "$MAX_COUNT")
        then 
            echo "$max_count" > "$MAX_COUNT"
            max_cat=$(sort -n "$i" | tail -n 1 | cut -f 2 -d " ")
            echo "$max_cat" > "$MAX_NAME"
        fi
    fi
done

for d in *
do 
    if test -d "$d" -a -x "$d"
    then 
        social_ric.sh "$categoria" "$d" 
    fi
done