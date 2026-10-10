tee file.txt # scrive l'input sia sul file sia su output 
rev file.txt # inverte l'ordine delle linee di un file
cut -[options] fil.txt # seleziona le colonne di un file

comando < file.txt # aperto in lettura 
comando > file.txt # aperto in scrittura (nuovo o sovreascritto)
comando >> file.txt # aperto in scrittura APPEND (aggiunta)

set # per visualizzare le variabili di ambiente e i loro valori associati

y=3
x='$y'
eval echo $x # stampa 3 

cut # seleziona parti di una stringa e su ogni riga di un file 
cut -c 2-9 # in una riga seleziona i caratteri della stringa 
cut -f # divide la stringa in più parti (per ciascuna riga di un file)
cut -d # delimitatore 
echo $s | cut -f 2-d ','

tr # trasformazioni di caratteri in una stringa o a tutte le righe di un file 
# echo $str | tr "[:lower:]"[:upper:]"

seq 1 5 # stampa le sequenze di numeri, per i cicli negli script 

find # cerca ricorsivamente in tutte le directory

tee # copia standard input in output e file
cat nome.txt | grep stringa | tee a altrofile.txt

set # posso riassegnare gli argomenti 
# $* tutti gli argomenti 
# $# numero di argomenti $0 escluso 
# $? restituisce 0 se tutto ok, 123 errore 
# $$ id numerico processo PID 

read var1

test -<opzione> fil.txt # valutazione di una espressione
test -f file.txt # esistenza di un file ordinario (no dir)
test -d prova_dir #esistenza di una dir
test -r file.txt # diritto di lettura su file -w e -x 
test str1 = str2 
test str1 != str2
test -z str # vero se stringa nulla
test str # vero se stringa non nulla 

# strutture di controllo
if <lista comandi>
    then 
        <comandi> 
    else if <lista comandi> 
        then <comandi>
    else <comandi> 
fi 

#alternativa multipla
case <var> in 
    <pattern -1>)
        <comandi>;;
    <pattern -i> | <pattern -j> | <pattern -k>)
        <comandi>;;
    <pattern -n>)
        <comandi>;;
esac

# cicli enumerativi
for <var> [in <list>]
    do 
        <comandi>
    done

#ripetizioni non enumerative 
while <lista comandi>
    do 
        <comandi>
    done

until <lista comandi>
    do 
        <comandi>
    done

#menu testuali 
select 