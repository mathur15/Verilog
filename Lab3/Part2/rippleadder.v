module rippleadder(LEDR,SW);
   input[9:0] SW;
	output[9:0] LEDR;
	wire f1,f2,f3;
	
	fulladder u0(.A(SW[4]),
					 .B(SW[0]),
					 .cin(SW[8]),
					 .S(LEDR[0]),
					 .cout(f1));
	fulladder u1(.A(SW[5]),
					 .B(SW[1]),
					 .cin(f1),
					 .S(LEDR[1]),
					 .cout(f2));
	fulladder u2(.A(SW[6]),
					 .B(SW[2]),
					 .cin(f2),
					 .S(LEDR[2]),
					 .cout(f3));
   fulladder u3(.A(SW[7]),
					 .B(SW[3]),
					 .cin(f3),
					 .S(LEDR[3]),
					 .cout(LEDR[4]));
endmodule

module fulladder(A,B,cin,S,cout);
	input A,B,cin;
	output S,cout;
	
	assign S=(A^B)^cin;
	assign cout= B & ~(A^B)| cin & (A^B);
	
endmodule