module integrator
#(
	parameter DATA_WIDTH = 1,
	          M = 1
)(
	 input wire                         rst_i,
	 input wire                         clk_i,
	 input wire signed [DATA_WIDTH-1:0] data_i,
	output wire signed [DATA_WIDTH-1:0] data_o
);

	wire signed [DATA_WIDTH-1:0] adder;
	 reg signed [DATA_WIDTH-1:0] adder_ff [M-1:0];
	
	
	assign adder = data_i + data_o;
	assign data_o = adder_ff[M-1];


	genvar i;
	
	generate
	
		for (i = 0; i < M; i = i + 1) begin
		
			always @(posedge clk_i) begin
			
				if (~rst_i) begin
				
					adder_ff[i] <= 'b0;
				
				end else if (i == 0) begin
				
					adder_ff[i] <= adder;
				
				end else begin
				
					adder_ff[i] <= adder_ff[i-1];
				
				end
			
			end
		
		end
	
	endgenerate

endmodule