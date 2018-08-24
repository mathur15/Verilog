module hexdecode(SW,HEX0);
	input[3:0] SW;
	output[6:0] HEX0;
	
	segment_0 u0
			(.D(SW[0]),
			 .C(SW[1]),
			 .B(SW[2]),
			 .A(SW[3]),
			 .out0(HEX0[0])
			);
   	segment_1 u1
			(.D(SW[0]),
			 .C(SW[1]),
			 .B(SW[2]),
			 .A(SW[3]),
			 .out1(HEX0[1])
			);
	segment_2 u2
			(.D(SW[0]),
			 .C(SW[1]),
			 .B(SW[2]),
			 .A(SW[3]),
			 .out2(HEX0[2])
			);
	segment_3 u3
			(.D(SW[0]),
			 .C(SW[1]),
			 .B(SW[2]),
			 .A(SW[3]),
			 .out3(HEX0[3])
			);
	segment_4 u4
			(.D(SW[0]),
			 .C(SW[1]),
			 .B(SW[2]),
			 .A(SW[3]),
			 .out4(HEX0[4])
			);
	segment_5 u5
			(.D(SW[0]),
			 .C(SW[1]),
			 .B(SW[2]),
			 .A(SW[3]),
			 .out5(HEX0[5])
			);
	segment_6 u6
			(.D(SW[0]),
			 .C(SW[1]),
			 .B(SW[2]),
			 .A(SW[3]),
			 .out6(HEX0[6])
			);
endmodule

module segment_0(D,C,B,A,out0);
	input D;
	input C;
	input B;
	input A;
	output out0;
	
	assign out0 = (~A&~B&~C&D)|(~A&B&~C&~D)|(A&~B&C&D)|(A&B&~C&D);

endmodule


module segment_1(D,C,B,A,out1);
	input D;
	input C;
	input B;
	input A;
	output out1;
	
	assign out1 = (~A&B&~C&D)|(A&B&~D)|(B&C&~D)|(A&C&D);

endmodule


module segment_2(D,C,B,A,out2);
	input D;
	input C;
	input B;
	input A;
	output out2;
	
	assign out2 = (A&B&~D)|(A&B&C)|(~A&~B&C&~D);

endmodule


module segment_3(D,C,B,A,out3);
	input D;
	input C;
	input B;
	input A;
	output out3;
	
	assign out3 = B&C&D|~A&~B&~C&D|~A&B&~C&~D|A&~B&C&~D;

endmodule


module segment_4(D,C,B,A,out4);
	input D;
	input C;
	input B;
	input A;
	output out4;
	
	assign out4 = (~A&B&~C)|(~A&D)|(~B&~C&D);

endmodule


module segment_5(D,C,B,A,out5);
	input D;
	input C;
	input B;
	input A;
	output out5;
	
	assign out5 = (~A&~B&D)|(~A&~B&C)|(~A&C&D)|(A&B&~C&D);

endmodule


module segment_6(D,C,B,A,out6);
	input D;
	input C;
	input B;
	input A;
	output out6;
	
	assign out6 = (~A&~B&~C)|(~A&B&C&D)|(A&B&~C&~D);

endmodule
