module part3(LEDR,KEY,SW);
   
	input[3:0] KEY;
	input[9:0] SW;
	output[7:0] LEDR;
	
	shifter s1(
	   .LoadVal(SW[7:0]),
		.Load_n(KEY[1]),
		.ShiftRight(KEY[2]),
		.ASR(KEY[3]),
		.clk(KEY[0]),
		.reset(SW[9]),
		.out1(LEDR[7:0]));
		
endmodule

module shifter(LoadVal,Load_n,ShiftRight,ASR,clk,reset,out1);

	input[7:0] LoadVal;
	input Load_n,ShiftRight,ASR,clk,reset;
	output[7:0] out1;
	wire outp;
	
	mux u3(
	.x(ASR),
	.y(out1[7]),
	.s(ASR),
	.m(outp));
	
	shifterbit sb0(
	   .load_val(LoadVal[0]),
		.in(out1[1]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset(reset_n),
		.out(out1[0]));
	
	shifterbit sb1(
	   .load_val(LoadVal[7]),
		.in(out1[2]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset(reset_n),
		.out(out1[1]));
	
   shifterbit sb2(
	   .load_val(LoadVal[7]),
		.in(out1[3]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset(reset_n),
		.out(out1[2]));
		
	shifterbit sb3(
	   .load_val(LoadVal[7]),
		.in(out1[4]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset(reset_n),
		.out(out1[3]));
		
	shifterbit sb4(
	   .load_val(LoadVal[7]),
		.in(out1[5]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset(reset_n),
		.out(out1[4]));
		
	shifterbit sb5(
	   .load_val(LoadVal[7]),
		.in(out1[6]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset(reset_n),
		.out(out1[5]));
		
	shifterbit sb6(
	   .load_val(LoadVal[7]),
		.in(out1[7]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset(reset_n),
		.out(out1[6]));
		
	shifterbit sb7(
	   .load_val(LoadVal[7]),
		.in(outp),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clk),
		.reset(reset_n),
		.out(out1[7]));
		
endmodule

module shifterbit(load_val,in,shift,load_n,clk,reset,out);
   input load_val;
	input in;
	input shift;
	inout load_n;
	input clk;
	input reset;
	
	wire u0out;
	wire u1out;
	output out;
	
	mux u0(.x(out),
	.y(in),
	.s(shift),
	.m(u0out));
	
	mux u1(.x(load_val),
	.y(u0out),
	.s(load_n),
	.m(u1out));
	
	flipflop f1(.d(u1out),
	.reset(reset),
	.clk(clk),
	.q(out));
	

endmodule

module mux(x,y,s,m);
     input x;
	  input y;
	  input s;
	  output m;
	  
	  assign m = x&~s|y&s;
endmodule

module flipflop(d,reset,clk,q);
	input reset,clk;
	input d;
	output q;
	reg q;
	
	always @(posedge clk)
	begin
	    if (reset == 1'b0)
		     q <= 0;
		 else
		 	  q <= d;
	end
	
endmodule
