`timescale 1ns / 1ps

module DisplayDriver(

input [6:0]Digits,
input Clk_50MHz,//for blink function
input Blink,//enables the blinking function

output reg [6:0]SSD_Digit0,
output reg [6:0]SSD_Digit1

);


reg[6:0]SevenBuff0;
reg[6:0]SevenBuff1;

reg Flip = 0 ;

reg[3:0]bcd0;
reg[3:0]bcd1;


always @(posedge Clk_50MHz)
	begin
		if(Blink == 1)
			begin
			
				Flip = ~Flip;
				
				if(Flip == 1)
					begin
					
						SSD_Digit0  = SevenBuff0;
						SSD_Digit1  = SevenBuff1;
					
					end
				else
					begin
					
						SSD_Digit0  = 7'b1111111;
						SSD_Digit1  = 7'b1111111;
					
					end
			
			end
			
		else
			begin
			
				SSD_Digit0  = SevenBuff0;
				SSD_Digit1  = SevenBuff1;
			
			end
	end
//*****************Buffer Updater************************//
always @ (bcd1 or bcd0)
	begin
		
		case(bcd0)
										// ABCDEFG
			4'b0000:SevenBuff0 = 7'b0000001;
			4'b0001:SevenBuff0 = 7'b1001111;
			4'b0010:SevenBuff0 = 7'b0010010;
			4'b0011:SevenBuff0 = 7'b0000110;
			4'b0100:SevenBuff0 = 7'b1001100;
			4'b0101:SevenBuff0 = 7'b0100100;
			4'b0110:SevenBuff0 = 7'b0100000;
			4'b0111:SevenBuff0 = 7'b0001111;
			4'b1000:SevenBuff0 = 7'b0000000;
			4'b1001:SevenBuff0 = 7'b0000100;
		
		endcase
		
		case(bcd1)
										// ABCDEFG
			4'b0000:SevenBuff1 = 7'b0000001;
			4'b0001:SevenBuff1 = 7'b1001111;
			4'b0010:SevenBuff1 = 7'b0010010;
			4'b0011:SevenBuff1 = 7'b0000110;
			4'b0100:SevenBuff1 = 7'b1001100;
			4'b0101:SevenBuff1 = 7'b0100100;
			4'b0110:SevenBuff1 = 7'b0100000;
			4'b0111:SevenBuff1 = 7'b0001111;
			4'b1000:SevenBuff1 = 7'b0000000;
			4'b1001:SevenBuff1 = 7'b0000100;
			
		endcase
	
	
	end

//*****************BCD conver************************//
always @ (Digits)
	begin
		case(Digits) 
		
			7'd0 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0000; end
			7'd1 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0001; end
			7'd2 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0010; end
			7'd3 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0011; end
			7'd4 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0100; end
			7'd5 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0101; end
			7'd6 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0110; end
			7'd7 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0111; end
			7'd8 : begin bcd1 <= 4'b0000; bcd0 <= 4'b1000; end
			7'd9 : begin bcd1 <= 4'b0000; bcd0 <= 4'b1001; end
			7'd10 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0000; end
			7'd11 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0001; end
			7'd12 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0010; end
			7'd13 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0011; end
			7'd14 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0100; end
			7'd15 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0101; end
			7'd16 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0110; end
			7'd17 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0111; end
			7'd18 : begin bcd1 <= 4'b0001; bcd0 <= 4'b1000; end
			7'd19 : begin bcd1 <= 4'b0001; bcd0 <= 4'b1001; end
			7'd20 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0000; end
			7'd21 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0001; end
			7'd22 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0010; end
			7'd23 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0011; end
			7'd24 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0100; end
			7'd25 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0101; end
			7'd26 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0110; end
			7'd27 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0111; end
			7'd28 : begin bcd1 <= 4'b0010; bcd0 <= 4'b1000; end
			7'd29 : begin bcd1 <= 4'b0010; bcd0 <= 4'b1001; end
			7'd30 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0000; end
			7'd31 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0001; end
			7'd32 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0010; end
			7'd33 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0011; end
			7'd34 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0100; end
			7'd35 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0101; end
			7'd36 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0110; end
			7'd37 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0111; end
			7'd38 : begin bcd1 <= 4'b0011; bcd0 <= 4'b1000; end
			7'd39 : begin bcd1 <= 4'b0011; bcd0 <= 4'b1001; end
			7'd40 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0000; end
			7'd41 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0001; end
			7'd42 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0010; end
			7'd43 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0011; end
			7'd44 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0100; end
			7'd45 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0101; end
			7'd46 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0110; end
			7'd47 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0111; end
			7'd48 : begin bcd1 <= 4'b0100; bcd0 <= 4'b1000; end
			7'd49 : begin bcd1 <= 4'b0100; bcd0 <= 4'b1001; end
			7'd50 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0000; end
			7'd51 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0001; end
			7'd52 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0010; end
			7'd53 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0011; end
			7'd54 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0100; end
			7'd55 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0101; end
			7'd56 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0110; end
			7'd57 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0111; end
			7'd58 : begin bcd1 <= 4'b0101; bcd0 <= 4'b1000; end
			7'd59 : begin bcd1 <= 4'b0101; bcd0 <= 4'b1001; end
			7'd60 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0000; end
			7'd61 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0001; end
			7'd62 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0010; end
			7'd63 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0011; end
			7'd64 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0100; end
			7'd65 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0101; end
			7'd66 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0110; end
			7'd67 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0111; end
			7'd68 : begin bcd1 <= 4'b0110; bcd0 <= 4'b1000; end
			7'd69 : begin bcd1 <= 4'b0110; bcd0 <= 4'b1001; end
			7'd70 : begin bcd1 <= 4'b0111; bcd0 <= 4'b0000; end
			7'd71 : begin bcd1 <= 4'b0111; bcd0 <= 4'b0001; end
			7'd72 : begin bcd1 <= 4'b0111; bcd0 <= 4'b0010; end
			7'd73 : begin bcd1 <= 4'b0111; bcd0 <= 4'b0011; end
			7'd74 : begin bcd1 <= 4'b0111; bcd0 <= 4'b0100; end
			7'd75 : begin bcd1 <= 4'b0111; bcd0 <= 4'b0101; end
			7'd76 : begin bcd1 <= 4'b0111; bcd0 <= 4'b0110; end
			7'd77 : begin bcd1 <= 4'b0111; bcd0 <= 4'b0111; end
			7'd78 : begin bcd1 <= 4'b0111; bcd0 <= 4'b1000; end
			7'd79 : begin bcd1 <= 4'b0111; bcd0 <= 4'b1001; end
			7'd80 : begin bcd1 <= 4'b1000; bcd0 <= 4'b0000; end
			7'd81 : begin bcd1 <= 4'b1000; bcd0 <= 4'b0001; end
			7'd82 : begin bcd1 <= 4'b1000; bcd0 <= 4'b0010; end
			7'd83 : begin bcd1 <= 4'b1000; bcd0 <= 4'b0011; end
			7'd84 : begin bcd1 <= 4'b1000; bcd0 <= 4'b0100; end
			7'd85 : begin bcd1 <= 4'b1000; bcd0 <= 4'b0101; end
			7'd86 : begin bcd1 <= 4'b1000; bcd0 <= 4'b0110; end
			7'd87 : begin bcd1 <= 4'b1000; bcd0 <= 4'b0111; end
			7'd88 : begin bcd1 <= 4'b1000; bcd0 <= 4'b1000; end
			7'd89 : begin bcd1 <= 4'b1000; bcd0 <= 4'b1001; end
			7'd90 : begin bcd1 <= 4'b1001; bcd0 <= 4'b0000; end
			7'd91 : begin bcd1 <= 4'b1001; bcd0 <= 4'b0001; end
			7'd92 : begin bcd1 <= 4'b1001; bcd0 <= 4'b0010; end
			7'd93 : begin bcd1 <= 4'b1001; bcd0 <= 4'b0011; end
			7'd94 : begin bcd1 <= 4'b1001; bcd0 <= 4'b0100; end
			7'd95 : begin bcd1 <= 4'b1001; bcd0 <= 4'b0101; end
			7'd96 : begin bcd1 <= 4'b1001; bcd0 <= 4'b0110; end
			7'd97 : begin bcd1 <= 4'b1001; bcd0 <= 4'b0111; end
			7'd98 : begin bcd1 <= 4'b1001; bcd0 <= 4'b1000; end
			7'd99 : begin bcd1 <= 4'b1001; bcd0 <= 4'b1001; end
			
	endcase
end
		
endmodule
