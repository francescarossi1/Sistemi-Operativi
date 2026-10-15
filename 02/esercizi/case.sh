read risposta 
case $risposta in 
    S* | s* | Y* |y* <OK> ;;
    *) <problema>;;
esac

case $# in 
    1) cat >> $1;; 
    2) cat < $1 >> $2;;
    *) echo uso: append [dadove] adove; 
    exit 1;;
esac