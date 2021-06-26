`include "probador.v"
`include "ram.v"
`include "synth_ram.v"
`include "./UTILIDADES/cmos_cells.v"

module testbench;

   parameter DATA_BITS = 8;
   parameter ADDR_BITS = 6; 
 
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [ADDR_BITS-1:0]	addr_read;		// From PROB of probador.v
   wire [ADDR_BITS-1:0]	addr_write;		// From PROB of probador.v
   wire			clk;			// From PROB of probador.v
   wire [DATA_BITS-1:0]	data_in;		// From PROB of probador.v
   wire [DATA_BITS-1:0]	data_out;		// From COND of ram.v
   wire [7:0]		data_out_synt;		// From SYNT of synth_ram.v
   wire			read;			// From PROB of probador.v
   wire			write;			// From PROB of probador.v
   // End of automatics

   probador PROB( /*AUTOINST*/
		 // Outputs
		 .data_in		(data_in[DATA_BITS-1:0]),
		 .addr_write		(addr_write[ADDR_BITS-1:0]),
		 .addr_read		(addr_read[ADDR_BITS-1:0]),
		 .write			(write),
		 .read			(read),
		 .clk			(clk));
   ram COND( /*AUTOINST*/
	    // Outputs
	    .data_out			(data_out[DATA_BITS-1:0]),
	    // Inputs
	    .data_in			(data_in[DATA_BITS-1:0]),
	    .addr_write			(addr_write[ADDR_BITS-1:0]),
	    .addr_read			(addr_read[ADDR_BITS-1:0]),
	    .write			(write),
	    .read			(read),
	    .clk			(clk));
   synth_ram SYNT( /*AUTOINST*/
		  // Outputs
		  .data_out_synt	(data_out_synt[DATA_BITS-1:0]),
		  // Inputs
		  .addr_read		(addr_read[ADDR_BITS-1:0]),
		  .addr_write		(addr_write[ADDR_BITS-1:0]),
		  .clk			(clk),
		  .data_in		(data_in[DATA_BITS-1:0]),
		  .read			(read),
		  .write		(write));
   

endmodule // testbench
