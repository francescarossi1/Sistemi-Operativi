# !/bin/bash
dir="$1"
cd "$dir"
count=0
for f in *.sh 
do 
    if test -f "$f" -a -r "$f"
    then 
        num=`grep -c "#!/bin/bash" "$f"`   # Aggiunta virgoletta di chiusura e rimosso lo spazio dopo '='
        echo "$num" 
        if test "$num" = 1 
        then
            echo "`echo "$f" | cut -d "." -f1`" >> $script
            count=`expr $count + 1`        # Aggiunto spazio tra '+' e '1'
        fi
    fi
done 


if test "$count" -gt "`cat "$MAX"`"
then 
    echo "$count" > "$MAX"
    echo "$dir" > "$DIR_MAX"
fi

for d in *
do 
    if test -d "$d" -a -x "$d"
    then 
        trova_script_ric.sh "$d"
    fi
done