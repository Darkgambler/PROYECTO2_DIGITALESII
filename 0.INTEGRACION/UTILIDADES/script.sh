#!bin/bash
rm *.vcd
rm *.gtkw

if [ $1 == "1" ]; then
    cp ./UTILIDADES/SEED_FILES/probadorPOPS.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000NORMAL.gtkw ./000NORMAL.gtkw
fi

if [ $1 == "2" ]; then
    cp ./UTILIDADES/SEED_FILES/probadorERRORS.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000ERRORS.gtkw ./000ERRORS.gtkw
fi

if [ $1 == "3" ]; then
    cp ./UTILIDADES/SEED_FILES/probadorFULLCONSTANTE.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000FULLCONSTANTE.gtkw ./000FULLCONSTANTE.gtkw
fi


if [ $1 == "4" ]; then
    cp ./UTILIDADES/SEED_FILES/probadorALMOST.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000ALMOST.gtkw ./000ALMOST.gtkw
fi
