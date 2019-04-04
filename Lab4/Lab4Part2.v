module Lab4Part2(HEX0, HEX4, HEX5, LEDR, SW, KEY);

	input [9:0] SW;
	input [0:0] KEY;
	output [7:0] LEDR;
	output[6:0] HEX0, HEX4, HEX5;

	wire [7:0] Out;

	SimpleALU alu(.outp(Out[7:0]), .clk(KEY[0]), .reset(SW[9]), .A(SW[3:0]), .key(SW[7:5]));

	//display the required result
	hex_display h0(
		.Hex(HEX0[6:0]),
		.Input(SW[3:0])
	);
	
	hex_display h4(
		.Hex(HEX4[6:0]),
		.Input(Out[3:0])
	);
	
	hex_display h5(
		.Hex(HEX5[6:0]),
		.Input(Out[7:4])
	);

	//light up the LEDR for the output
	assign LEDR[7:0] = Out[7:0];

endmodule

module SimpleALU(outp, clk, reset, A, key);

	input clk, reset;
	input [3:0] A;
	input [2:0] key;
	output [7:0] outp;
	reg [7:0] outp;

	wire[7:0] wreg;
	wire [4:0] add1, addB;

	register regi(.q(wreg[7:0]), .clock(clk), .reset_n(reset), .d(outp[7:0]));

	RippleCarry radd1(.out(add1[4:0]), .in1(A[3:0]), .in2(4'b0001));
	RippleCarry raddB(.out(addB[4:0]), .in1(A[3:0]), .in2(wreg[3:0]));

	always @(*)
		begin
			case(key)
				3'b000: outp[7:0] = {3'b000, add1[4:0]};
				3'b001: outp[7:0] = {3'b000, addB[4:0]};
				3'b010: outp[7:0] = A[3:0] + wreg[3:0];
				3'b011: outp[7:0] = {A[3:0] | wreg[3:0], A[3:0] ^ wreg[3:0]};
				3'b100: outp[7:0] = {7'b0000000, (| ({A[3:0], wreg[3:0]}))};
				3'b101: outp[7:0] = wreg[3:0] << A[3:0];
				3'b110: outp[7:0] = wreg[3:0] >> A[3:0];
				3'b111: outp[7:0] = wreg[3:0] * A[3:0];
				default: outp[7:0] = 8'b0000_0000;
			endcase
		end

endmodule

module register(q, clock, reset_n, d);
input [7:0] d;
input clock, reset_n;
output reg [7:0] q;

always @(posedge clock)
	begin
		if (reset_n == 1'b0)
			q [7:0] <= 8'b0000_0000;
		else
			q [7:0] <= d [7:0];
	end
endmodule

module FullAdder(S, Cout, A, B, Cin);
	//define input, sum, carrier for a full adder
	//used for the arithmetic logic unit
	input A;
	input B;
	input Cin;
	output S;
	output Cout;
	
	//logically calculate the sum and carrier
	assign S = A ^ B ^ Cin;
	assign Cout = (A & B) | (A & Cin) | (B & Cin);
endmodule

module RippleCarry(out, in1, in2);
	//define a ripple carry
	//calculate four times to get the four bit sum and one bit carrier
	input [3:0] in1;
	input [3:0] in2;
	output [4:0] out;
	wire c1, c2, c3;
	
	FullAdder a0(
		.A(in1[0]),
		.B(in2[0]),
		.Cin(1'b0),
		.S(out[0]),
		.Cout(c1)
	);
	
	FullAdder a1(
		.A(in1[1]),
		.B(in2[1]),
		.Cin(c1),
		.S(out[1]),
		.Cout(c2)
	);
	
	FullAdder a2(
		.A(in1[2]),
		.B(in2[2]),
		.Cin(c2),
		.S(out[2]),
		.Cout(c3)
	);
	
	FullAdder a3(
		.A(in1[3]),
		.B(in2[3]),
		.Cin(c3),
		.S(out[3]),
		.Cout(out[4])
	);
endmodule

module seg_0(m, a, b, c, d); //turn off segment 0
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (a & ~b & c & d) | (a & b & ~c & d);
endmodule

module seg_1(m, a, b, c, d); //turn off segment 1
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (a & b & ~d) | (a & c & d) | (~a & b & ~c & d) | (~a & b & c & ~d);
endmodule

module seg_2(m, a, b, c, d); //turn off segment 2
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (~a & ~b & c & ~d) | (a & b & ~c & ~d) | (a & b & c);
endmodule

module seg_3(m, a, b, c, d); //turn off segment 3
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (~b & ~c & d) | (~a & b & ~c & ~d) | (b & c & d) | (a & ~b & c & ~d);
endmodule

module seg_4(m, a, b, c, d); //turn off segment 4
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (~a & b & ~c & ~d) | (a & ~b & ~c & d) | (~a & d);
endmodule

module seg_5(m, a, b, c, d); //turn off segment 5
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (~a & ~b & d) | (~a & ~b & c) | (~a & c & d) | (a & b & ~c & d);
endmodule

module seg_6(m, a, b, c, d); //turn off segment 6
	input a;
	input b;
	input c;
	input d;
	output m;
	
	assign m = (~a & ~b & ~c) | (~a & b & c & d) | (a & b & ~c & ~d);
endmodule

module hex_display(Hex, Input);

	// select input and output port
	input [3:0] Input;
	output[6:0] Hex;
	
	seg_0 zero( //output segment 0
		.a(Input[3]),
		.b(Input[2]),
		.c(Input[1]),
		.d(Input[0]),
		.m(Hex[0])
		);
	
	seg_1 one( //output segment 1
		.a(Input[3]),
		.b(Input[2]),
		.c(Input[1]),
		.d(Input[0]),
		.m(Hex[1])
		);
	
	seg_2 two( //output segment 2
		.a(Input[3]),
		.b(Input[2]),
		.c(Input[1]),
		.d(Input[0]),
		.m(Hex[2])
		);
	
	seg_3 three( //output segment 3
		.a(Input[3]),
		.b(Input[2]),
		.c(Input[1]),
		.d(Input[0]),
		.m(Hex[3])
		);
	
	seg_4 four( //output segment 4
		.a(Input[3]),
		.b(Input[2]),
		.c(Input[1]),
		.d(Input[0]),
		.m(Hex[4])
		);
	
	seg_5 five( //output segment 5
		.a(Input[3]),
		.b(Input[2]),
		.c(Input[1]),
		.d(Input[0]),
		.m(Hex[5])
		);
	
	seg_6 six( //output segment 6
		.a(Input[3]),
		.b(Input[2]),
		.c(Input[1]),
		.d(Input[0]),
		.m(Hex[6])
		);

endmodule