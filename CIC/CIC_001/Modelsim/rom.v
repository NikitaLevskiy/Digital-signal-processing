module rom
#(
	parameter VALUE = 0
)(
	 input wire               rst_i,
	 input wire               clk_i,
	 input wire         [2:0] address,
	output reg  signed [23:0] data_o
);

	reg signed [23:0] rom;


	always @(*) begin
	
		case (address)
		
			3'b000: rom <= VALUE;
			3'b001: rom <= 24'd0;
			3'b010: rom <= 24'd0;
			3'b011: rom <= 24'd0;
			3'b100: rom <= 24'd0;
			3'b101: rom <= 24'd0;
			3'b110: rom <= 24'd0;
			3'b111: rom <= 24'd0;
		
		endcase
	
	end
	
	always @(posedge clk_i) begin
	
		if (~rst_i) begin
		
			data_o <= 'd0;
		
		end else begin
		
			data_o <= rom;
		
		end
	
	end

endmodule