`timescale 1ns/1ps;
module cic_decimator_tb();

	localparam DATA_WIDTH = 12;
	localparam N = 7;
	localparam M = 1;

	 reg                         rst_i_i;
	 reg                         rst_o_i;
	 reg                         clk_i_i;
	 reg                         clk_o_i;
	wire signed [DATA_WIDTH-1:0] data_o;

	
	wire signed [11:0] generator_output;
	
	dds_generator dds_generator_inst
	(
		.rst_i(rst_i_i),
		.clk_i(clk_i_i),
		.freq_i(32'd21474836), // 5 khz
		.data_o(generator_output)
	);
	
	cic_decimator #(
		.DATA_WIDTH(DATA_WIDTH),
		.N(N),
		.M(M)
	) cic_decimator_inst (
		.rst_i_i(rst_i_i),
		.rst_o_i(rst_o_i),
		.clk_i_i(clk_i_i),
		.clk_o_i(clk_o_i),
		.data_i(generator_output),
		.data_o(data_o)
	);
	
	always #500 clk_i_i = ~clk_i_i;
	always #2500 clk_o_i = ~clk_o_i;
	
	initial begin
	
		rst_i_i = 1'b0;
		rst_o_i = 1'b0;
		clk_i_i = 1'b0;
		clk_o_i = 1'b0;
		
		#10000 rst_i_i = 1'b1;
		       rst_o_i = 1'b1;
	
	end

endmodule

