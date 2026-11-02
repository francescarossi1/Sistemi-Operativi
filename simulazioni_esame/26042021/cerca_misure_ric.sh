# !/bin/sh


dir="$1" 
shift
header="$1"
shift

cd "$dir"

count=0;
for f in *.log 
do
    if test -f "$f" -a -r "$f"
    then 
        if test `head -n 1 "$f" | grep -c "$header"` -ge 1
        then 
            echo "`pwd`"/"$file" >> misure
            counter=`expr $counter + 1`
        fi
    fi

done

if test "$count" -gt `cat "$MAX_COUNT"`
then 
    echo "$count" > "$MAX_COUNT"
    echo "$dir" > "$MAX_DIR"
fi

for d in *
do
    if test -d "$d" -a -x "$d"
    then 
        cerca_misure_ric.sh "$d" "$header"
    fi
done