#!/bin/sh

nome="$1"
shift 
anno="$1"
shift

cd "$anno"

for f in *.txt
do
    if test -f "$f" -a -r "$f"
    then 
        echo "`grep "$nome" "$f" | cut -d "," -f1,3,5`" >> "$LOG" //tutte le righe del fiume

        num=`grep "$nome" "$f" | cut -d "," -f1 | sort -n | tail -n 1 | head -n 1`

        if test -n "$num"
        then
            min_att=`cat "$MIN_CORSO"`
            if test "$num" -lt "$min_att"
            then 
                echo "$num" > "$MIN_CORSO"
                echo "$f" > "$GIORNO"
            fi
fi
    fi
done 

for d in *
do 
    if test -d "$d" -a -x "$d"
    then 
        esame_ric.sh "$nome" "$d"
    fi
done