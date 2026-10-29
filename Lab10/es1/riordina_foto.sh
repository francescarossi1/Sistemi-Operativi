#!/bin/sh
# riordina_foto.sh - Script principale

# 1. Controllo sul numero di parametri (devono essere esattamente 2)
if test $# -ne 2
then
    echo "Uso: $0 dir_sorgente dir_destinazione"
    exit 1
fi

dir_sorgente=$1
dir_destinazione=$2

# 2. Controllo che i nomi forniti siano relativi (non devono iniziare con '/')
case "$dir_sorgente" in
    /*) echo "Errore: dir_sorgente deve essere un percorso relativo"
        exit 2 ;;
esac

case "$dir_destinazione" in
    /*) echo "Errore: dir_destinazione deve essere un percorso relativo"
        exit 3 ;;
esac

# 3. Controllo esistenza e tipo di dir_sorgente
if test ! -d "$dir_sorgente"
then
    echo "Errore: $dir_sorgente non esiste o non e' una directory"
    exit 4
fi

# 4. Controllo esistenza e tipo di dir_destinazione
if test ! -d "$dir_destinazione"
then
    echo "Errore: $dir_destinazione non esiste o non e' una directory"
    exit 5
fi

# 5. Conversione dei percorsi in assoluti
# Usiamo `cd` per ricavare il percorso assoluto in modo sicuro ed evitare problemi durante la ricorsione
dir_sorgente_ass=`cd "$dir_sorgente" && pwd`
dir_destinazione_ass=`cd "$dir_destinazione" && pwd`

# 6. Creazione della directory 'duplicati' se non esiste
if test ! -d "$dir_destinazione_ass/duplicati"
then
    mkdir "$dir_destinazione_ass/duplicati"
    if test $? -ne 0
    then
        echo "Errore: Impossibile creare la directory $dir_destinazione_ass/duplicati"
        exit 6
    fi
fi

# 7. Esportazione della variabile PATH per garantire l'invocazione di ricorsione.sh nella directory corrente
PATH=`pwd`:$PATH
export PATH

# 8. Invocazione dello script ricorsivo
ricorsione.sh "$dir_sorgente_ass" "$dir_destinazione_ass"

# 9. Conteggio finale dei file spostati direttamente in dir_destinazione (escludendo la sottodirectory duplicati)
# Si contano solo i file regolari direttamente contenuti in dir_destinazione
count=0
for file in "$dir_destinazione_ass"/*
do
    if test -f "$file"
    then
        count=`expr $count + 1`
    fi
done

echo "Operazione completata."
echo "Numero di file spostati nella directory di destinazione: $count"