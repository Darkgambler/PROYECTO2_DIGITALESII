TARGET = contadores
CCX = iverilog

CFLAGS = -o ${TARGET}.out 
SOURCES = "testbench.v"

all: yosys compile run wave

compile:
	@$(CCX) $(SOURCES) $(CFLAGS)
	@echo
	@echo "<< iverilog finalizó la compilación exitosamente >>"
	@echo

run:
	@echo
	@echo "Se procederá a ejecutar el archivo de salida..."
	@./$(TARGET).out
	@echo
	@echo "Hecho! La ejecución finalizó con éxito"
	@echo
	
wave:
	@echo "Abriendo el resultado en GTKWave..."
	@gtkwave *.gtkw
	@gtkwave $(TARGET).vcd

yosys:
	@echo
	@echo "<< Creando la síntesis con tecnología CMOS >>"
	@echo
	@yosys script_cmos.ys
	@echo
	@echo "<< Síntesis exitosa >>"
	@echo
	@echo "Realizando el cambio de nombre al nuevo módulo:"
	@echo
	@sed -i 's/module contadores/module contadores_synth/g' contadores_synth.v
	@echo
	@echo "<< Se cambió el nombre al módulo satisfactoriamente >>"
	@echo
	