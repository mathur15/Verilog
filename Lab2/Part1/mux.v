module mux(LEDR,SW);
    input [9:0] SW;
    output [9:0] LEDR;
    
    mux2to1 u0(
    	.x(SW[0]),
	.y(SW[1]),
	.s(SW[9]),
	.m(LEDR[0])
	);
endmodule

module mux2to1(x,y,s,m);
    input x;
    input y;
    input s;
    output m;
    
    assign m= s&y | ~s&x;
    
endmodule 	
