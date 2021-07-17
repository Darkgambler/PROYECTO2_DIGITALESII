module Xmux( output reg [9:0] fifo4, fifo5, fifo6, fifo7,
	    input wire [9:0] data_inter,
	    input wire [1:0] destino );

   always @( * ) begin
      fifo4 = 0;
      fifo5 = 0;
      fifo6 = 0;
      fifo7 = 0;
      if( destino == 2'b00 ) begin
	 fifo4 = data_inter;
      end
      else if( destino == 2'b01 ) begin
	 fifo5 = data_inter;
      end
      else if( destino == 2'b10 ) begin
	 fifo6 = data_inter;
      end
      else begin
	 fifo7 = data_inter;
      end
   end // always @ ( * )

endmodule // mux


   
