module Counter(SW, KEY, HEX0, HEX1);
	input [9:0]SW; //Will only use SW[0] as clear_b, SW[1] as enable
	input [3:0]KEY; //Will only use KEY[0] as clock
	output [6:0]HEX0; //Displays value of Counter while simulating
	output [6:0]HEX1; //Displays value of Counter while simulating
	wire Q7, Q6, Q5, Q4, Q3, Q2, Q1, Q0; //one bit wires representing outputs
	wire out6, out5, out4, out3, out2, out1, out0; //represents the outs for the ands
	wire [3:0]lowerbits; //4 most significant bits
	wire [3:0]higherbits; //4 least significant bits
	
	My_TFF counter0(
		.clock(KEY[0]),
		.clear_b(SW[0]),
		.E(SW[1]),
		.Q(Q0)
	);
	
	andgate ag0(
		.a(SW[1]),
		.b(Q0),
		.y(out0)
	);
	
	My_TFF counter1(
		.clock(KEY[0]),
		.clear_b(SW[0]),
		.E(out0),
		.Q(Q1)
	);
	
	andgate ag1(
		.a(Q1),
		.b(out0),
		.y(out1)
	);
	
	My_TFF counter2(
		.clock(KEY[0]),
		.clear_b(SW[0]),
		.E(out1),
		.Q(Q2)
	);
	
	andgate ag2(
		.a(Q2),
		.b(out1),
		.y(out2)
	);
	
	My_TFF counter3(
		.clock(KEY[0]),
		.clear_b(SW[0]),
		.E(out2),
		.Q(Q3)
	);
	
	andgate ag3(
		.a(Q3),
		.b(out2),
		.y(out3)
	);
		
	My_TFF counter4(
		.clock(KEY[0]),
		.clear_b(SW[0]),
		.E(out3),
		.Q(Q4)
	);

	andgate ag4(
		.a(Q4),
		.b(out3),
		.y(out4)
	);
		
	My_TFF counter5(
		.clock(KEY[0]),
		.clear_b(SW[0]),
		.E(out4),
		.Q(Q5)
	);

	andgate ag5(
		.a(Q5),
		.b(out4),
		.y(out5)
	);
		
	My_TFF counter6(
		.clock(KEY[0]),
		.clear_b(SW[0]),
		.E(out5),
		.Q(Q6)
	);

	andgate ag6(
		.a(Q6),
		.b(out5),
		.y(out6)
	);
		
	My_TFF counter7(
		.clock(KEY[0]),
		.clear_b(SW[0]),
		.E(out6),
		.Q(Q7)
	);
	
	assign lowerbits[3:0] = {Q3, Q2, Q1, Q0};
	assign higherbits[3:0] = {Q7, Q6, Q5, Q4};
	
	//DISPLAYING
	seven_seg_decoder H1(
		.bits(lowerbits[3:0]),
		.hex(HEX0[6:0])
	);
		
	seven_seg_decoder H0(
		.bits(higherbits[3:0]),
		.hex(HEX1[6:0])
	);
	

endmodule

//and gate
module andgate (a, b, y);
	input a, b;
	output y;
	assign y = a & b;
endmodule

//1 bit counter
module My_TFF(clock, clear_b, E, Q);
	input clock; //clock, KEY[0]
	input clear_b; //the reset
	input E; //Enable
	output Q; //1 bit output
	reg q;
	
	always @(posedge clock, negedge clear_b)
	begin
		if (clear_b == 1'b0)
			q <= 1'b0; //resets bit to 0 if clear_b is low
		else if (E == 1'b1)
			q <= ~Q; //Flips it
	end
	assign Q = q; //Outputs it
endmodule




//Seven augment decoder for inputs from 0-F (Hexadecimal)
module seven_seg_decoder(bits, hex);
	input [3:0]bits; //4 inputs, represents bits
	output [6:0]hex; //7 segement Hex decoder
	
	assign hex[0] = (~bits[3] & ~bits[2] & ~bits[1] & bits[0]) | (~bits[3] & bits[2] & ~bits[1] & ~bits[0]) | (bits[3] & bits[2] & ~bits[1] & bits[0]) | (bits[3] & ~bits[2] & bits[1] & bits[0]);
	assign hex[1] = (bits[3] & bits[1] & bits[0]) | (bits[2] & bits[1] & ~bits[0]) | (~bits[3] & bits[2] & ~bits[1] & bits[0]) | (bits[3] & bits[2] & ~bits[1] & ~bits[0]);
	assign hex[2] = (bits[3] & bits[2] & bits[1]) | (~bits[3] & ~bits[2] & bits[1] & ~bits[0]) | (bits[3] & bits[2] & ~bits[1] & ~bits[0]);
	assign hex[3] = (bits[2] & bits[1] & bits[0]) | (~bits[2] & ~bits[1] & bits[0]) | (~bits[3] & bits[2] & ~bits[1] & ~bits[0]) | (bits[3] & ~bits[2] & bits[1] & ~bits[0]);
	assign hex[4] = (~bits[3] & bits[2] & ~bits[1]) | (~bits[2] & ~bits[1] & bits[0]) | (~bits[3] & bits[1] & bits[0]);
	assign hex[5] = (bits[3] & bits[2] & ~bits[1] & bits[0]) | (~bits[3] & bits[1] & bits[0]) | (~bits[3] & ~bits[2] & bits[1]) | (~bits[3] & ~bits[2] & bits[0]);
	assign hex[6] = (~bits[3] & ~bits[2] & ~bits[1]) | (bits[3] & bits[2] & ~bits[1] & ~bits[0]) | (~bits[3] & bits[2] & bits[1] & bits[0]);
	
endmodule