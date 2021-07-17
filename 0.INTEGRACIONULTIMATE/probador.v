module probador( input wire [9:0] fifo4_out, fifo5_out, 
		 input wire [9:0] fifo6_out, fifo7_out,
		 input wire [9:0] fifo4_out_synt, fifo5_out_synt, 
		 input wire [9:0] fifo6_out_synt, fifo7_out_synt,
		 output reg [9:0] fifo0_i, fifo1_i, fifo2_i, fifo3_i,
		 output reg [2:0] high_probador, low_probador,
		 output reg [1:0] idx,
		 output reg 	  push0, push1, push2, push3,
		 output reg 	  pop4, pop5, pop6, pop7,
		 output reg 	  reset, clk, init, req );


   reg [9:0] 			  fifo0_is, fifo1_is, fifo2_is, fifo3_is;
   reg [2:0] 			  high_probador_s, low_probador_s;
   reg 				  push0s, push1s, push2s, push3s;
   reg 				  pop4s, pop5s, pop6s, pop7s;
   reg 				  reset_n, init_s, req_s;
   reg 				  valid4, valid5, valid6, valid7;
   reg [1:0] 			  idx_s;
   
   //// ESTAS SALIDAS DEL PROBADOR SON SOLO AYUDAS VISUALES
   always @( posedge clk ) begin
      valid4 <= pop4;   
      valid5 <= pop5; 
      valid6 <= pop6;
      valid7 <= pop7;
   end
   

   always @( posedge clk ) begin
      high_probador <= high_probador_s;
      low_probador <= low_probador_s;
      init <= init_s;
      idx <= idx_s;
      req <= req_s;
      fifo0_i <= fifo0_is;
      fifo1_i <= fifo1_is;
      fifo2_i <= fifo2_is;
      fifo3_i <= fifo3_is;
      push0 <= push0s;
      push1 <= push1s;
      push2 <= push2s;
      push3 <= push3s;
      pop4 <= pop4s;
      pop5 <= pop5s;
      pop6 <= pop6s;
      pop7 <= pop7s;
      reset <= reset_n;
   end
   
   initial begin
      $dumpfile( "000normal.vcd" );
      $dumpvars( 0 );
   end

   initial begin
      fifo0_is = 0;
      fifo1_is = 0;
      fifo2_is = 0;
      fifo3_is = 0;
      push0s = 0;
      push1s = 0;
      push2s = 0;
      push3s = 0;
      pop4s = 0;
      pop5s= 0;
      pop6s= 0;
      pop7s= 0;
      clk = 0;
      reset_n = 0;
      init_s = 0;
      req_s = 0;
      idx_s = 0;
   end

   always begin
      #1 clk = !clk;
   end

   integer k = 0;
   initial begin
      //// PRUEBA 1 Y 2
      #15 reset_n = 1;
      #3 init_s = 1;
      low_probador_s = 1;
      high_probador_s = 5;
      #5
      low_probador_s = 2;
      high_probador_s = 7;    
      #10 init_s = 0;
      #2 low_probador_s = 3;
      high_probador_s = 6;  

      //// PRUEBA 3
      #10;
     repeat( 8 ) begin	
	 fifo0_is[9:8] = 2'b00 + k;
	 fifo0_is[7:0] = $random; 
	 push0s = 1'b1; 
	 fifo1_is[9:8] = 2'b00 + k;
	 fifo1_is[7:0] = $random; 
	 push1s = 1'b1; 
	 fifo2_is[9:8] = 2'b00 + k;
	 fifo2_is[7:0] = $random; 
	 push2s = 1'b1;
	 fifo3_is[9:8] = 2'b00 + k;
	 fifo3_is[7:0] = $random; 
	 push3s = 1'b1;
	 #2;
	 k = k + 1;
      end // 
      fifo0_is = 'b0;
      fifo1_is = 'b0;
      fifo2_is = 'b0;
      fifo3_is = 'b0;
      push0s = 1'b0; 
      push1s = 1'b0; 
      push2s = 1'b0; 
      push3s = 1'b0;
      
      #200;      
      #2 pop4s = 1'b1;
      #2 pop4s = 1'b0;
      #10;
      #2 pop5s = 1'b1;
      #2 pop5s = 1'b0;
      #10;
      #2 pop6s = 1'b1;
      #2 pop6s = 1'b0;
      #10;
      #2 pop7s = 1'b1;
      #2 pop7s = 1'b0;

      #2;
      
      repeat( 3 ) begin
      #2 pop4s = 1'b1;
      pop5s = 1'b1;
      pop6s = 1'b1;
      pop7s = 1'b1;
      end
      
      #2 pop4s = 1'b0;
      pop5s = 1'b0;
      pop6s = 1'b0;
      pop7s = 1'b0;
      
      #2 pop4s = 1'b1;
      #2 pop4s = 1'b0;
      #10;
      #2 pop5s = 1'b1;
      #2 pop5s = 1'b0;
      #10;
      #2 pop6s = 1'b1;
      #2 pop6s = 1'b0;
      #10;
      #2 pop7s = 1'b1;
      #2 pop7s = 1'b0;

      #40;
      
      repeat( 3 ) begin
      #2 pop4s = 1'b1;
      pop5s = 1'b1;
      pop6s = 1'b1;
      pop7s = 1'b1;
      end
      #2 pop4s = 1'b0;
      pop5s = 1'b0;
      pop6s = 1'b0;
      pop7s = 1'b0;

      #4
      #2 idx_s = 2'b00;
      req_s = 1;
      #2 req_s = 0;
      #2 idx_s = 2'b01;
      req_s = 1;
      #2 req_s = 0;
      #2 idx_s = 2'b10;
      req_s = 1;
      #2 req_s = 0;
      #2 idx_s = 2'b11;
      req_s = 1;
      #2 req_s = 0;


      # 20;
      //// PRUEBA 4
      repeat( 8 ) begin	
	 fifo0_is[9:8] = 2'b00 + k;
	 fifo0_is[7:0] = $random; 
	 push0s = 1'b1; 
	 fifo1_is[9:8] = 2'b00 + k;
	 fifo1_is[7:0] = $random; 
	 push1s = 1'b1; 
	 fifo2_is[9:8] = 2'b00 + k;
	 fifo2_is[7:0] = $random; 
	 push2s = 1'b1;
	 fifo3_is[9:8] = 2'b00 + k;
	 fifo3_is[7:0] = $random; 
	 push3s = 1'b1;
	 #2;
	 k = k + 1;
      end // 
      fifo0_is = 'b0;
      fifo1_is = 'b0;
      fifo2_is = 'b0;
      fifo3_is = 'b0;
      push0s = 1'b0; 
      push1s = 1'b0; 
      push2s = 1'b0; 
      push3s = 1'b0;

      #300;
            repeat( 7 ) begin	
	 fifo0_is[9:8] = 2'b00 + k;
	 fifo0_is[7:0] = $random; 
	 push0s = 1'b1; 
	 fifo1_is[9:8] = 2'b00 + k;
	 fifo1_is[7:0] = $random; 
	 push1s = 1'b1; 
	 fifo2_is[9:8] = 2'b00 + k;
	 fifo2_is[7:0] = $random; 
	 push2s = 1'b1;
	 //fifo3_is[9:8] = 2'b00 + k;
	 //fifo3_is[7:0] = $random; 
	 //push3s = 1'b1;
	 #2;
	 k = k + 1;
      end // 
      fifo0_is = 'b0;
      fifo1_is = 'b0;
      fifo2_is = 'b0;
      fifo3_is = 'b0;
      push0s = 1'b0; 
      push1s = 1'b0; 
      push2s = 1'b0; 
      push3s = 1'b0;
	
      #50
      repeat( 6 ) begin
      #2 pop4s = 1'b1;
      pop5s = 1'b1;
      pop6s = 1'b1;
      pop7s = 1'b1;
      end
      #2 pop4s = 1'b0;
      pop5s = 1'b0;
      pop6s = 1'b0;
      pop7s = 1'b0;

      
      #50
      repeat( 1 ) begin
      #2 pop4s = 1'b1;
      pop5s = 1'b1;
      pop6s = 1'b1;
      pop7s = 1'b1;
      end
      #2 pop4s = 1'b0;
      pop5s = 1'b0;
      pop6s = 1'b0;
      pop7s = 1'b0;

      repeat( 4 ) begin
       #2 pop4s = 1'b1;
      #2 pop4s = 1'b0;
      #10;
      #2 pop5s = 1'b1;
      #2 pop5s = 1'b0;
      #10;
      #2 pop6s = 1'b1;
      #2 pop6s = 1'b0;
      #10;
      #2 pop7s = 1'b1;
      #2 pop7s = 1'b0;
      end // repeat ( 4 )

      repeat( 3 ) begin
       #2 pop4s = 1'b1;
      #2 pop4s = 1'b0;
      #10;
      #2 pop5s = 1'b1;
      #2 pop5s = 1'b0;
      #10;
      #2 pop6s = 1'b1;
      #2 pop6s = 1'b0;
      #10;
      end

      #4;
      
      #2 idx_s = 2'b00;
      req_s = 1;
      #2 req_s = 0;
      #2 idx_s = 2'b01;
      req_s = 1;
      #2 req_s = 0;
      #2 idx_s = 2'b10;
      req_s = 1;
      #2 req_s = 0;
      #2 idx_s = 2'b11;
      req_s = 1;
      #2 req_s = 0;

      #100;
      
      k = 0;
      //// PRUEBA 5 Y 6
         repeat( 4 ) begin	
	 fifo0_is[9:8] = 2'b00 + k;
	 fifo0_is[7:0] = 8'haa; 
	 push0s = 1'b1; 
	 fifo1_is[9:8] = 2'b01 + k;
	 fifo1_is[7:0] = 8'hbb; 
	 push1s = 1'b1; 
	 fifo2_is[9:8] = 2'b10 + k;
	 fifo2_is[7:0] = 8'hcc; 
	 push2s = 1'b1;
	 fifo3_is[9:8] = 2'b11 + k;
	 fifo3_is[7:0] = 8'hdd; 
	 push3s = 1'b1;
	 #2;
	 k = k + 1;
      end // 
      fifo0_is = 'b0;
      fifo1_is = 'b0;
      fifo2_is = 'b0;
      fifo3_is = 'b0;
      push0s = 1'b0; 
      push1s = 1'b0; 
      push2s = 1'b0; 
      push3s = 1'b0;

      #200;
      
      repeat( 4 ) begin
      #2 pop4s = 1'b1;
      pop5s = 1'b1;
      pop6s = 1'b1;
      pop7s = 1'b1;
      end
      #2 pop4s = 1'b0;
      pop5s = 1'b0;
      pop6s = 1'b0;
      pop7s = 1'b0;


       #4;
      
      #2 idx_s = 2'b00;
      req_s = 1;
      #2 req_s = 0;
      #2 idx_s = 2'b01;
      req_s = 1;
      #2 req_s = 0;
      #2 idx_s = 2'b10;
      req_s = 1;
      #2 req_s = 0;
      #2 idx_s = 2'b11;
      req_s = 1;
      #2 req_s = 0;
      
      #200 $finish;
   end
endmodule // probador

      

   
