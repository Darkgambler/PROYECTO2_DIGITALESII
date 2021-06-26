###### escribir el nombre del modulo sin .v
NAME = fifo
all: yosys compilar
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
