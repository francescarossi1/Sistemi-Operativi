#!/bin/sh

dir="$1"
shift
id_robot="$1"
shift

cd "$dir"

counter=0
for f in *.rbt
do
    if test -f "$f" -a -r "$f" 
    then 

        occorenze=`grep -c "$id_robot" "$f"`

        if test "$occorenze" -gt 0
        then 
            `grep "$id_robot" "$f" | cut -d "-" -f2,3 >> "$LOG"`
            counter=`expr $counter + 1`
        fi
        
    fi

done

max_attuale=`cat "$MAX_COUNT"` 
if test "$counter" -gt "$max_attuale" 
then 
    echo "$counter" > "$MAX_COUNT" 
    echo "`pwd`" > "$MAX_FILE"
fi

for d in *
do 
    if test -d "$d" -a -x "$d"
    then 
        monitoraggio_ric.sh "$(pwd)/$d" "$id_robot"
    fi
done 