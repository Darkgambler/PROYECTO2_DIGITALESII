module probador #( parameter CBITS = 5 ) 
                 ( output reg push0, push1, push2, push3,
		   output reg 		  idle, req, clk, reset,
		   output reg [1:0] 	  idx,
		   input wire [CBITS-1:0] counter_out, counter_out_synt,
		   input wire 		  valid_out, valid_out_synt );

   reg [3:0] 			  all_pushes;

   always @( posedge clk ) begin
      if( counter_out != counter_out_synt ) begin
	 $display( "discrepancia counter_outs en %t", $time );
      end
      if( valid_out != valid_out_synt ) begin
	 $display( "discrepancia valid_outs en %t", $time );
      end
   end // always @ ( posedge clk )
   
      
   always @( * ) begin
      push0 = all_pushes[0];
      push1 = all_pushes[1];
      push2 = all_pushes[2];
      push3 = all_pushes[3];
   end

   initial begin
      $dumpfile( "000contador.vcd" );
      $dumpvars( 0 );
   end

   initial begin
      clk = 1'b0;
      reset = 1'b0;
      idle = 1'b0;
      req = 1'b0;
      idx = 2'b00;
      all_pushes = 4'b0000;
   end

   always begin
      #1 clk = !clk;
   end

   initial begin
      #8 reset = 1'b1;

      // INGRESA 1 DATO EN EL FIFO0
      #2 all_pushes = 4'b0001;
      // INGRESA 2 DATOS EN EL FIFO1
      repeat( 2 ) begin
	 #2 all_pushes = 4'b0010;
      end
      // INGRESA 3 DATOS EN EL FIFO2
      repeat( 3 ) begin
	 #2 all_pushes = 4'b0100;
      end
      // INGRESA 4 DATOS EN EL FIFO3
      repeat( 4 ) begin
	 #2 all_pushes = 4'b1000;
      end
      // DEJA DE INGRESAR DATOS EN LOS FIFOS
      #2 all_pushes = 4'b0000;

      // ACTIVA REQ IDX PERO EL IDLE ES 0
      // POR LO QUE NO DEBE OBTENER VALID
      #5 req = 1'b1;
      idx = 2'b11;

      // ACTIVA REQ CON VARIOS IDX Y IDLE ES 1
      // POR LO QUE SE DEBE MOSTRAR EL CONTEO
      // DEL CONTADOR PEDIDO Y ADEMAS EL VALID ES 1
      #5 req = 1'b1;
      idle = 1'b1;
      idx = 2'b11;
      #2 req = 1'b1;
      idle = 1'b1;
      idx = 2'b10;
      #2 req = 1'b1;
      idle = 1'b1;
      idx = 2'b01;
      #2 req = 1'b1;
      idle = 1'b1;
      idx = 2'b00;

      // EL ESTADO IDLE YA NO ES 1 POR LO QUE NO
      // SE PUEDEN OBTENER DATOS DE LOS CONTADORES
      #2 idle = 1'b0;
      
      //INGRESAMOS 10 DATOS EN EL FIFO0  
      repeat( 10 ) begin
	 #2 all_pushes = 4'b0001;
      end
      // DEJA DE INGRESAR DATOS A LOS FIFOS
      #2 all_pushes = 4'b0000;
      
      // ACTIVA REQ CON VARIOS IDX Y IDLE ES 1
      // POR LO QUE SE DEBE MOSTRAR EL CONTEO
      // DEL CONTADOR PEDIDO Y ADEMAS EL VALID ES 1
      #4 req = 1'b1;
      idle = 1'b1;
      idx = 2'b11;
      #2 req = 1'b1;
      idle = 1'b1;
      idx = 2'b10;
      #2 req = 1'b1;
      idle = 1'b1;
      idx = 2'b01;
      #2 req = 1'b1;
      idle = 1'b1;
      idx = 2'b00;
     
      #10 $finish;
   end // initial begin
   
endmodule // probador

      
   
      
