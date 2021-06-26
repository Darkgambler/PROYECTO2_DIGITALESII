`include "probador.v"
`include "fifo.v"
`include "synth_fifo.v"
`include "./UTILIDADES/cmos_cells.v"

module testbench;

   parameter DATA_BITS = 10;
   parameter ADDR_BITS = 3; 
 
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			clk;			// From PROB of probador.v
   wire			error_fifo_out;		// From COND of fifo.v
   wire			error_fifo_out_synt;	// From SYNT of synth_fifo.v
   wire [DATA_BITS-1:0]	fifo_data_in;		// From PROB of probador.v
   wire [DATA_BITS-1:0]	fifo_data_out;		// From COND of fifo.v
   wire [9:0]		fifo_data_out_synt;	// From SYNT of synth_fifo.v
   wire			fifo_empty_out;		// From COND of fifo.v
   wire			fifo_empty_out_synt;	// From SYNT of synth_fifo.v
   wire			fifo_full_out;		// From COND of fifo.v
   wire			fifo_full_out_synt;	// From SYNT of synth_fifo.v
   wire			fifo_read;		// From PROB of probador.v
   wire			fifo_write;		// From PROB of probador.v
   wire			reset;			// From PROB of probador.v
   // End of automatics

   probador PROB( /*AUTOINST*/
		 // Outputs
		 .fifo_data_in		(fifo_data_in[DATA_BITS-1:0]),
		 .fifo_write		(fifo_write),
		 .fifo_read		(fifo_read),
		 .clk			(clk),
		 .reset			(reset),
		 // Inputs
		 .fifo_data_out		(fifo_data_out[DATA_BITS-1:0]),
		 .fifo_full_out		(fifo_full_out),
		 .fifo_empty_out	(fifo_empty_out),
		 .fifo_full_out_synt	(fifo_full_out_synt),
		 .fifo_empty_out_synt	(fifo_empty_out_synt),
		 .error_fifo_out	(error_fifo_out),
		 .error_fifo_out_synt	(error_fifo_out_synt));
   fifo COND( /*AUTOINST*/
	     // Outputs
	     .fifo_data_out		(fifo_data_out[DATA_BITS-1:0]),
	     .fifo_full_out		(fifo_full_out),
	     .fifo_empty_out		(fifo_empty_out),
	     .error_fifo_out		(error_fifo_out),
	     // Inputs
	     .fifo_data_in		(fifo_data_in[DATA_BITS-1:0]),
	     .fifo_write		(fifo_write),
	     .fifo_read			(fifo_read),
	     .clk			(clk),
	     .reset			(reset));
   synth_fifo SYNT( /*AUTOINST*/
		   // Outputs
		   .error_fifo_out_synt	(error_fifo_out_synt),
		   .fifo_data_out_synt	(fifo_data_out_synt[9:0]),
		   .fifo_empty_out_synt	(fifo_empty_out_synt),
		   .fifo_full_out_synt	(fifo_full_out_synt),
		   // Inputs
		   .clk			(clk),
		   .fifo_data_in	(fifo_data_in[9:0]),
		   .fifo_read		(fifo_read),
		   .fifo_write		(fifo_write),
		   .reset		(reset));
   

endmodule // testbench
