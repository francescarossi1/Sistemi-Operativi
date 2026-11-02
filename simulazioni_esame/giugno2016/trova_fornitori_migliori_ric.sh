#!/bin/sh

dir="$1"
shift 
cod_parte="$1"
shift
num="$1"
shift 

cd "$dir"

for f in *.txt 
do 
    if test -f "$f" -a -r "$f"
    then 
       salva=`grep -w "$cod_parte" "$f" | cut -d "," -f4`
        if test -n "$salva"
        then
            if test "$salva" -gt `cat "$MAX_COUNT"`
            then 
                echo "$salva" > "$MAX_COUNT"

                fornitore=`echo "$f" | cut -d "." -f1`
                echo "$fornitore" > "$MAX_FORNITORE"
            fi
        fi
    fi
done

for d in *
do 
    if test -d "$d" -a -x "$d" 
    then 
        trova_fornitori_migliori_ric.sh "$d" "$cod_parte" "$num"
    fi
done 