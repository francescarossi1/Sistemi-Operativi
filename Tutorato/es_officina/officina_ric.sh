#!/bin/sh

#officina_ric.sh categoria anno

categoria="$1"
shift 
anno="$1"
shift 

cd "$anno" || exit 1

# ciclo file con estensione .txt 
for f in *.txt
do 
    # verifico che è un file ed è leggibile
    if test -f "$f" -a -r "$f"
    then 
        mese=`echo "$f" | cut -f1 -d "."`
        # Corretto il refuso $categria -> $categoria
        num_int=`grep -w "$categoria" "$f" | cut -f1 -d " "`

        if test ! -z "$num_int"
        then 
            echo "$mese $num_int" >> "$RIEPILOGO"
        fi 

        # calcolo massimo
        riga_max=`sort -n "$f" | tail -n 1`

        if test ! -z "$riga_max"
        then 
            val=`echo "$riga_max" | cut -f1 -d ' '`

            if test "$val" -gt `cat "$MAX_COUNT"`
            then 
                echo "$val" > "$MAX_COUNT"
                # Sostituito cat con cut
                echo "$riga_max" | cut -f2 -d ' ' > "$MAX_CAT"
            fi 
        fi
    fi 
done

# ciclo sulle sottodir 
for d in * 
do
    if test -d "$d" -a -x "$d"
    then 
        officina_ric.sh "$categoria" "`pwd`/$d"
    fi
done