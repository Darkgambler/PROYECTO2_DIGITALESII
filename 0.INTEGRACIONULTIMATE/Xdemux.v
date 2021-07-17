module Xdemux( output reg [9:0] data_inter,
	      output reg [1:0] destino,
	      input wire [9:0] fifo0, fifo1, fifo2, fifo3,
	      input wire [1:0] demux,
	      input wire       reset, clk );
      
   
   
   always @( * ) begin
      if( demux == 2'b00 ) begin
	 data_inter = fifo0;
	 destino = fifo0[9:8];
      end
      else if( demux == 2'b01 ) begin
	 data_inter = fifo1;
	 destino = fifo1[9:8];
      end
      else if( demux == 2'b10 ) begin
	 data_inter = fifo2;
	 destino = fifo2[9:8];
      end
      else begin
	 data_inter = fifo3;
	 destino = fifo3[9:8];
      end
   end // always @ ( * )

endmodule // misc2
