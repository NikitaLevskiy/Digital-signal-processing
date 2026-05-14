module fir_filter
#(
	parameter DATA_WIDTH = 29,
	          ORDER = 31
)(
	 input logic                         rst_i,
	 input logic                         clk_i,
	 input logic signed [DATA_WIDTH-1:0] data_i,
	output logic signed [DATA_WIDTH-1:0] data_o
);

	localparam COEF_WIDTH = 24;
	localparam ROM_ADDR_WIDTH = 3;
	
	localparam signed [COEF_WIDTH-1:0] h [ORDER:0] = {
		24'd6, -24'd6, 24'd8, -24'd11, 24'd15, -24'd21, 24'd28, -24'd36,
		24'd46, -24'd57, 24'd70, -24'd86, 24'd110, -24'd145, 24'd211, -24'd339,
		24'd636, -24'd339, 24'd211, -24'd145, 24'd110, -24'd86, 24'd70, -24'd57,
		24'd46, -24'd36, 24'd28, -24'd21, 24'd15, -24'd11, 24'd8, -24'd6
	};
	
	
	genvar i;
	
	generate
	
		logic signed [DATA_WIDTH-1:0] data_i_ff [ORDER-1:0];
	
		for (i = 0; i < ORDER; i = i + 1) begin
		
			always_ff @(posedge clk_i) begin
			
				if (~rst_i) begin
				
					data_i_ff[i] <= 'd0;
				
				end else if (i == 0) begin
				
					data_i_ff[i] <= data_i;
				
				end else begin
				
					data_i_ff[i] <= data_i_ff[i-1];
				
				end
			
			end
		
		end
		
		
		logic signed     [COEF_WIDTH-1:0] rom [ORDER:0];
		logic        [ROM_ADDR_WIDTH-1:0] address = 3'b000;
		
		for (i = 0; i <= ORDER; i = i + 1) begin
		
			rom #(
				.VALUE(h[i])
			) rom_inst (
				.rst_i(rst_i),
				.clk_i(clk_i),
				.address(address),
				.data_o(rom[i])
			);
		
		end
		
		
		logic signed [DATA_WIDTH+COEF_WIDTH-1:0] mul [ORDER:0];
		
		for (i = 0; i <= ORDER; i = i + 1) begin
		
			always_comb begin
			
				if (i == 0) begin
				
					mul[i] = data_i * rom[i];
				
				end else begin
				
					mul[i] = data_i_ff[i-1] * rom[i];
				
				end
			
			end
		
		end
		
		
		logic signed [DATA_WIDTH+COEF_WIDTH-1:0] adder [ORDER-1:0];
		
		for (i = 0; i < ORDER; i = i + 1) begin
		
			always_comb begin
			
				if (i == 0) begin
				
					adder[i] = mul[i] + mul[i+1];
				
				end else begin
				
					adder[i] = adder[i-1] + mul[i+1];
				
				end
			
			end
		
		end
		
		
		always_ff @(posedge clk_i) begin
		
			if (~rst_i) begin
			
				data_o <= 'd0;
			
			end else begin
			
				data_o <= adder[ORDER-1][DATA_WIDTH+COEF_WIDTH-1:COEF_WIDTH];
			
			end
		
		end
	
	endgenerate

endmodule

