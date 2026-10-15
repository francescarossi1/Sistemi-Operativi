ls $HOME | sort -r > listato_in_ordine_inverso.txt
ls -p $HOME | grep / | sort > home_dirs.txt
cat home_dirs.txt
head -n 4 home_dirs.txt > 4_home_dirs.txt
grep /sbin/nologin /etc/passwd | sort | head -n 5 
ls -lt $HOME | head -n 3 | wc -c 