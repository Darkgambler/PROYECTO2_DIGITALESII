#!bin/bash
rm *.vcd
rm *.gtkw

if [ $1 == "1" ]; then
    cp ./UTILIDADES/SEED_FILES/probador.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000CONTADOR.gtkw ./000CONTADOR.gtkw
fi

if [ $1 == "2" ]; then
    cp ./UTILIDADES/SEED_FILES/probador.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000CONTADOR.gtkw ./000CONTADOR.gtkw
    #cp ./UTILIDADES/SEED_FILES/000PUSHS.gtkw ./000PUSHS.gtkw
fi
