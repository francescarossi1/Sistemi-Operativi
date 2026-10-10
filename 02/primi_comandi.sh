man 

ls # per visualizzare i nomi dei file
ls -l # più informazioni sui file
ls -t # lista ordinata per data di ultima modifica 
ls -u # lista ordinata per data di ultimo accesso
ls -r # inverte l'ordine (reverse)
ls -a # lista completa (all)
ls -F # tipo di file: * eseguibile, / directory, @ link simbolico, | FIFO, = socket, niente per i file regolari

mkdir prova
cd prova 
rmdir prova # cancella dir 
pwd # stampa cartella corrente 

ln file1.txt file2.txt # crea collegamenti (link) tra file o directory [inode]
cp file1.txt file2.txt # copia
mv file1.txt file2.txt # rinomina/sposta
cat file1.txt

.more  # permette di visualizzare un file pagina per volta 
.less # visualizzazione all'indietro

echo ciao # stampa a video la stringa passata come parametro

sort # riordina le righe di un file (crescente)
sort -r # (decrescente)
sort -o file.txt # stampa su file
sort -n # interpreta le righe del file come numeri
sort -k 5 # ordina il file secondo il contenuto della n-esima colonna

diff file1.txt file2.txt # mostra le righe diverse tra 2 file

wc -l file.txt # conta le linee/righe
wc -w file.txt # conta le parole
wc -c file.txt # conta i caratteri

grep stringa file.txt # seleziona le righe del file che contengono la stringa e stampa
grep -c stringa file.txt # conta le righe del file che contengono la stringa 
grep -r stringa prova_dir # nella directory stampa tutte le righe richieste

head -n 15 file.txt # mostra le prime n righe del file
head -c 30 fil.txt # mostra i primi n caratteri del file 

tail -n 15 file.txt # mostra le ultime n righe del file
tail -c 30 fil.txt # mostra gli ultimi n caratteri del file 

time ls foto.jpeg # cronometra il tempo di esecuzione di un comando 

who # mostra gli utenti attualmente collegati al sistema (hanno effettuato il login)

ps # lista dei processi attivi 
ps aux # a mostra i processi anche degli altri utenti
       # u formisce il nome dell'utente che ha lanciato il processo e l'ora in cui il processo è stato lanciato
       # x mostra anche i processi senza terminale di controllo (processi demoni)

top  # fornisce l'aggiornamento periodico dello stato dei processi correnti (mem fisica, virtuale, CPU...)
htop # più avanzato ma è da installare 
pgrep processo # restituisce PID dei porcessi, utente...
pgrep -u root sshd # PID processo demone sshd dell'utente root 

pkill processo # uccide il processo (invia segnale SIGTERM)
kill -9 PID # fa terminare forzatamente il processo (SIGKILL -9)
kill -s PID # interrompe il processo e invia un segnale  (SIGINT kill-2, SIGTSTP kill-20)
kill -l # formisce la lista dei segnali 

whoami # verificare l'identità dell'utente
id 

chmod 777 # accesso totale a chiunque: rwx rwx rwx
chmod 755 # rwx r-x r-x 
chmod 700 # rwx --- ---
chmod 664 # rw- rw- rw- 
chmod 644 # rw- r-- r--
chmod 600 # rw- --- ---
chmod 400 # r-- --- ---

chwn utente file.txt # cambia proprietario verifica con ls -l file.txt 
chgrp gruppo file.txt # cambia il gruppo associato al file
chown utente:gruppo file.txt