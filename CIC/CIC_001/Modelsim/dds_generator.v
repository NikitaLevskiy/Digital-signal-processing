module dds_generator
(
	 input wire              rst_i,
	 input wire              clk_i,
	 input wire       [31:0] freq_i,
	output reg signed [11:0] data_o
);

	localparam DATA_WIDTH = 12;
	localparam ADDR_WIDTH = 8;
	localparam PHASE_WIDTH = 32;
	

	reg [PHASE_WIDTH-1:0] phase_acc;
	
	always @(posedge clk_i) begin
	
		if (~rst_i) begin
		
			phase_acc <= 'b0;
		
		end else begin
		
			phase_acc <= phase_acc + freq_i;
		
		end
	
	end
	
	
	wire [ADDR_WIDTH-1:0] address = phase_acc[PHASE_WIDTH-1:PHASE_WIDTH-ADDR_WIDTH];
	wire signed [DATA_WIDTH-1:0] rom_output;
	
	rom_dds_gen rom_dds_gen_inst (
		.address(address),
		.data_o(rom_output)
	);
	
	always @(posedge clk_i) begin
	
		if (~rst_i) begin
		
			data_o <= 'b0;
		
		end else begin
		
			data_o <= rom_output;
		
		end
	
	end

endmodule

module rom_dds_gen
(
	 input wire        [7:0] address,
	output reg signed [11:0] data_o
);

	always @(*) begin
	
		case (address)
		
			8'd0: data_o <= 12'd0;
			8'd1: data_o <= 12'd49;
			8'd2: data_o <= 12'd99;
			8'd3: data_o <= 12'd149;
			8'd4: data_o <= 12'd199;
			8'd5: data_o <= 12'd249;
			8'd6: data_o <= 12'd299;
			8'd7: data_o <= 12'd349;
			8'd8: data_o <= 12'd398;
			8'd9: data_o <= 12'd447;
			8'd10: data_o <= 12'd496;
			8'd11: data_o <= 12'd545;
			8'd12: data_o <= 12'd593;
			8'd13: data_o <= 12'd641;
			8'd14: data_o <= 12'd688;
			8'd15: data_o <= 12'd736;
			8'd16: data_o <= 12'd782;
			8'd17: data_o <= 12'd828;
			8'd18: data_o <= 12'd874;
			8'd19: data_o <= 12'd919;
			8'd20: data_o <= 12'd964;
			8'd21: data_o <= 12'd1008;
			8'd22: data_o <= 12'd1051;
			8'd23: data_o <= 12'd1094;
			8'd24: data_o <= 12'd1136;
			8'd25: data_o <= 12'd1178;
			8'd26: data_o <= 12'd1218;
			8'd27: data_o <= 12'd1258;
			8'd28: data_o <= 12'd1298;
			8'd29: data_o <= 12'd1336;
			8'd30: data_o <= 12'd1374;
			8'd31: data_o <= 12'd1411;
			8'd32: data_o <= 12'd1447;
			8'd33: data_o <= 12'd1482;
			8'd34: data_o <= 12'd1516;
			8'd35: data_o <= 12'd1549;
			8'd36: data_o <= 12'd1582;
			8'd37: data_o <= 12'd1613;
			8'd38: data_o <= 12'd1643;
			8'd39: data_o <= 12'd1673;
			8'd40: data_o <= 12'd1701;
			8'd41: data_o <= 12'd1729;
			8'd42: data_o <= 12'd1755;
			8'd43: data_o <= 12'd1780;
			8'd44: data_o <= 12'd1805;
			8'd45: data_o <= 12'd1828;
			8'd46: data_o <= 12'd1850;
			8'd47: data_o <= 12'd1871;
			8'd48: data_o <= 12'd1891;
			8'd49: data_o <= 12'd1909;
			8'd50: data_o <= 12'd1927;
			8'd51: data_o <= 12'd1943;
			8'd52: data_o <= 12'd1958;
			8'd53: data_o <= 12'd1972;
			8'd54: data_o <= 12'd1985;
			8'd55: data_o <= 12'd1997;
			8'd56: data_o <= 12'd2007;
			8'd57: data_o <= 12'd2016;
			8'd58: data_o <= 12'd2024;
			8'd59: data_o <= 12'd2031;
			8'd60: data_o <= 12'd2037;
			8'd61: data_o <= 12'd2041;
			8'd62: data_o <= 12'd2044;
			8'd63: data_o <= 12'd2046;
			8'd64: data_o <= 12'd2047;
			8'd65: data_o <= 12'd2046;
			8'd66: data_o <= 12'd2044;
			8'd67: data_o <= 12'd2041;
			8'd68: data_o <= 12'd2037;
			8'd69: data_o <= 12'd2031;
			8'd70: data_o <= 12'd2024;
			8'd71: data_o <= 12'd2016;
			8'd72: data_o <= 12'd2007;
			8'd73: data_o <= 12'd1997;
			8'd74: data_o <= 12'd1985;
			8'd75: data_o <= 12'd1972;
			8'd76: data_o <= 12'd1958;
			8'd77: data_o <= 12'd1943;
			8'd78: data_o <= 12'd1927;
			8'd79: data_o <= 12'd1909;
			8'd80: data_o <= 12'd1891;
			8'd81: data_o <= 12'd1871;
			8'd82: data_o <= 12'd1850;
			8'd83: data_o <= 12'd1828;
			8'd84: data_o <= 12'd1805;
			8'd85: data_o <= 12'd1780;
			8'd86: data_o <= 12'd1755;
			8'd87: data_o <= 12'd1729;
			8'd88: data_o <= 12'd1701;
			8'd89: data_o <= 12'd1673;
			8'd90: data_o <= 12'd1643;
			8'd91: data_o <= 12'd1613;
			8'd92: data_o <= 12'd1582;
			8'd93: data_o <= 12'd1549;
			8'd94: data_o <= 12'd1516;
			8'd95: data_o <= 12'd1482;
			8'd96: data_o <= 12'd1447;
			8'd97: data_o <= 12'd1411;
			8'd98: data_o <= 12'd1374;
			8'd99: data_o <= 12'd1336;
			8'd100: data_o <= 12'd1298;
			8'd101: data_o <= 12'd1258;
			8'd102: data_o <= 12'd1218;
			8'd103: data_o <= 12'd1178;
			8'd104: data_o <= 12'd1136;
			8'd105: data_o <= 12'd1094;
			8'd106: data_o <= 12'd1051;
			8'd107: data_o <= 12'd1008;
			8'd108: data_o <= 12'd964;
			8'd109: data_o <= 12'd919;
			8'd110: data_o <= 12'd874;
			8'd111: data_o <= 12'd828;
			8'd112: data_o <= 12'd782;
			8'd113: data_o <= 12'd736;
			8'd114: data_o <= 12'd688;
			8'd115: data_o <= 12'd641;
			8'd116: data_o <= 12'd593;
			8'd117: data_o <= 12'd545;
			8'd118: data_o <= 12'd496;
			8'd119: data_o <= 12'd447;
			8'd120: data_o <= 12'd398;
			8'd121: data_o <= 12'd349;
			8'd122: data_o <= 12'd299;
			8'd123: data_o <= 12'd249;
			8'd124: data_o <= 12'd199;
			8'd125: data_o <= 12'd149;
			8'd126: data_o <= 12'd99;
			8'd127: data_o <= 12'd49;
			8'd128: data_o <= 12'd0;
			8'd129: data_o <= -12'd50;
			8'd130: data_o <= -12'd100;
			8'd131: data_o <= -12'd150;
			8'd132: data_o <= -12'd200;
			8'd133: data_o <= -12'd250;
			8'd134: data_o <= -12'd300;
			8'd135: data_o <= -12'd350;
			8'd136: data_o <= -12'd399;
			8'd137: data_o <= -12'd448;
			8'd138: data_o <= -12'd497;
			8'd139: data_o <= -12'd546;
			8'd140: data_o <= -12'd594;
			8'd141: data_o <= -12'd642;
			8'd142: data_o <= -12'd689;
			8'd143: data_o <= -12'd737;
			8'd144: data_o <= -12'd783;
			8'd145: data_o <= -12'd829;
			8'd146: data_o <= -12'd875;
			8'd147: data_o <= -12'd920;
			8'd148: data_o <= -12'd965;
			8'd149: data_o <= -12'd1009;
			8'd150: data_o <= -12'd1052;
			8'd151: data_o <= -12'd1095;
			8'd152: data_o <= -12'd1137;
			8'd153: data_o <= -12'd1179;
			8'd154: data_o <= -12'd1219;
			8'd155: data_o <= -12'd1259;
			8'd156: data_o <= -12'd1299;
			8'd157: data_o <= -12'd1337;
			8'd158: data_o <= -12'd1375;
			8'd159: data_o <= -12'd1412;
			8'd160: data_o <= -12'd1448;
			8'd161: data_o <= -12'd1483;
			8'd162: data_o <= -12'd1517;
			8'd163: data_o <= -12'd1550;
			8'd164: data_o <= -12'd1583;
			8'd165: data_o <= -12'd1614;
			8'd166: data_o <= -12'd1644;
			8'd167: data_o <= -12'd1674;
			8'd168: data_o <= -12'd1702;
			8'd169: data_o <= -12'd1730;
			8'd170: data_o <= -12'd1756;
			8'd171: data_o <= -12'd1781;
			8'd172: data_o <= -12'd1806;
			8'd173: data_o <= -12'd1829;
			8'd174: data_o <= -12'd1851;
			8'd175: data_o <= -12'd1872;
			8'd176: data_o <= -12'd1892;
			8'd177: data_o <= -12'd1910;
			8'd178: data_o <= -12'd1928;
			8'd179: data_o <= -12'd1944;
			8'd180: data_o <= -12'd1959;
			8'd181: data_o <= -12'd1973;
			8'd182: data_o <= -12'd1986;
			8'd183: data_o <= -12'd1998;
			8'd184: data_o <= -12'd2008;
			8'd185: data_o <= -12'd2017;
			8'd186: data_o <= -12'd2025;
			8'd187: data_o <= -12'd2032;
			8'd188: data_o <= -12'd2038;
			8'd189: data_o <= -12'd2042;
			8'd190: data_o <= -12'd2045;
			8'd191: data_o <= -12'd2047;
			8'd192: data_o <= -12'd2048;
			8'd193: data_o <= -12'd2047;
			8'd194: data_o <= -12'd2045;
			8'd195: data_o <= -12'd2042;
			8'd196: data_o <= -12'd2038;
			8'd197: data_o <= -12'd2032;
			8'd198: data_o <= -12'd2025;
			8'd199: data_o <= -12'd2017;
			8'd200: data_o <= -12'd2008;
			8'd201: data_o <= -12'd1998;
			8'd202: data_o <= -12'd1986;
			8'd203: data_o <= -12'd1973;
			8'd204: data_o <= -12'd1959;
			8'd205: data_o <= -12'd1944;
			8'd206: data_o <= -12'd1928;
			8'd207: data_o <= -12'd1910;
			8'd208: data_o <= -12'd1892;
			8'd209: data_o <= -12'd1872;
			8'd210: data_o <= -12'd1851;
			8'd211: data_o <= -12'd1829;
			8'd212: data_o <= -12'd1806;
			8'd213: data_o <= -12'd1781;
			8'd214: data_o <= -12'd1756;
			8'd215: data_o <= -12'd1730;
			8'd216: data_o <= -12'd1702;
			8'd217: data_o <= -12'd1674;
			8'd218: data_o <= -12'd1644;
			8'd219: data_o <= -12'd1614;
			8'd220: data_o <= -12'd1583;
			8'd221: data_o <= -12'd1550;
			8'd222: data_o <= -12'd1517;
			8'd223: data_o <= -12'd1483;
			8'd224: data_o <= -12'd1448;
			8'd225: data_o <= -12'd1412;
			8'd226: data_o <= -12'd1375;
			8'd227: data_o <= -12'd1337;
			8'd228: data_o <= -12'd1299;
			8'd229: data_o <= -12'd1259;
			8'd230: data_o <= -12'd1219;
			8'd231: data_o <= -12'd1179;
			8'd232: data_o <= -12'd1137;
			8'd233: data_o <= -12'd1095;
			8'd234: data_o <= -12'd1052;
			8'd235: data_o <= -12'd1009;
			8'd236: data_o <= -12'd965;
			8'd237: data_o <= -12'd920;
			8'd238: data_o <= -12'd875;
			8'd239: data_o <= -12'd829;
			8'd240: data_o <= -12'd783;
			8'd241: data_o <= -12'd737;
			8'd242: data_o <= -12'd689;
			8'd243: data_o <= -12'd642;
			8'd244: data_o <= -12'd594;
			8'd245: data_o <= -12'd546;
			8'd246: data_o <= -12'd497;
			8'd247: data_o <= -12'd448;
			8'd248: data_o <= -12'd399;
			8'd249: data_o <= -12'd350;
			8'd250: data_o <= -12'd300;
			8'd251: data_o <= -12'd250;
			8'd252: data_o <= -12'd200;
			8'd253: data_o <= -12'd150;
			8'd254: data_o <= -12'd100;
			8'd255: data_o <= -12'd50;
		
		endcase
	
	end

endmodule