#!bin/bash
rm *.vcd
rm *.gtkw

if [ $1 == "1" ]; then
    cp ./UTILIDADES/SEED_FILES/probadorPOPS.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000POPS.gtkw ./000POPS.gtkw
fi

if [ $1 == "2" ]; then
    cp ./UTILIDADES/SEED_FILES/probadorPUSHS.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000PUSHS.gtkw ./000PUSHS.gtkw
fi
