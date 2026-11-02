#!/bin/sh 

dir="$1"
shift 
id_cliente="$1"
shift 

cd "$dir"

for f in *.gel
do 
    if test -f "$f" -a -r "$f"
    then 
        echo "`grep "$id_cliente" "$f" | cut -d "-" -f2,3`" > "$LOG"
        num=`grep -c "$id_cliente" "$f"`

        if test "$num" -gt `cat "$MAX_COUNT"`
        then 
            sede=`echo "$f" | cut -d "." -f1`
            echo "$num" > "$MAX_COUNT"
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