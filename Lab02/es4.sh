ps aux --sort =-%cpu | head -n 5 > cpu.txt 
cat cpu.txt 
tail -n 5 >> cpu.txt 
cat cpu.txt
grep -v $USER cpu.txt