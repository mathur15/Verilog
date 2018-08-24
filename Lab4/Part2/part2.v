module part2(LEDR,SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	input[9:0]SW;
	input[1:0]KEY;
	output[9:0]LEDR;
	output[6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	wire[7:0] regout;
	wire[7:0] noregout;
	
	ALU7to1 a1(.A(SW[3:0]),
	.B(regout[3:0]),
	.key(SW[7:5]),
	.ALUout(noregout[7:0]));
	
	register r1(.d(noregout[7:0]),
	.reset(SW[9]),
	.clk(KEY[0]),
	.q(regout));
	
	assign LEDR[7:0] = regout;
	
	//A
	hexdisplay h0(
	.D(SW[0]),
	.C(SW[1]),
	.B(SW[2]),
	.A(SW[3]),
	.out0(HEX0[0]),
	.out1(HEX0[1]),
	.out2(HEX0[2]),
	.out3(HEX0[3]),
	.out4(HEX0[4]),
	.out5(HEX0[5]),
	.out6(HEX0[6]));
	
	hexdisplay h1(.D(1'b0),
	.C(1'b0),
	.B(1'b0),
	.A(1'b0),
	.out0(HEX1[0]),
	.out1(HEX1[1]),
	.out2(HEX1[2]),
	.out3(HEX1[3]),
	.out4(HEX1[4]),
	.out5(HEX1[5]),
	.out6(HEX1[6]));
	
	hexdisplay h2(.D(1'b0),
	.C(1'b0),
	.B(1'b0),
	.A(1'b0),
	.out0(HEX2[0]),
	.out1(HEX2[1]),
	.out2(HEX2[2]),
	.out3(HEX2[3]),
	.out4(HEX2[4]),
	.out5(HEX2[5]),
	.out6(HEX2[6]));
	
	hexdisplay h3(.D(1'b0),
	.C(1'b0),
	.B(1'b0),
	.A(1'b0),
	.out0(HEX3[0]),
	.out1(HEX3[1]),
	.out2(HEX3[2]),
	.out3(HEX3[3]),
	.out4(HEX3[4]),
	.out5(HEX3[5]),
	.out6(HEX3[6]));
	
	//lower 4 bits 
	hexdisplay h4(
	.D(regout[3]),
	.C(regout[2]),
	.B(regout[1]),
	.A(regout[0]),
	.out0(HEX4[0]),
	.out1(HEX4[1]),
	.out2(HEX4[2]),
	.out3(HEX4[3]),
	.out4(HEX4[4]),
	.out5(HEX4[5]),
	.out6(HEX4[6]));
	
	//upper 4 bits
	hexdisplay h5(
	.D(regout[7]),
	.C(regout[6]),
	.B(regout[5]),
	.A(regout[4]),
	.out0(HEX5[0]),
	.out1(HEX5[1]),
	.out2(HEX5[2]),
	.out3(HEX5[3]),
	.out4(HEX5[4]),
	.out5(HEX5[5]),
	.out6(HEX5[6]));
	

endmodule

module ALU7to1(A,B,key,ALUout);

   input[3:0] A;
	input[3:0] B;
	input[2:0] key;
	output [7:0] ALUout;
	reg [7:0] ALUout;
	wire cout;
	wire cout1;
	wire[3:0] sum;
	wire[3:0] sum1;
	
	rippleadder a1(
	.A(A[3:0]),
	.B(4'b0001),
	.cin(1'b0),
	.cout(cout),
	.sum(sum));
	
	rippleadder a2(
	.A(A[3:0]),
	.B(B[3:0]),
	.cin(1'b0),
	.cout(cout1),
	.sum(sum1));
	
	always @(*)
	begin
	    case(key)
		   3'b000://A+1
			  begin
			    ALUout[3:0] = sum;
				 ALUout[4] = cout;
				 ALUout[7:5] = 3'b000;
			  end
		   3'b001://A+B 
			  begin
			    ALUout[3:0] = sum1;
				 ALUout[4] = cout1;
				 ALUout[7:5] = 3'b000;
			  end
			3'b010://A+B
				ALUout = {4'b0000,A+B};
			3'b011:
			   ALUout = B<<A;
			3'b100:
			   ALUout = B>>A;
			3'b101:
			   ALUout = A*B;
			default: ALUout= 8'b00000000;
		 endcase
	end
endmodule

module rippleadder(A,B,cin,cout,sum);
   input[3:0] A;
	input[3:0] B;
	input cin;
	output cout;
	output[3:0] sum;
	wire f1,f2,f3;
	
	fulladder u0(.A(A[0]),
					 .B(B[0]),
					 .cin(cin),
					 .S(sum[0]),
					 .cout(f1));
	fulladder u1(.A(A[1]),
					 .B(B[1]),
					 .cin(f1),
					 .S(sum[1]),
					 .cout(f2));
	fulladder u2(.A(A[2]),
					 .B(B[2]),
					 .cin(f2),
					 .S(sum[2]),
					 .cout(f3));
   fulladder u3(.A(A[3]),
					 .B(B[3]),
					 .cin(f3),
					 .S(sum[3]),
					 .cout(cout));
endmodule

module fulladder(A,B,cin,S,cout);
	input A,B,cin;
	output S,cout;
	
	assign S=(A^B)^cin;
	assign cout= B & ~(A^B)| cin & (A^B);
	
endmodule

module register(d,reset,clk,q);
	input reset,clk;
	input[7:0] d;
	output[7:0] q;
	reg[7:0] q;
	
	always @(posedge clk)
	begin
	    if (reset == 1'b0)
		     q <= 0;
		 else
		     q <= d;
	end
endmodule

module hexdisplay(D,C,B,A,out0,out1,out2,out3,out4,out5,out6);
	input D,C,B,A;
	output out0,out1,out2,out3,out4,out5,out6;
	segment_0 m0
			(.D(D),
			 .C(C),
			 .B(B),
			 .A(A),
			 .out0(out0)
			);
   segment_1 m1
			(.D(D),
			 .C(C),
			 .B(B),
			 .A(A),
			 .out1(out1)
			);
	segment_2 m2
			(.D(D),
			 .C(C),
			 .B(B),
			 .A(A),
			 .out2(out2)
			);
	segment_3 m3
			(.D(D),
			 .C(C),
			 .B(B),
			 .A(A),
			 .out3(out3)
			);
	segment_4 m4
			(.D(D),
			 .C(C),
			 .B(B),
			 .A(A),
			 .out4(out4)
			);
	segment_5 m5
			(.D(D),
			 .C(C),
			 .B(B),
			 .A(A),
			 .out5(out5)
			);
	segment_6 m6
			(.D(D),
			 .C(C),
			 .B(B),
			 .A(A),
			 .out6(out6)
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


