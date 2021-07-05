`timescale 	1ns/100ps
// escala	unidad temporal: ("#1") / precisión

`include "cmos_cells.v"
`include "contadores_synth.v"
`include "contadores.v"
`include "probador.v"

module testbench;/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk;			// From pruebas of probador.v
wire [4:0]		data;			// From prueba_contar of contadores.v, ...
wire [3:0]		estado_FSM;		// From pruebas of probador.v
wire [DATA_BITS-1:0]	fifo_data_out0;		// From pruebas of probador.v
wire [DATA_BITS-1:0]	fifo_data_out1;		// From pruebas of probador.v
wire [DATA_BITS-1:0]	fifo_data_out2;		// From pruebas of probador.v
wire [DATA_BITS-1:0]	fifo_data_out3;		// From pruebas of probador.v
wire [1:0]		idx;			// From pruebas of probador.v
wire			req;			// From pruebas of probador.v
wire			rst;			// From pruebas of probador.v
wire			valid;			// From prueba_contar of contadores.v, ...
// End of automatics

parameter DATA_BITS = 10;
wire [4:0] data_synth;
wire valid_synth;

	contadores prueba_contar(/*AUTOINST*/
				 // Outputs
				 .data			(data[4:0]),
				 .valid			(valid),
				 // Inputs
				 .fifo_data_out0	(fifo_data_out0[DATA_BITS-1:0]),
				 .fifo_data_out1	(fifo_data_out1[DATA_BITS-1:0]),
				 .fifo_data_out2	(fifo_data_out2[DATA_BITS-1:0]),
				 .fifo_data_out3	(fifo_data_out3[DATA_BITS-1:0]),
				 .req			(req),
				 .idx			(idx[1:0]),
				 .estado_FSM		(estado_FSM[3:0]),
				 .rst			(rst),
				 .clk			(clk));

	contadores_synth prueba_contar_synth(/*AUTOINST*/
					     // Outputs
					     .data		(data_synth[4:0]),
					     .valid		(valid_synth),
					     // Inputs
					     .clk		(clk),
					     .estado_FSM	(estado_FSM[3:0]),
					     .fifo_data_out0	(fifo_data_out0[9:0]),
					     .fifo_data_out1	(fifo_data_out1[9:0]),
					     .fifo_data_out2	(fifo_data_out2[9:0]),
					     .fifo_data_out3	(fifo_data_out3[9:0]),
					     .idx		(idx[1:0]),
					     .req		(req),
					     .rst		(rst));
	
	probador pruebas(/*AUTOINST*/
			 // Outputs
			 .fifo_data_out0	(fifo_data_out0[DATA_BITS-1:0]),
			 .fifo_data_out1	(fifo_data_out1[DATA_BITS-1:0]),
			 .fifo_data_out2	(fifo_data_out2[DATA_BITS-1:0]),
			 .fifo_data_out3	(fifo_data_out3[DATA_BITS-1:0]),
			 .req			(req),
			 .idx			(idx[1:0]),
			 .estado_FSM		(estado_FSM[3:0]),
			 .rst			(rst),
			 .clk			(clk),
			 // Inputs
			 .data			(data[4:0]),
			 .valid			(valid),
			 .data_synth		(data_synth[4:0]),
			 .valid_synth		(valid_synth));

endmodule
