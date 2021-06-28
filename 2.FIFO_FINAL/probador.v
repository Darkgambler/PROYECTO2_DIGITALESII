module probador #( parameter DATA_BITS = 10,
		   parameter ADDR_BITS = 3,
		   parameter HIGH = 6, parameter LOW = 2 )
                 ( output reg [DATA_BITS-1:0] fifo_data_in,
		   output reg [ADDR_BITS-1:0] high_limit, low_limit,
		   output reg 		      fifo_write, fifo_read, clk, reset,
		   input wire [DATA_BITS-1:0] fifo_data_out, fifo_data_out_synt,
		   input wire 		      fifo_full_out, fifo_empty_out,
		   input wire 		      fifo_full_out_synt, 
		   input wire 		      fifo_empty_out_synt,
		   input wire 		      error_fifo_out, 
		   input wire 		      error_fifo_out_synt );

   

   reg [DATA_BITS-1:0] 			      fifo_data_in_n;
   reg 					      fifo_write_n, fifo_read_n, reset_n;

   always @( posedge clk ) begin
      fifo_data_in <= fifo_data_in_n;
      fifo_write <= fifo_write_n;
      fifo_read <= fifo_read_n;
      reset <= reset_n;
   end
   
   initial begin
      $dumpfile( "000graf.vcd" );
      $dumpvars( 0 );
   end

   initial begin
      high_limit = HIGH;
      low_limit = LOW;
      fifo_data_in_n = 0;
      fifo_write_n = 0;
      fifo_read_n = 0;
      clk = 0;
      reset_n = 0;
   end

   always begin
      #1 clk = !clk;
   end

   initial begin
      #15 reset_n = 1;
      fifo_data_in_n = $random;
      fifo_write_n = 1;
      fifo_read_n = 0;
      repeat( 7 ) begin
	 #2 
	 fifo_data_in_n = $random;
	 fifo_write_n = 1;
	 fifo_read_n = 0;
      end
      repeat( 4 ) begin
	 #2 
	 fifo_data_in_n = $random;
	 fifo_write_n = 0;
	 fifo_read_n = 1;
      end
	//#2 fifo_read_n = 0;

      #25 $finish;
   end
endmodule // probador

      

   
