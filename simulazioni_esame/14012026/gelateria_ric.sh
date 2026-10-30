#!/bin/sh

dir="$1"
shift
id_cliente="$1"
shift

cd "$dir"

for f in *.gel
do
    if test -f "$f"
    then 
        `grep "$id_cliente" "$f" | cut -d "-" -f2,3 >> "$LOG"`

        ordini_cliente=`grep -c "$id_cliente" "$f"`
        max_attuale=`cat "$MAX_COUNT"`

        if test "$ordini_cliente" -gt "$max_attuale"
        then 
            sede=`echo "$f" | cut -d "." -f1`
            echo "$ordini_cliente" > "$MAX_COUNT"
            echo "$sede" > "$MAX_SEDE"
        fi
    fi
done

for d in *
do 
    if test -d "$d" -a -x "$d"
    then    
        gelateria_ric.sh "$d" "$id_cliente"
    fi
done