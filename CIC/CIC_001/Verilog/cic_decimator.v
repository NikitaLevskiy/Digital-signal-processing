module cic_decimator
#(
	parameter DATA_WIDTH = 30,
	          N = 7,
			  M = 1
)(
	 input wire                         rst_i,
	 input wire                         clk_i,
	 input wire signed [DATA_WIDTH-1:0] data_i,
	output wire signed [DATA_WIDTH-1:0] data_o
);

	localparam SYNCH_ORDER = 2;
	

	genvar i;
	
	generate
	
		wire signed [DATA_WIDTH-1:0] integrator [N-1:0];
	
		for (i = 0; i < N; i = i + 1) begin
		
			if (i == 0) begin
			
				integrator #(
					.DATA_WIDTH(DATA_WIDTH),
					.M(M)
				) integrator_inst (
					.rst_i(rst_i),
					.clk_i(clk_i),
					.data_i(data_i),
					.data_o(integrator[i])
				);
			
			end else begin
			
				integrator #(
					.DATA_WIDTH(DATA_WIDTH),
					.M(M)
				) integrator_inst (
					.rst_i(rst_i),
					.clk_i(clk_i),
					.data_i(integrator[i-1]),
					.data_o(integrator[i])
				);
			
			end
		
		end
		
		
		wire signed [DATA_WIDTH-1:0] synch_input, synch_output;
		assign synch_input = integrator[N-1];
		
		synchronizer #(
			.DATA_WIDTH(DATA_WIDTH),
			.ORDER(SYNCH_ORDER)
		) synchronizer_inst (
			.data_i(synch_input),
			.data_o(synch_output)
		);
		
		
		wire signed [DATA_WIDTH-1:0] comb [N-1:0];
		
		for (i = 0; i < N; i = i + 1) begin
		
			if (i == 0) begin
			
				comb #(
					.DATA_WIDTH(DATA_WIDTH),
					.M(M)
				) comb_inst (
					.rst_i(rst_i),
					.clk_i(clk_i),
					.data_i(synch_output),
					.data_o(comb[i])
				);
			
			end else begin
			
				comb #(
					.DATA_WIDTH(DATA_WIDTH),
					.M(M)
				) comb_inst (
					.rst_i(rst_i),
					.clk_i(clk_i),
					.data_i(comb[i-1]),
					.data_o(comb[i])
				);
			
			end
		
		end
	
	endgenerate

endmodule