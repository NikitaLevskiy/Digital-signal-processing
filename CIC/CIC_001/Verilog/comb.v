module comb
#(
	parameter DATA_WIDTH = 1,
	          M = 1
)(
	 input wire                         rst_i,
	 input wire                         clk_i,
	 input wire signed [DATA_WIDTH-1:0] data_i,
	output reg  signed [DATA_WIDTH-1:0] data_o
);

	wire signed [DATA_WIDTH-1:0] adder;
	 reg signed [DATA_WIDTH-1:0] data_i_ff [M-1:0];


	assign adder = data_i - data_i_ff[M-1];


	genvar i;
	
	generate
	
		for (i = 0; i < M; i = i + 1) begin
		
			always @(posedge clk_i) begin
	
				if (~rst_i) begin
				
					data_i_ff[i] <= 'b0;
				
				end else if (i == 0) begin
				
					data_i_ff[i] <= data_i;
				
				end else begin
				
					data_i_ff[i] <= data_i_ff[i-1];
				
				end
			
			end
		
		end
	
	endgenerate
	
	
	always @(posedge clk_i) begin
	
		if (~rst_i)  begin
		
			data_o <= 'b0;
		
		end else begin
		
			data_o <= adder;
		
		end
	
	end
	
endmodule