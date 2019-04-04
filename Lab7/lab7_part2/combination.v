module combination(go, clock, resetN, draw, colour_in, location_in, x_out, y_out, colour_out);
	input clock, resetN, go, draw;
	input [2:0] colour_in;
	input [6:0] location_in;
	output [7:0] x_out;
	output [6:0] y_out;
	output [2:0] colour_out;
	
	wire ld_x, ld_y, ld_c, plot, enable_i_x;
	
	controller c0(.go(go), .resetN(resetN), .clock(clock), .draw(draw), .ld_x(ld_x), .ld_y(ld_y), .ld_c(ld_c), .enable_i_x(enable_i_x), .plot(plot)
	);
	
	datapath d0(.location_in(location_in), .colour_in(colour_in), .clock(clock), .resetN(resetN), .enable_i_x(enable_i_x), .ld_x(ld_x), .ld_y(ld_y), .ld_c(ld_c), .x_out(x_out), .y_out(y_out), .colour_out(colour_out)
	);
	
endmodule