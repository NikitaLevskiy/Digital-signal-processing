module synchronizer
#(
	parameter DATA_WIDTH = 1,
	          ORDER = 2
)(
	 input wire                         rst_i,
	 input wire                         clk_i,
	 input wire signed [DATA_WIDTH-1:0] data_i,
	output wire signed [DATA_WIDTH-1:0] data_o
);

	genvar i;
	
	generate
	
		reg signed [DATA_WIDTH-1:0] synch [ORDER-1:0];
	
		for (i = 0; i < ORDER; i = i + 1) begin
		
			always @(posedge clk_i) begin
			
				if (~rst_i) begin
				
					synch[i] <= 'b0;
				
				end else if (i == 0) begin
				
					synch[i] <= data_i;
				
				end else begin
				
					synch[i] <= synch[i-1];
				
				end
			
			end
		
		end
		
		assign data_o = synch[ORDER-1];
	
	endgenerate

endmodule