module Alarm(

input [5:0]SecTk,
input[5:0]MinTk,
input[4:0]HrTk,

input Button1Alm,
input Button2Alm,
input Button3Alm,

output reg[5:0]MinAlm,
output reg[4:0]HrAlm,

output reg Alarm = 0,
output reg BuzzerBit = 0,

output reg [1:0]BlinkAlm

);


always @(SecTk)
	begin
	
		if(SecTk == 0 &&  MinAlm == MinTk && HrAlm == HrTk)
			begin
				if(Alarm == 1)
					begin
					
						BuzzerBit = 1;
						
					end
			
			end
		if(Button3Alm == 1)
			begin
			
				if(BuzzerBit == 1)
					begin
						BuzzerBit = 0;
					
					end
			
			end
	end
	
always @ (posedge Button1Alm)
	begin
	
		BlinkAlm = BlinkAlm +1;
	
	end


always @ (posedge Button2Alm)
	begin
	
		case(BlinkAlm)
			
			1:begin
						
				MinAlm = MinAlm + 1;
				
				if(MinAlm == 60)
					begin
						
						MinAlm = 0;
					end
				end
					
			2:begin
				
				HrAlm = HrAlm + 1;
						
				if(HrAlm == 24)
					begin
					
						HrAlm = 0;
					
					end	
				end
			
			3:begin
			
				Alarm = ~Alarm;
			
			end
		endcase
	
	end
	
	
endmodule