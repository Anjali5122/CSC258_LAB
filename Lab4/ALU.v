module ALU(SW, KEY, LEDR, HEX0, HEX4, HEX5);
	input [9:0] SW; // A inputs connect to these switches: [3:0], SW9 = reset_n, SW[7:5] = function inputs
	input [3:0] KEY; // clock input
   output [9:0]LEDR; //Using only [7:0] for ALUout
	output [6:0]HEX0; //Displays value of A
	output [6:0]HEX4; //Displays Registerout[3:0] (register)
	output [6:0]HEX5; //Displays Registerout[7:4] (register)
	wire [7:0]ALUout; //Represents the ALU output
	wire [7:0]Registerout; //Represents the Register output
	reg [7:0] temp4; //Temporary 8 bit reg to store the combination of A and B
	reg [3:0] tempa, tempb; //Temporary output variables, 4 bits each, will combine to make 8 bit output
	reg [7:0] case0, case1; // Includes carry digit
	reg [7:0] case5, case6; //For the shifter
	reg [7:0] case7; //Multiplication storage

	always @(*)
	begin
		case (SW[7:5])
			3'b000: begin //Case 0 SHOULD BE DONE
				case0 = SW[3:0] + 4'b0001;
				tempb = case0[3:0];
				tempa = case0[7:4];
			end
			
			3'b001: begin //Case 1 SHOULD BE DONE
				case1 = SW[3:0] + Registerout[3:0];
				tempb = case1[3:0];
				tempa = case1[7:4];
			end
			
			3'b010: begin //Case 2 SHOULD BE DONE
				case1 = SW[3:0] + Registerout[3:0];
				tempb = case1[3:0];
				tempa = case1[7:4];
			end
			
			3'b011: begin //Case 3 SHOULD BE DONE
				tempb = SW[3:0] ^ Registerout[3:0]; //XOR in the lower 4 bits
				tempa = SW[3:0] | Registerout[3:0]; //OR  in the upper four bits
			end
			
			3'b100: begin //Case 4 SHOULD BE DONE
				temp4 = {SW[3:0], Registerout[3:0]};
				tempa = 4'b0000;
				tempb = {3'b000,| temp4[7:0]}; //Reduces the combination of A and Registerout using the or reduction operator
			end
			
			3'b101: begin //Case 5
				//left shift 
				case5 = Registerout[3:0] << SW[3:0];
				tempa = case5[7:4];
				tempb = case5[3:0];
				
			end
			
			3'b110: begin //Case 6 
				case6 = Registerout[3:0] >> SW[3:0];
				tempa = case6[7:4];
				tempb = case6[3:0];
			end
			
			3'b111: begin //Case 7 SHOULD BE DONE
				case7[7:0] = Registerout[3:0] * SW[3:0];
				tempa = case7[7:4];
				tempb = case7[3:0];
			end
			// Default case
			default: begin
				tempa = 4'b0000; //Create two 4 bit strings of 0 to combine into one 8 bit string of 0
				tempb = 4'b0000;
			end
		endcase
	end
	
	assign ALUout[7:0] = {tempa[3:0], tempb[3:0]}; //Completes the 8 bit output
	
	//Should be finished
	//Register module
	DDF register(
		.clock(KEY[0]), //Clock
		.d(ALUout[7:0]), //Input 
		.reset_n(SW[9]), //Reset 
		.q(Registerout[7:0]) //Output
	);
	
	assign LEDR[7:0] = ALUout[7:0]; //Displays the ALU outputs on LEDR 7-0
	
	//DISPLAYING A AND B
	seven_seg_decoder H0(
		.bits(SW[3:0]),
		.hex(HEX0[6:0])
	);
	
	
	//HEX4 AND HEX5 display the least and most significant bits of Register
	seven_seg_decoder H4(
		.bits(Registerout[3:0]),
		.hex(HEX4[6:0])
	);
	
	seven_seg_decoder H5(
		.bits(Registerout[7:4]),
		.hex(HEX5[6:0])
	);
	
	
endmodule

//Finished should be
//DFF
module DDF(clock, reset_n, d, q);
	input clock; //clock
	input reset_n;
	input [7:0] d; //8 bit input
	output [7:0] q; //8 bit output
	reg [7:0] q;
	
	always @(posedge clock)
	begin
		if (reset_n == 1'b0)
			q <= 8'd0;
		else
			q <= d;
	end
endmodule

//Full adder module
module full_adder(s, a, b);
	input [3:0] a;
	input [3:0] b;
	output [4:0] s;
	wire connection1; //Declare a wire for connection
	wire connection2; //Declare another wire for connection
	wire connection3;
	
	//Block 1
	full_adder_sub block1(
		.A(a[0]),
		.B(b[0]),
		.cin(1'b0), 
		.S(s[0]),
		.cout(connection1)
	);
	
	//Block 2
	full_adder_sub block2(
		.A(a[1]),
		.B(b[1]),
		.cin(connection1), 
		.S(s[1]),
		.cout(connection2)
	);
	
	//Block 3
	full_adder_sub block3(
		.A(a[2]),
		.B(b[2]),
		.cin(connection2), 
		.S(s[2]),
		.cout(connection3)
	);
	
	//Block 4
	full_adder_sub block4(
		.A(a[3]),
		.B(b[3]),
		.cin(connection3), 
		.S(s[4]),
		.cout()
	);
	

endmodule

//Full adder sub circuit
module full_adder_sub(S, cout, A, B, cin);
	input A, B, cin;
	output S, cout;
	
	assign S = A^B^cin;
	assign cout = (A&B) | (cin & (A^B));
endmodule

// Verilog adder for case 2
module verilog_adder(s, a, b);
	input [3:0] a;
	input [3:0] b;
	output [4:0] s;
	
	assign s[4:0] = a + b;

endmodule

module verilog_multiplication(s, a, b);
	input [3:0] a;
	input [3:0] b;
	output [7:0] s;

	assign s[7:0] = a * b;
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