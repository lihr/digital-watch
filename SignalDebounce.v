module SignalDebounce(

input Clk_50Mhz,
input Raw,
output reg Cleaned = 0

);

reg Clk_100Hz = 1;
reg [27:0]Counter;

//**************Clock divider *****************//
always @ (posedge Clk_50Mhz)
	begin
		
		if(Counter == 250_000)
			begin
				Clk_100Hz <= ~Clk_100Hz;
				Counter <=0;
			end
		else
			begin
				Counter <= Counter +1;
			end
	end
	
reg [7:0]SigBuffer = 8'b00000000;

always @ (posedge Clk_100Hz)
	begin
	
		SigBuffer = SigBuffer << 1;
		
		if(Raw == 0)
			begin
				
				SigBuffer = SigBuffer + 1'b1;
			
			end
		case(SigBuffer)
			
			8'b11111111 : Cleaned = 1'b1;
			
			default : Cleaned = 1'b0;		
		
		endcase
	end
	
endmodule 