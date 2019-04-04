module Lab4Part3(LEDR, SW, KEY);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	
	eightBitShift eight(.q(LEDR[7:0]),
							  .load_val(SW[7:0]),
							  .ASR(KEY[3]),
							  .load(KEY[1]),
							  .shift(KEY[2]),
							  .c(KEY[0]),
							  .rs(SW[9])
							  );
endmodule

module eightBitShift(q, load_val, ASR, load, shift, c, rs);
	input [7:0] load_val;
	input ASR, load, shift, c, rs;
	output [7:0] q;
	wire wasr;
	
	mux2to1 whetherASR(.m(wasr), .x(1'b0), .y(q[7]), .s(ASR));
	
	shifter s7(.out(q[7]),
				  .LoadVal(load_val[7]),
				  .Load_n(load),
				  .ShiftRight(shift),
				  .in(wasr),
				  .clk(c),
				  .reset(rs)
				  );
				  
	shifter s6(.out(q[6]),
				  .LoadVal(load_val[6]),
				  .Load_n(load),
				  .ShiftRight(shift),
				  .in(q[7]),
				  .clk(c),
				  .reset(rs)
				  );
				  
	shifter s5(.out(q[5]),
				  .LoadVal(load_val[5]),
				  .Load_n(load),
				  .ShiftRight(shift),
				  .in(q[6]),
				  .clk(c),
				  .reset(rs)
				  );
				  
	shifter s4(.out(q[4]),
				  .LoadVal(load_val[4]),
				  .Load_n(load),
				  .ShiftRight(shift),
				  .in(q[5]),
				  .clk(c),
				  .reset(rs)
				  );
				  
	shifter s3(.out(q[3]),
				  .LoadVal(load_val[3]),
				  .Load_n(load),
				  .ShiftRight(shift),
				  .in(q[4]),
				  .clk(c),
				  .reset(rs)
				  );
				  
	shifter s2(.out(q[2]),
				  .LoadVal(load_val[2]),
				  .Load_n(load),
				  .ShiftRight(shift),
				  .in(q[3]),
				  .clk(c),
				  .reset(rs)
				  );
				  
	shifter s1(.out(q[1]),
				  .LoadVal(load_val[1]),
				  .Load_n(load),
				  .ShiftRight(shift),
				  .in(q[2]),
				  .clk(c),
				  .reset(rs)
				  );
				  
	shifter s0(.out(q[0]),
				  .LoadVal(load_val[0]),
				  .Load_n(load),
				  .ShiftRight(shift),
				  .in(q[1]),
				  .clk(c),
				  .reset(rs)
				  );
				  
endmodule

module shifter(out, LoadVal, Load_n, ShiftRight, in, clk, reset);
	input LoadVal, Load_n, ShiftRight, in, clk, reset;
	output out;
	
	wire wout1, wout2;
	mux2to1 shiftToRight(.m(wout1), .x(out), .y(in), .s(ShiftRight));
	mux2to1 loadn(.m(wout2), .x(LoadVal), .y(wout1), .s(Load_n));
	flip_flop fliflo(.q(out), .clock(clk), .d(wout2), .reset_n(reset));
endmodule

module mux2to1(m, x, y, s);
	input x; //selected when s is 0
   input y; //selected when s is 1
   input s; //select signal
   output m; //output
  
   assign m = s & y | ~s & x;
   // OR
   // assign m = s ? y : x;
endmodule

module flip_flop(q, clock, d, reset_n);
	input clock, d, reset_n;
	output q;
	reg q;
	
	always @(posedge clock)

	begin
		if (reset_n == 1'b0)
			q <= 8'b0000_0000;
		else
			q <= d;
	end
endmodule
