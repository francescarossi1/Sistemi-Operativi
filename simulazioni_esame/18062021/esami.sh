#!/bin/sh

if test $# -ne 3 
then 
    echo "numero argomenti sbagliato"
    exit 1
fi 

genere="$1"
shift 
tipo="$1"
shift 
anno="$1"
shift 

case "$genere" in 
    *[A-Za-z]*) ;;
    *) echo "errore genere non accettato"
    exit 2 ;;
esac 

case "$tipo" in 
    *[A-Za-z]*) ;;
    *) echo "errore tipo non accettato"
    exit 3 ;;
esac 

case "$anno" in 
    /*) ;; 
    *) echo " errore anno non è una dir assoluta"
    exit 4 ;;
esac

# Note: L'operatore -o (OR) assicura che lo script fallisca se $anno non è directory oppure non è attraversabile (-x)
if test ! -d "$anno" -o ! -x "$anno"
then 
    echo " errore anno non eseguibile o non dir" 
    exit 5
fi 

PATH=$PATH:`pwd`
export PATH

max="/tmp/max.tmp"
echo "0" > "$max"
export max

mese_max="/tmp/mese_max.tmp"
> "$mese_max"
export mese_max

# CORREZIONE: Corretto il refuso nel nome del file 'risultati.log' (mancava la 't')
risultati="$HOME/risultati.log"
> "$risultati"
export risultati

esami_ric.sh "$genere" "$tipo" "$anno"

echo "` sort -n -r "$risultati"`" > "$risultati"
echo "--- Mese con il massimo numero di occorrenze ---"
cat "$mese_max" 
echo "--- Valore massimo ---"
cat "$max"

rm -f "$mese_max" 
rm -f "$max"