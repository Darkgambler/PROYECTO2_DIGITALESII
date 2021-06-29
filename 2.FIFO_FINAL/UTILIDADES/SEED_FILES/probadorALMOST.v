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
      if( reset ) begin
	 if( fifo_data_out !== fifo_data_out_synt ) begin
	    $display( "discrepancia fifo_data_out en: %t", $time );
	 end
	 if( fifo_full_out !== fifo_full_out_synt ) begin
	    $display( "discrepancia fifo_full_out en: %t", $time );
	 end
	 if( fifo_empty_out !== fifo_empty_out_synt ) begin
	    $display( "discrepancia fifo_empty_out en: %t", $time );
	 end
	 if( error_fifo_out !== error_fifo_out_synt ) begin
	    $display( "discrepancia error_fifo_out en: %t", $time );
	 end
      end
   end

   always @( posedge clk ) begin
      fifo_data_in <= fifo_data_in_n;
      fifo_write <= fifo_write_n;
      fifo_read <= fifo_read_n;
      reset <= reset_n;
   end
   
   initial begin
      $dumpfile( "000almost.vcd" );
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
      // INICIO DE PRUEBA DE ALMOST
      #5 reset_n = 1;
      fifo_data_in_n = $random;
      fifo_write_n = 0;
      fifo_read_n = 0;
      // LLENADO  DEL FIFO
      repeat( 8 ) begin
	 #2 
	 fifo_data_in_n = $random;
	 fifo_write_n = 1;
	 fifo_read_n = 0;
      end
      repeat( 8 ) begin
	 #2 
	 fifo_data_in_n = $random;
	 fifo_write_n = 0;
	 fifo_read_n = 1;
      end
      repeat( 2 ) begin
	 #2 
	 fifo_data_in_n = $random;
	 fifo_write_n = 0;
	 fifo_read_n = 0;
      end

      #2 $finish;
   end
endmodule // probador

      

   
