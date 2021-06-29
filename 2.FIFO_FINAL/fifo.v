`include "ram.v"

module fifo #( parameter DATA_BITS = 10,
	       parameter ADDR_BITS = 3 )
             ( output wire [DATA_BITS-1:0] fifo_data_out,
	       output reg 		  fifo_full_out, fifo_empty_out,
	       output reg 		  error_fifo_out,
	       input wire [DATA_BITS-1:0] fifo_data_in,
	       input wire [ADDR_BITS-1:0] high_limit, low_limit,
	       input wire 		  fifo_write, fifo_read, clk, reset );

   parameter 		 SIZE = 2 ** ADDR_BITS;
   wire [ADDR_BITS-1:0]  write_ptr, read_ptr;
   reg [ADDR_BITS-1:0]	 write_ptr_r, read_ptr_r;
   reg [SIZE-1:0] 	 vector; // GRAN IDEA PARA EL FIFO
   wire 		 full, empty;

   assign full = &vector;
   assign empty = ~(|vector);
   assign read_ptr = read_ptr_r;
   assign write_ptr = write_ptr_r;
     
   /* MEMORIA DEL FIFO DUAL PORT */
   ram #( DATA_BITS, ADDR_BITS )
   MEM( fifo_data_out, fifo_data_in, write_ptr, 
	read_ptr, fifo_write, fifo_read, clk );

   /* SI FULL == EMPTY == 0 ES OPERACION NORMAL
    * LO QUE QUIERE DECIR QUE HAY AL MENOS UN
    * ESPACIO DE LA MEMORIA LLENO Y PERO NO TODA 
    * LA MEMORIA LLENA.
    * WRITE_PTR VA POR DELANTE SIEMPRE POR LO QUE SI
    * WRITE_PTR < READ_PTR SIGNIFICA QUE WRITE_PTR
    * YA SOBREPASO EL MAXIMO DE LA MEMORIA QUE EN ESTE
    * CASO ES 7.
    */
   
   always @( * ) begin: ALMOST_FULL_LOGIC
      if( high_limit == 1'b0 ) begin
	 fifo_full_out = full;
      end
      else begin
	 if( write_ptr - read_ptr >= high_limit ) begin
	    fifo_full_out = 1'b1;
	 end
	 else begin
	    if( full ) begin
	       fifo_full_out = 1'b1;
	    end
	    else begin
	       fifo_full_out = 1'b0;
	    end
	 end // else: !if( write_ptr - read_ptr >= high_limit )
      end
   end
   
   always @( * ) begin: ALMOST_EMPTY_LOGIC
      if( write_ptr - read_ptr <= low_limit ) begin
	 if( full ) begin
	    fifo_empty_out = 1'b0;
	 end
	 else begin
	    fifo_empty_out = 1'b1;
	 end
      end
      else begin
	 fifo_empty_out = 1'b0;
      end
   end
   
      
   always @( posedge clk ) begin: ERROR_LOGIC
      if( !reset ) begin
	 error_fifo_out <= 1'b0;
      end
      else begin
	 if( write_ptr == read_ptr ) begin
	    if( (empty && fifo_read) || 
		(full && fifo_write && !fifo_read) ) begin
	       error_fifo_out <= 1'b1;
	    end
	    else begin
	       error_fifo_out <= error_fifo_out;
	    end
	 end
	 else begin
	    error_fifo_out <= error_fifo_out;
	 end // else: !if( write_ptr == read_ptr )
      end // else: !if( !reset )
   end
	    

   /// CORAZON DE LA VERSION 2 DEL FIFO, LA GRAN IDEA ////
   always @( posedge clk ) begin: VECTOR_LOGIC
      if( !reset ) begin
	 vector <= 'b0;
      end
      else begin
	 if( fifo_write && fifo_read ) begin
	    if( write_ptr == read_ptr ) begin
	       vector[write_ptr] <= 1'b1;
	    end
	    else begin
	       vector[write_ptr] <= 1'b1;
	       vector[read_ptr] <= 1'b0;
	    end
	 end
	 else if( fifo_write && !fifo_read ) begin
	    vector[write_ptr] <= 1'b1;
	 end
	 else if( !fifo_write && fifo_read ) begin
	    vector[read_ptr] <= 1'b0;	    
	 end
	 else begin
	    vector <= vector;
	 end
      end
   end

   //////// LOGICA DE LOS PUNTEROS READ AND WRITE /////
   always @( posedge clk ) begin: POINTER_LOGIC
      if( !reset ) begin
	 write_ptr_r <= 'b0;
	 read_ptr_r <= 'b0;
      end
      else begin
	 if( fifo_write ) begin
	    write_ptr_r <= write_ptr_r + 1'b1;
	 end
	 else begin
	    write_ptr_r <= write_ptr_r;
	 end
	 if( fifo_read ) begin
	    read_ptr_r <= read_ptr_r + 1'b1;
	 end
	 else begin
	    read_ptr_r <= read_ptr_r;
	 end
      end // else: !if( !reset )
   end // always @ ( posedge clk )
   
   

endmodule
