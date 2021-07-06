`include "probador.v"
`include "contadores.v"
`include "synth_contadores.v"
`include "./UTILIDADES/cmos_cells.v"

module testbench;

   parameter CBITS = 5;
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			clk;			// From PROBADOR of probador.v
   wire [CBITS-1:0]	counter_out;		// From CONDUCTUAL of contadores.v
   wire [4:0]		counter_out_synt;	// From SYNTHESIS of synth_contadores.v
   wire			idle;			// From PROBADOR of probador.v
   wire [1:0]		idx;			// From PROBADOR of probador.v
   wire			push0;			// From PROBADOR of probador.v
   wire			push1;			// From PROBADOR of probador.v
   wire			push2;			// From PROBADOR of probador.v
   wire			push3;			// From PROBADOR of probador.v
   wire			req;			// From PROBADOR of probador.v
   wire			reset;			// From PROBADOR of probador.v
   wire			valid_out;		// From CONDUCTUAL of contadores.v
   wire			valid_out_synt;		// From SYNTHESIS of synth_contadores.v
   // End of automatics

   probador PROBADOR( /*AUTOINST*/
		     // Outputs
		     .push0		(push0),
		     .push1		(push1),
		     .push2		(push2),
		     .push3		(push3),
		     .idle		(idle),
		     .req		(req),
		     .clk		(clk),
		     .reset		(reset),
		     .idx		(idx[1:0]),
		     // Inputs
		     .counter_out	(counter_out[CBITS-1:0]),
		     .counter_out_synt	(counter_out_synt[CBITS-1:0]),
		     .valid_out		(valid_out),
		     .valid_out_synt	(valid_out_synt));
   contadores CONDUCTUAL( /*AUTOINST*/
			 // Outputs
			 .counter_out		(counter_out[CBITS-1:0]),
			 .valid_out		(valid_out),
			 // Inputs
			 .idx			(idx[1:0]),
			 .push0			(push0),
			 .push1			(push1),
			 .push2			(push2),
			 .push3			(push3),
			 .idle			(idle),
			 .req			(req),
			 .clk			(clk),
			 .reset			(reset));
   synth_contadores SYNTHESIS( /*AUTOINST*/
			      // Outputs
			      .counter_out_synt	(counter_out_synt[4:0]),
			      .valid_out_synt	(valid_out_synt),
			      // Inputs
			      .clk		(clk),
			      .idle		(idle),
			      .idx		(idx[1:0]),
			      .push0		(push0),
			      .push1		(push1),
			      .push2		(push2),
			      .push3		(push3),
			      .req		(req),
			      .reset		(reset));

endmodule // testbench
