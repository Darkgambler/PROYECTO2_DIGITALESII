`include "xfifo.v"
`include "arbitro.v"
`include "Xdemux.v"
`include "Xmux.v"
`include "machine.v"
`include "contadores.v"

module integracion( output wire [9:0] fifo4_out, fifo5_out, 
		    output wire [9:0] fifo6_out, fifo7_out,
		    input wire [9:0]  fifo0_i, fifo1_i, fifo2_i, fifo3_i,
		    input wire [2:0]  high_probador, low_probador,
		    input wire [1:0]  idx,
		    input wire 	      push0, push1, push2, push3,
		    input wire 	      pop4, pop5, pop6, pop7,
		    input wire 	      init, req, reset, clk );

   wire [9:0] fifo0_o, fifo1_o, fifo2_o, fifo3_o;
   wire [9:0] fifo4_i, fifo5_i, fifo6_i, fifo7_i, data_inter;   
   wire [2:0] high, low;
   wire [1:0] demux;
   wire [1:0] destino;
   wire       reset_mach;
   wire       idle;
   wire       emptys;
   wire [6:0] counter;
   wire       valid_counter;
   
   assign emptys = fifo0_empty & fifo1_empty & fifo2_empty &
		   fifo3_empty & fifo4_empty & fifo5_empty &
		   fifo6_empty & fifo7_empty;
  
   
   arbitro ARBITRO( pop0, pop1, pop2, pop3, push4, push5, 
		    push6, push7, demux, signalBeta, fifo0_empty, 
		    fifo1_empty, fifo2_empty, fifo3_empty, 
		    fifo4_full, fifo5_full, fifo6_full, 
		    fifo7_full, destino, reset_mach, clk );

   machine MACHINE( reset_mach, idle, low, high, low_probador, 
		    high_probador, clk, reset, init, emptys );

   
   contadores CONTAD( counter, valid_counter, idx, push4, push5,
			  push6, push7, idle, req, clk, reset );
   

   xfifo FIFO0( fifo0_o, fifo0_full, fifo0_empty, fifo0_err, 
		fifo0_i, high, low, push0, pop0, clk, reset_mach );
   xfifo FIFO1( fifo1_o, fifo1_full, fifo1_empty, fifo1_err, 
		fifo1_i, high, low, push1, pop1, clk, reset_mach );
   xfifo FIFO2( fifo2_o, fifo2_full, fifo2_empty, fifo2_err, 
		fifo2_i, high, low, push2, pop2, clk, reset_mach );
   xfifo FIFO3( fifo3_o, fifo3_full, fifo3_empty, fifo3_err, 
		fifo3_i, high, low, push3, pop3, clk, reset_mach );
   
   Xdemux DEMUX( data_inter, destino, fifo0_o, fifo1_o, fifo2_o, 
	       fifo3_o, demux, reset_mach, clk );

   Xmux MUX( fifo4_i, fifo5_i, fifo6_i, fifo7_i, data_inter, destino );
   
 
   xfifo FIFO4( fifo4_out, fifo4_full, fifo4_empty, fifo4_err, 
		fifo4_i, high, low, push4, pop4, clk, reset_mach );
   xfifo FIFO5( fifo5_out, fifo5_full, fifo5_empty, fifo5_err, 
		fifo5_i, high, low, push5, pop5, clk, reset_mach );
   xfifo FIFO6( fifo6_out, fifo6_full, fifo6_empty, fifo6_err, 
		fifo6_i, high, low, push6, pop6, clk, reset_mach );
   xfifo FIFO7( fifo7_out, fifo7_full, fifo7_empty, fifo7_err, 
		fifo7_i, high, low, push7, pop7, clk, reset_mach );

endmodule // integracion
