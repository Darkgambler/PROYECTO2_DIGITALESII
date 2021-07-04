`include "arbitro.v"
`include "synth_arbitro.v"
`include "probador.v"
`include "./UTILIDADES/cmos_cells.v"

module testbench;
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			afull0;			// From PROBADOR of probador.v
   wire			afull1;			// From PROBADOR of probador.v
   wire			afull2;			// From PROBADOR of probador.v
   wire			afull3;			// From PROBADOR of probador.v
   wire			clk;			// From PROBADOR of probador.v
   wire [1:0]		demux0_out;		// From CONDUCTUAL of arbitro.v
   wire [1:0]		demux0_out_synt;	// From SINTETIZADO of synth_arbitro.v
   wire [1:0]		dest;			// From PROBADOR of probador.v
   wire			empty0;			// From PROBADOR of probador.v
   wire			empty1;			// From PROBADOR of probador.v
   wire			empty2;			// From PROBADOR of probador.v
   wire			empty3;			// From PROBADOR of probador.v
   wire			pop0_out;		// From CONDUCTUAL of arbitro.v
   wire			pop0_out_synt;		// From SINTETIZADO of synth_arbitro.v
   wire			pop1_out;		// From CONDUCTUAL of arbitro.v
   wire			pop1_out_synt;		// From SINTETIZADO of synth_arbitro.v
   wire			pop2_out;		// From CONDUCTUAL of arbitro.v
   wire			pop2_out_synt;		// From SINTETIZADO of synth_arbitro.v
   wire			pop3_out;		// From CONDUCTUAL of arbitro.v
   wire			pop3_out_synt;		// From SINTETIZADO of synth_arbitro.v
   wire			push0_out;		// From CONDUCTUAL of arbitro.v
   wire			push0_out_synt;		// From SINTETIZADO of synth_arbitro.v
   wire			push1_out;		// From CONDUCTUAL of arbitro.v
   wire			push1_out_synt;		// From SINTETIZADO of synth_arbitro.v
   wire			push2_out;		// From CONDUCTUAL of arbitro.v
   wire			push2_out_synt;		// From SINTETIZADO of synth_arbitro.v
   wire			push3_out;		// From CONDUCTUAL of arbitro.v
   wire			push3_out_synt;		// From SINTETIZADO of synth_arbitro.v
   wire			reset;			// From PROBADOR of probador.v
   // End of automatics

   probador PROBADOR( /*AUTOINST*/
		     // Outputs
		     .dest		(dest[1:0]),
		     .empty0		(empty0),
		     .empty1		(empty1),
		     .empty2		(empty2),
		     .empty3		(empty3),
		     .afull0		(afull0),
		     .afull1		(afull1),
		     .afull2		(afull2),
		     .afull3		(afull3),
		     .reset		(reset),
		     .clk		(clk),
		     // Inputs
		     .pop0_out		(pop0_out),
		     .pop1_out		(pop1_out),
		     .pop2_out		(pop2_out),
		     .pop3_out		(pop3_out),
		     .pop0_out_synt	(pop0_out_synt),
		     .pop1_out_synt	(pop1_out_synt),
		     .pop2_out_synt	(pop2_out_synt),
		     .pop3_out_synt	(pop3_out_synt),
		     .push0_out		(push0_out),
		     .push1_out		(push1_out),
		     .push2_out		(push2_out),
		     .push3_out		(push3_out),
		     .push0_out_synt	(push0_out_synt),
		     .push1_out_synt	(push1_out_synt),
		     .push2_out_synt	(push2_out_synt),
		     .push3_out_synt	(push3_out_synt),
		     .demux0_out	(demux0_out[1:0]),
		     .demux0_out_synt	(demux0_out_synt[1:0]));
   arbitro CONDUCTUAL( /*AUTOINST*/
		      // Outputs
		      .pop0_out		(pop0_out),
		      .pop1_out		(pop1_out),
		      .pop2_out		(pop2_out),
		      .pop3_out		(pop3_out),
		      .push0_out	(push0_out),
		      .push1_out	(push1_out),
		      .push2_out	(push2_out),
		      .push3_out	(push3_out),
		      .demux0_out	(demux0_out[1:0]),
		      // Inputs
		      .dest		(dest[1:0]),
		      .empty0		(empty0),
		      .empty1		(empty1),
		      .empty2		(empty2),
		      .empty3		(empty3),
		      .afull0		(afull0),
		      .afull1		(afull1),
		      .afull2		(afull2),
		      .afull3		(afull3),
		      .reset		(reset),
		      .clk		(clk));
   synth_arbitro SINTETIZADO( /*AUTOINST*/
			     // Outputs
			     .demux0_out_synt	(demux0_out_synt[1:0]),
			     .pop0_out_synt	(pop0_out_synt),
			     .pop1_out_synt	(pop1_out_synt),
			     .pop2_out_synt	(pop2_out_synt),
			     .pop3_out_synt	(pop3_out_synt),
			     .push0_out_synt	(push0_out_synt),
			     .push1_out_synt	(push1_out_synt),
			     .push2_out_synt	(push2_out_synt),
			     .push3_out_synt	(push3_out_synt),
			     // Inputs
			     .afull0		(afull0),
			     .afull1		(afull1),
			     .afull2		(afull2),
			     .afull3		(afull3),
			     .clk		(clk),
			     .dest		(dest[1:0]),
			     .empty0		(empty0),
			     .empty1		(empty1),
			     .empty2		(empty2),
			     .empty3		(empty3),
			     .reset		(reset));

endmodule // testbench
