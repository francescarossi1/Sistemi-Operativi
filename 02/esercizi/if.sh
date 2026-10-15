# test su argomenti

# risponde si se invocato con si e un numero <= 24
if test $1 = si -a $2 -le 24 
    then echo si 
    else echo no
fi 
# -le less then: equal to valuta 24 come valore numerico (di default stringhe)


if test $1; 
    then echo OK
    else echo Almeno un argomento
fi
