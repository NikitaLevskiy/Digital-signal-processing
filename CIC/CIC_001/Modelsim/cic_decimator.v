module cic_decimator
#(
	parameter DATA_WIDTH = 12,
	          N = 7,
			  M = 1
)(
	 input wire                         rst_i_i,
	 input wire                         rst_o_i,
	 input wire                         clk_i_i,
	 input wire                         clk_o_i,
	 input wire signed [DATA_WIDTH-1:0] data_i,
	output wire signed [DATA_WIDTH-1:0] data_o
);

	localparam CIC_FILTER_DATA_WIDTH = 29;
	localparam SYNCH_ORDER = 2;
	localparam FIR_CF_ORDER = 31;
	

	genvar i;
	
	generate
	
		wire signed [CIC_FILTER_DATA_WIDTH-1:0] integrator [N-1:0];
		wire signed [CIC_FILTER_DATA_WIDTH-1:0] integrator_input;
		
		assign integrator_input = {{CIC_FILTER_DATA_WIDTH-DATA_WIDTH{data_i[DATA_WIDTH-1]}}, data_i};
	
		for (i = 0; i < N; i = i + 1) begin
		
			if (i == 0) begin
			
				integrator #(
					.DATA_WIDTH(CIC_FILTER_DATA_WIDTH),
					.M(M)
				) integrator_inst (
					.rst_i(rst_i_i),
					.clk_i(clk_i_i),
					.data_i(integrator_input),
					.data_o(integrator[i])
				);
			
			end else begin
			
				integrator #(
					.DATA_WIDTH(CIC_FILTER_DATA_WIDTH),
					.M(M)
				) integrator_inst (
					.rst_i(rst_i_i),
					.clk_i(clk_i_i),
					.data_i(integrator[i-1]),
					.data_o(integrator[i])
				);
			
			end
		
		end
		
		
		wire signed [CIC_FILTER_DATA_WIDTH-1:0] synch_input, synch_output;
		assign synch_input = integrator[N-1];
		
		synchronizer #(
			.DATA_WIDTH(CIC_FILTER_DATA_WIDTH),
			.ORDER(SYNCH_ORDER)
		) synchronizer_inst (
			.rst_i(rst_o_i),
			.clk_i(clk_o_i),
			.data_i(synch_input),
			.data_o(synch_output)
		);
		
		
		wire signed [CIC_FILTER_DATA_WIDTH-1:0] comb [N-1:0];
		wire signed [CIC_FILTER_DATA_WIDTH-1:0] comb_input = synch_output;
		
		for (i = 0; i < N; i = i + 1) begin
		
			if (i == 0) begin
			
				comb #(
					.DATA_WIDTH(CIC_FILTER_DATA_WIDTH),
					.M(M)
				) comb_inst (
					.rst_i(rst_o_i),
					.clk_i(clk_o_i),
					.data_i(comb_input),
					.data_o(comb[i])
				);
			
			end else begin
			
				comb #(
					.DATA_WIDTH(CIC_FILTER_DATA_WIDTH),
					.M(M)
				) comb_inst (
					.rst_i(rst_o_i),
					.clk_i(clk_o_i),
					.data_i(comb[i-1]),
					.data_o(comb[i])
				);
			
			end
		
		end
		
		
		wire signed [CIC_FILTER_DATA_WIDTH-1:0] fir_cf_input, fir_cf_output;
		assign fir_cf_input = comb[N-1];
		
		fir_filter #(
			.DATA_WIDTH(CIC_FILTER_DATA_WIDTH),
			.ORDER(FIR_CF_ORDER)
		) fir_compensation_filter_inst (
			.rst_i(rst_o_i),
			.clk_i(clk_o_i),
			.data_i(fir_cf_input),
			.data_o(fir_cf_output)
		);
		
		assign data_o = fir_cf_output[DATA_WIDTH-1:0];
	
	endgenerate

endmodule