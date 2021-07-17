module machine( output reg reset_out, idle_out,
		output reg [2:0] limit_low_out, limit_high_out,
		input wire [2:0] limit_low, limit_high,
		input wire 	 clk, reset, init, emptys );

   reg [3:0] 				state, next_state;
   
   parameter 				RESET = 4'b0001;
   parameter 				INIT = 4'b0010;
   parameter 				IDLE = 4'b0100;
   parameter 				ACTIVE = 4'b1000;

   always @( posedge clk ) begin: STATE_LOGIC
      state <= next_state;
   end

   always @( * ) begin: NEXT_STATE_LOGIC
      case( state )
	 RESET:
	   if( !reset ) begin
	      next_state = RESET;
	   end
	   else begin
	      next_state = INIT;
	   end
	 INIT:
	   if( !reset ) begin
	      next_state = RESET;
	   end
	   else begin
	      if( init ) begin
		 next_state = INIT;
	      end
	      else begin
		 next_state = IDLE;
	      end
	   end 
	 IDLE: //4
	   if( !reset ) begin
	      next_state = RESET;
	   end
	   else begin
	      if( init ) begin
		 next_state = INIT;
	      end
	      else begin
		 if( emptys ) begin
		    next_state = IDLE;
		 end
		 else begin
		    next_state = ACTIVE;
		 end
	      end // else: !if( init )
	   end // else: !if( !reset )
	 ACTIVE:
	   if( !reset ) begin
	      next_state = RESET;
	   end
	   else begin
	      if( init ) begin
		 next_state = INIT;
	      end
	      else begin
		 if( emptys ) begin
		    next_state = IDLE;
		 end
		 else begin
		    next_state = ACTIVE;
		 end
	      end // else: !if( init )
	   end	   
	 default: next_state = RESET;
      endcase // case ( state )
   end // always @ ( * )
   

   always @( posedge clk ) begin
      if( init ) begin
	 limit_low_out <= limit_low;
	 limit_high_out <= limit_high;
      end
      else begin
	 limit_low_out <= limit_low_out;
	 limit_high_out <= limit_high_out;
      end
   end
   
	      
   always @( * ) begin: OUTPUTS_LOGIC
      if( state == RESET ) begin //1
	 reset_out = 1'b0;
	 idle_out = 1'b0;
	 //limit_low_out = 'h0;
	 //limit_high_out = 'h0;
      end
      else if( state == INIT ) begin //2
	 //limit_low_out = limit_low;
	 //limit_high_out = limit_high;
	 idle_out = 1'b0;
	 if( init ) begin
	    reset_out = 1'b0;
	 end
	 else begin
	    reset_out = 1'b1;
	 end
      end
      else if( state == IDLE ) begin //4
	 //limit_low_out = limit_low;
	 //limit_high_out = limit_high;
	 reset_out = 1'b1;
	 idle_out = 1'b1;
      end
      else begin //8
	 //limit_low_out = limit_low;
	 //limit_high_out = limit_high;
	 reset_out = 1'b1;
	 idle_out = 1'b0;
      end
   end // block: OUTPUTS_LOGIC

endmodule 

      
	 
