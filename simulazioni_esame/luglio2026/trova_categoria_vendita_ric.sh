# !/bin/sh

dir="$1"
cd "$dir" 

count=0
for f in *.log
do 
    if test -f "$f" -a -r "$f" 
    then 
        if test "`head -n 1 "$f" | cut -d "," -f 5`" = "venduto"
        then 
            count=`expr $count + 1`
            
        fi
    fi
done

if test "$count" -gt `cat "$max"`
then 
    echo "$count" >"$max" 
    echo "$dir" > "$max_dir"

    > "$out"
    for i in *.log 
    do
        if test "`head -n 1 "$i" | cut -d "," -f 5`" = "venduto"
        then 
            echo "`head -n 1 "$i"`" >> $out
        fi
    done
fi

for d in *
do 
    if test -d "$d" -a -x "$d" 
    then 
        trova_categoria_vendita_ric.sh "$d"
    fi
done