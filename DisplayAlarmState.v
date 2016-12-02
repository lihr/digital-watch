module DisplayAlarmState(
input Digit,
output reg[6:0]SSD
);

always  @ (Digit)
	begin
	
		case(Digit)
							  // ABCDEFG
			0:	SSD = 7'b1000010;//d
			
			
			1: SSD = 7'b0110000;//E
			
		endcase
	
	end

endmodule
