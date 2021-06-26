module probador #( parameter DATA_BITS = 8,
		   parameter ADDR_BITS = 6 )
                 ( output reg [DATA_BITS-1:0] data_in, 
		   output reg [ADDR_BITS-1:0] addr_write, addr_read,
		   output reg 		      write, read, clk,
		   input wire [DATA_BITS-1:0] data_out, data_out_synt );

   integer 				      k;

   always @( posedge clk ) begin: VERIFICADOR_OUTPUTS
      if( data_out !== data_out_synt ) begin
	 $display( "Discrepcancia entre salidas en %t", $time );
      end
   end
   
   
   initial begin
      $dumpfile( "000graf.vcd" );
      $dumpvars( 0 );
   end

   initial begin
      data_in = 0;
      addr_write = 0;
      addr_read = 0;
      write = 0;
      read = 0;
      clk = 0;
   end

   always begin
      #1 clk = !clk;
   end

   initial begin
      #2 data_in = 255;
      addr_write = 0;
      write = 1;
      for( k = 0; k < 25; k = k + 1 ) begin
	 #2 data_in = $random;
	 addr_write = k+1;
	 addr_read = k;
	 read = 1;
	 write = 1;
      end
      #25 $finish;
   end
endmodule // probador

      
