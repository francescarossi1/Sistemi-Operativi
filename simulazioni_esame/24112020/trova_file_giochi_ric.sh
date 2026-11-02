#!/bin/sh

cd "$1"

for f in *.txt
do
    if test -f "$f" -a -r "$f"
    then
        # file che abbiano come riga la stringa giochi
        if test `head -n 1 "$f"` = "giochi"
        then
            # memorizzo la path di $i
            echo "`pwd`/$f" >> "$trovato"
            num=`wc -l < "$f"`
            # Controllo del massimo
            if test $num -gt `cat "$MAX_COUNT"`
            then
                echo $num > "$MAX_COUNT"
                echo "`pwd`/$f" > "$MAX_FILE"
            fi
        fi
    fi
done

for d in *
do
    if test -d "$d" -a -x "$d"
    then
        trova_file_giochi_ric.sh "$d"
    fi
done