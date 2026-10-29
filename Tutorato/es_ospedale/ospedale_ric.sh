#!/bin/sh
# Francesca Rossi 211964

reparto="$1"
shift
anno="$1"
shift 

cd "$anno" || exit 1

# Ciclo sui file con estensione .txt nella directory corrente
for d in *.txt
do 
    if test -f "$d" -a -r "$d" 
    then 
        # Estrae le righe corrispondenti al reparto e le scrive nel file di log globale
        grep -w "$reparto" "$d" | cut -d " " -f 2,4,5 >> "$RICOVERI"

        # Estrae il nome del mese dal nome del file (es. maggio.txt -> maggio)
        mese=`echo "$d" | cut -d "." -f1`

        # Conta quanti ricoveri (righe) sono presenti per quel reparto nel file
        n_ricoveri=`grep -c -w "$reparto" "$d"`
        max_count=`cat "$MAX_COUNT"` 

        # Aggiorna il massimo se il valore corrente è maggiore
        if test "$n_ricoveri" -gt "$max_count"
        then 
            echo "$n_ricoveri" > "$MAX_COUNT" 
            echo "$mese $anno" > "$MAX_MONTH"
        fi
    fi
done 

# Ciclo di esplorazione ricorsiva sulle sottodirectory
for d in * 
do
    if test -d "$d" -a -x "$d"
    then 
        ospedale_ric.sh "$reparto" "$d"
    fi
done