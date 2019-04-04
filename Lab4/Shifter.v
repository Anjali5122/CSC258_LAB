module Shifter(SW, KEY, LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	output [7:0] LEDR;
	wire [7:0] LoadVal, Q;
	wire  Load_n, ShiftRight, ASR, clk, reset_n;
	
	assign LoadVal = SW[7:0];
	assign reset_n = SW[9];
	assign Load_n = KEY[1];
	assign ShiftRight = KEY[2];
	assign ASR = KEY[3];
	assign clk = KEY[0];
	assign LEDR = Q;
	
	shifterBit s7(
		.out(Q[7]),
		.load_val(LoadVal),
		.in(ASR),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n)
	);
	
	shifterBit s6(
		.out(Q[6]),
		.load_val(LoadVal),
		.in(Q[7]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n)
	);
	
	shifterBit s5(
		.out(Q[5]),
		.load_val(LoadVal),
		.in(Q[6]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n)
	);
	
	shifterBit s4(
		.out(Q[4]),
		.load_val(LoadVal),
		.in(Q[5]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n)
	);
	
	shifterBit s3(
		.out(Q[3]),
		.load_val(LoadVal),
		.in(Q[4]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n)
	);
	
	shifterBit s2(
		.out(Q[2]),
		.load_val(LoadVal),
		.in(Q[3]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n)
	);
	
	shifterBit s1(
		.out(Q[1]),
		.load_val(LoadVal),
		.in(Q[2]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n)
	);
	
	shifterBit s0(
		.out(Q[0]),
		.load_val(LoadVal),
		.in(Q[1]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset_n(reset_n)
	);
endmodule
	



module shifterBit(out, load_val, in, shift, load_n, clk, reset_n);
	input load_val, in, shift, load_n, clk, reset_n;
	output out;
	wire w1, w2, out;
	
	mux2to1 M1(
		.x(out),
		.y(in),
		.s(shift),
		.m(w1)
	);
	
	mux2to1 M2(
		.x(load_val),
		.y(w1),
		.s(load_n),
		.m(w2)
	);

	flipflop F0(
		.d(w2),
		.q(out),
		.clock(clk),
		.reset_n(reset_n)
	);
endmodule
	

module flipflop(d, q, clock, reset_n);
	input d, clock, reset_n;
	output q;
	reg q;

	always @(posedge clock)
	begin
		if(reset_n == 1'b0)
			q <= 0;
		else
			q <= d;
	end
endmodule


module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x; 
endmodule
