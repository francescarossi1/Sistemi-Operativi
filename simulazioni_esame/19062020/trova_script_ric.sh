#!/bin/sh

cd "$1"
count=0

for f in *.sh
do
    if test -f "$f" -a -r "$f" -a -w "$f"
    then
        if grep -q "#!/bin/bash" "$f"
        then
            echo "`pwd`/$f" >> "$script"
            count=`expr $count + 1`
        fi
    fi
done

max_attuale=`cat "$MAX"`
if test "$count" -gt "$max_attuale"
then
    echo "$count" > "$MAX"
    pwd > "$DIR_MAX"
fi

for d in *
do
    if test -d "$d" -a -x "$d"
    then
        trova_script_ric.sh "`pwd`/$d"
    fi
done