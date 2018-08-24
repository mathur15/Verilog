module mux(LEDR,SW);
     input[9:0] SW;
	  output[9:0] LEDR;
	  wire w1;
	  wire w2;
	  mux2to1 u0
			(.x(SW[0]),
			 .y(SW[1]),
			 .s(SW[9]),
			 .m(w1)
			);
	  mux2to1 u1
			(.x(SW[2]),
			 .y(SW[3]),
			 .s(SW[9]),
			 .m(w2)
			);
	  mux2to1 u2
			(.x(w1),
			 .y(w2),
			 .s(SW[8]),
			 .m(LEDR[0])
			);
endmodule

module mux2to1(x,y,s,m);
	  input x;
	  input y;
	  input s;
	  output m;
	  
	  assign m = x&~s|y&s;
endmodule
