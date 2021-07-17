module probador( output reg [9:0] data0_in, data1_in,
		 output reg [9:0] data2_in, data3_in,
		 output reg 	  push0, push1, push2, push3,
		 output reg 	  pop4, pop5, pop6, pop7,
		 output reg 	  clk, reset, init,
		 output reg [2:0] limit_low, limit_high );


   reg [9:0] 			  data0, data1, data2, data3;
   reg [2:0] 			  limitlow, limithigh;
   reg 				  push0_n, push1_n, push2_n, push3_n;
   reg 				  pop4_n, pop5_n, pop6_n, pop7_n;
   reg 				  reset_n, init_n;
   
   initial begin
      $dumpfile( "000graf.vcd" );
      $dumpvars( 0 );
   end

   initial begin
      clk = 0;
      reset_n = 0;
      init_n = 0;
      {data0, data1, data2, data3} = $random;
      limitlow = 1;
      limithigh = 7;
      {push0_n,push1_n,push2_n, push3_n} = 4'h0;
      {pop4_n, pop5_n, pop6_n, pop7_n} = 4'h0;
   end

   always begin
      #1 clk = !clk;
   end

   always @( posedge clk ) begin
      reset <= reset_n;
      init <= init_n;
      data0_in <= data0;
      data1_in <= data1;
      data2_in <= data2;
      data3_in <= data3;
      limit_low <= limitlow;
      limit_high <= limithigh;
      push0 <= push0_n;
      push1 <= push1_n;
      push2 <= push2_n;
      push3 <= push3_n;
      pop4 <= pop4_n;
      pop5 <= pop5_n;
      pop6 <= pop6_n;
      pop7 <= pop7_n;    
   end

   initial begin
      #15 reset_n = 1;
      #2 init_n = 1;
      limitlow = 3;
      limithigh = 7;
      #5; 
      repeat( 6 ) begin	 
	 init_n = 0;
	 data0[9:8] = 2'b00;
	 data0[7:0] = $random; 
	 push0_n = 1'b1; 
	 data1[9:8] = 2'b01;
	 data1[7:0] = $random; 
	 push1_n = 1'b1; 
	 data2[9:8] = 2'b10;
	 data2[7:0] = $random; 
	 push2_n = 1'b1; 
	 data3[9:8] = 2'b11;
	 data3[7:0] = $random; 
	 push3_n = 1'b1;
	 #2;	 
      end // repeat ( 6 )
      data0 = 'b0;
      data1 = 'b0;
      data2 = 'b0;
      data3 = 'b0;
      push0_n = 1'b0; 
      push1_n = 1'b0; 
      push2_n = 1'b0; 
      push3_n = 1'b0;
      
      #90 pop4_n = 1'b1;
      pop5_n = 1'b1;
      pop6_n = 1'b1;
      pop7_n = 1'b1;
      repeat( 4 ) begin
      #2 pop4_n = 1'b1;
      pop5_n = 1'b1;
      pop6_n = 1'b1;
      pop7_n = 1'b1;
      end
      #2 pop4_n = 1'b0;
      pop5_n = 1'b0;
      pop6_n = 1'b0;
      pop7_n = 1'b0;
      
      

      #100 $finish;
   end

endmodule // probador

