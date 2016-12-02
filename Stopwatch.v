module Stopwatch(

input Clk_50Mhz,
input Button1Sw,//run/stop
input Button2Sw,//rest
input Button3Sw,//planned split

output reg [6:0]MiliSecSW = 0,
output reg [5:0]SecSW = 0,
output reg [6:0]MinSW = 0,

output reg BlinkSW
);

reg Clk_100Hz = 1;
reg [27:0]Counter = 0;
//***********************Clock divider**************//
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
//***********************Counter update*************//
reg Run = 0;
reg Split = 0;

reg [6:0]TMPMiliSecSW = 0;
reg [5:0]TMPSecSW = 0;
reg [6:0]TMPMinSW = 0;

reg [6:0]LiveMiliSecSW = 0;
reg [5:0]LiveSecSW = 0;
reg [6:0]LiveMinSW = 0;

always @ (posedge Button3Sw)
	begin
	
		Split <= ~Split;
		TMPMiliSecSW <= LiveMiliSecSW ;
		TMPSecSW <= LiveSecSW ;
		TMPMinSW <= LiveMinSW;
	end

always @ (Split)
	begin
	
	
			
		case(Split)

			0: begin
				
				MiliSecSW = LiveMiliSecSW;
				SecSW = LiveSecSW;
				MinSW = LiveMinSW;
				BlinkSW = 0;
				
			end
			
			
			1: begin
				MiliSecSW <= TMPMiliSecSW;
				SecSW <= TMPSecSW;
				MinSW <= TMPMinSW;
				BlinkSW = 1;
			
			end
			
		endcase
			
	
	
	end


always @ (posedge Button1Sw)
	begin
	
		Run = ~Run;
		
	end
	
always @ (posedge Clk_100Hz)
	begin
		if(Run == 1)
			begin
			
				LiveMiliSecSW = LiveMiliSecSW + 1;
				if(LiveMiliSecSW == 100)
					begin
					
						LiveMiliSecSW = 0;
						LiveSecSW = LiveSecSW + 1;
						if(LiveSecSW == 60)
							begin
							
								LiveSecSW = 0 ;
								LiveMinSW = LiveMinSW + 1;
								if(LiveMinSW == 100)
									begin
									
										LiveMinSW = 0;
									
									end
							end
					end
				
			end
		
			
		if(Run == 0)
			begin
			
				if(Button2Sw)
					begin
					
						LiveMiliSecSW = 0;
						LiveSecSW = 0;
						LiveMinSW = 0;
					
					end
			
			end
		
	end
	
endmodule