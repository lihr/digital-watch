module SingleDigit(

input [3:0]Digit,

output reg[6:0]SevenSeg

);

always  @ (Digit)
	begin
	
		case(Digit)
										// ABCDEFG
			4'b0000:SevenSeg = 7'b1110000;//t
			4'b0001:SevenSeg = 7'b0100100;//S
			4'b0010:SevenSeg = 7'b0001000;//A
		
		endcase
	
	end
	
endmodule