###### escribir el nombre del modulo sin .v
NAME = fifo
#### EDITE LA VARIABLE PRUEBA CON LA OPCION DESEADA
#### NUMERO DE LA PRUEBA QUE SE QUIERE CORRER:
#### 1. PRUEBA DE FUNCIONAMIENTO NORMAL.
#### 2. PRUEBA DE ERRORES.
#### 3. PRUEBA FULL CONSTANTE, OPERA SIEMPRE LLENO
#### 4. PRUEBA ALMOST FULL AND ALMOST EMPTY
PRUEBA = 1
all: mover yosys compilar gtkwave
compilar:
	iverilog testbench.v
	vvp ./a.out
	rm ./a.out
yosys:
	cp ./UTILIDADES/SEED/script.ys ./UTILIDADES/script.ys
	sed -i 's|SUSTITUIR|$(NAME)|g' ./UTILIDADES/script.ys
	yosys -f script ./UTILIDADES/script.ys
	sed -i 's|module $(NAME)|module synth_$(NAME)|g' ./synth_$(NAME).v
	sed -i 's|_out|_out_synt|g' ./synth_$(NAME).v
cambiar:
	sed -i 's|error_fifo_write_out|error_fifo_write|g' fifo.v
	sed -i 's|error_fifo_read_out|error_fifo_read|g' fifo.v
mover:
	bash ./UTILIDADES/script.sh $(PRUEBA)
gtkwave:
	gtkwave *.gtkw
