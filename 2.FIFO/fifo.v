`include "ram.v"

module fifo #( parameter DATA_BITS = 10,
	       parameter ADDR_BITS = 3 )
             ( output wire [DATA_BITS-1:0] fifo_data_out,
	       output reg 		  fifo_full_out, fifo_empty_out,
	       output wire 		  error_fifo_out,
	       input wire [DATA_BITS-1:0] fifo_data_in,
	       input wire [ADDR_BITS-1:0] high_limit, low_limit,
	       input wire 		  fifo_write, fifo_read, clk, reset );

   wire [ADDR_BITS-1:0]  write_ptr, read_ptr;
   reg [ADDR_BITS-1:0]	 write_ptr_r, read_ptr_r;
   reg 			 error_fifo_write, error_fifo_read;
   
			 
   
   always @( posedge clk ) begin
      if( !reset ) begin
	 fifo_empty_out <= 1;
      end
      else begin
	 if( write_ptr == read_ptr ) begin
	    fifo_empty_out <= 1;
	 end
	 else if( write_ptr > read_ptr ) begin
	    
      
   /* MEMORIA DEL FIFO DUAL PORT */
   ram #( DATA_BITS, ADDR_BITS )
     MEM( fifo_data_out, fifo_data_in, write_ptr, 
	  read_ptr, fifo_write, fifo_read, clk );

   /////////////////////////////////////////////////////
   ///////////////  WRITE/READ LOGIC  //////////////////
   /////////////////////////////////////////////////////
   always @( posedge clk ) begin: WRITE_POINTER_LOGIC
      if( !reset ) begin
	 write_ptr_r <= 0;
      end
      else begin
	 if( fifo_write ) begin
	    write_ptr_r <= write_ptr_r + 1;
	 end
	 else begin
	    write_ptr_r <= write_ptr_r;
	 end
      end // else: !if( !reset )
   end // always @ ( posedge clk )
   

   always @( posedge clk ) begin: READ_POINTER_LOGIC
      if( !reset ) begin
	 read_ptr_r <= 0;
      end
      else begin
	 if( fifo_read ) begin
	    read_ptr_r <= read_ptr_r + 1;
	 end
	 else begin
	    read_ptr_r <= read_ptr_r;
	 end
      end // else: !if( !reset )
   end // always @ ( posedge clk )
   
   assign write_ptr = write_ptr_r;
   assign read_ptr = read_ptr_r;
   /////////////////////////////////////////////////////// 	    
   ///////////////////////////////////////////////////////

   ///////////////////////////////////////////////////////
   //////////////////    ERROR LOGIC     /////////////////
   ///////////////////////////////////////////////////////
   always @( posedge clk ) begin
      if( reset == 0 ) begin
	 error_fifo_write <= 0;
      end
      else begin
	 if( ( write_ptr == read_ptr - 1 ) && fifo_write ) begin
	    error_fifo_write <= 1;
	 end
	 else begin
	    error_fifo_write <= error_fifo_write;
	 end
      end
   end
   always @( posedge clk ) begin
      if( !reset ) begin
	 error_fifo_read <= 0;
      end
      else begin
	 if( ( write_ptr == read_ptr ) && fifo_read ) begin
	    error_fifo_read <= 1;
	 end
	 else begin
	    error_fifo_read <= error_fifo_read;
	 end
      end // else: !if( !reset )     
   end // always @ ( posedge clk )

   assign error_fifo_out = error_fifo_write | error_fifo_read;
   ///////////////////////////////////////////////////////
   ///////////////////////////////////////////////////////

   
endmodule
   
