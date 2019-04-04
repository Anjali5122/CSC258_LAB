module seven_seg_decoder(HEX0, SW);
    input [9:0] SW;
    output [6:0] HEX0;

    H0 u0(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
		  .c3(SW[3]),
        .m(HEX0[0])
        );
		  
	H1 u1(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
		  .c3(SW[3]),
        .m(HEX0[1])
        );
	
	H2 u2(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
		  .c3(SW[3]),
        .m(HEX0[2])
        );
   H3 u3(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
		  .c3(SW[3]),
        .m(HEX0[3])
        );
		  
  H4 u4(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
		  .c3(SW[3]),
        .m(HEX0[4])
        );
		  
  H5 u5(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
		  .c3(SW[3]),
        .m(HEX0[5])
        );

  H6 u6(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
		  .c3(SW[3]),
        .m(HEX0[6])
        );
	
endmodule

module H0(c0, c1, c2, c3, m);
    input c0; 
    input c1; 
    input c2; 
	 input c3;
    output m; //output
  
    assign m = ~ c3 & c2 & ~ c1 & ~ c0 | ~ c3 & ~ c2 & ~ c1 & c0 | c3 & c2 & ~ c1 & c0 |  c3 & ~ c2 & c1 & c0;	 
	 
endmodule

module H1(c0, c1, c2, c3, m);
    input c0; 
    input c1; 
    input c2; 
	 input c3;
    output m; //output
  
    assign m = c3 & c2 & ~ c1 & ~ c0 | ~ c3 & c2 & ~ c1 & c0 | c3 & c1 & c0 | c2 & c1 & ~ c0;	 
	 
endmodule

module H2(c0, c1, c2, c3, m);
    input c0; 
    input c1; 
    input c2; 
	 input c3;
    output m; //output
  
    assign m = c3 & c2 & ~ c1 & ~ c0 |  c2 & c1 & c3 |  ~ c3 & ~ c2 & c1 & ~c0;	 
	 
endmodule


module H3(c0, c1, c2, c3, m);
    input c0; 
    input c1; 
    input c2; 
	 input c3;
    output m; //output
  
    assign m = ~ c3 & c2 & ~ c1 & ~ c0 | ~ c3 & ~ c2 & ~ c1 & c0 | c2 & c1 & c0 |  c3 & ~ c2 & c1 & ~ c0;	 
	 
endmodule

module H4(c0, c1, c2, c3, m);
    input c0; 
    input c1; 
    input c2; 
	 input c3;
    output m; //output
  
    assign m = c3 & ~ c2 & ~ c1 & c0 | ~ c3 & c0 |~ c3 & c2 & ~ c1;	 
	 
endmodule

module H5(c0, c1, c2, c3, m);
    input c0; 
    input c1; 
    input c2; 
	 input c3;
    output m; //output
  
    assign m = ~ c3 & ~ c2 & c0 | ~ c3 &  c1 & c0 | ~ c3 & ~ c2 & c1 |  c3 & c2 & ~ c1 & c0;	 
	 
endmodule

module H6(c0, c1, c2, c3, m);
    input c0; 
    input c1; 
    input c2; 
	 input c3;
    output m; //output
  
    assign m = ~ c3 & ~c2 & ~ c1 | ~ c3 & c2 & c1 & c0 | c3 & c2 & ~ c1 & ~ c0;	 
	 
endmodule
