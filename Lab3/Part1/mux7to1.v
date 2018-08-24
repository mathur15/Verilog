module mux7to1(LEDR,SW);

	input[9:0] SW;
	output[1:0] LEDR;
	mux u0(
	       .in(SW[6:0]),
		    .out(LEDR[0]),
			 .select(SW[9:7])
			);
		
endmodule

module mux(in,out,select);
	input[6:0] in;
	input[2:0] select;
	output out;
	
	reg out;
	
	always @(*)
	begin
		case(select)
			3'b000: out = in[0];
			3'b001: out = in[1];
			3'b010: out = in[2];
			3'b011: out = in[3];
			3'b100: out = in[4];
			3'b101: out = in[5];
			3'b110: out = in[6];
			default:out=1'b0;
		endcase
	end
endmodule
			
	