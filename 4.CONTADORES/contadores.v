module contadores(
					output reg [4:0] data,
					output wire valid,
					input [DATA_BITS-1:0] fifo_data_out0,
					input [DATA_BITS-1:0] fifo_data_out1,
					input [DATA_BITS-1:0] fifo_data_out2,
					input [DATA_BITS-1:0] fifo_data_out3,
					input req,
					input [1:0] idx,
					input [3:0] estado_FSM,
					input rst,
					input clk
);

	parameter DATA_BITS = 10;

	// Registros contadores \\
	reg [4:0] conteo0;
	reg [4:0] conteo1;
	reg [4:0] conteo2;
	reg [4:0] conteo3;

	// ÍNDICES \\
	parameter CERO = 2'b00;
	parameter UNO = 2'b01;
	parameter DOS = 2'b10;
	parameter TRES = 2'b11;

	// Lógica de salida del contador \\
	always @(negedge clk) 
	begin
		if (!rst) 
		begin
			conteo0 <= 'b0;
			conteo1 <= 'b0;
			conteo2 <= 'b0;
			conteo3 <= 'b0;
		end

		else if (rst)
		begin
			if (req)
			begin
				case (idx)
					CERO: 	data <= conteo0;
					UNO: 	data <= conteo1;
					DOS: 	data <= conteo2;
					TRES: 	data <= conteo3;
				endcase
			end
		end
	end

	// Lógica de validez de los datos \\
	assign valid = estado_FSM == 4'b0100 ? 1'b1 : 1'b0; 

	// Lógica de conteo de palabras para cada fifo \\
	
	always @(fifo_data_out0) 
	begin
		conteo0 <= conteo0 + 1'b1;
	end
	
	always @(fifo_data_out1) 
	begin
		conteo1 <= conteo1 + 1'b1;
	end
	
	always @(fifo_data_out2) 
	begin
		conteo2 <= conteo2 + 1'b1;
	end
	
	always @(fifo_data_out3) 
	begin
		conteo3 <= conteo3 + 1'b1;
	end

endmodule