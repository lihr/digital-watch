module Timekeeper(

input Clk_50Mhz,

input Button1Tk,
input Button2Tk,

output reg [5:0]SecTk = 0,
output reg [5:0]MinTk = 0,
output reg [4:0]HrTk = 0,

output reg[1:0]Edit


);

reg Clk_10Hz = 1;
reg [27:0]Counter;
//***********************Clock divider**************//
always @ (posedge Clk_50Mhz)
	begin
		
		if(Counter == 5_000_000)
			begin
				Clk_10Hz <= ~Clk_10Hz;
				Counter <=0;
			end
		else
			begin
				Counter <= Counter +1;
			end
		
	end

//***********************Time update**************//
reg [2:0]Counter_T;
always @ (posedge Clk_10Hz)
	begin
		Counter_T = Counter_T + 1;
		if(Counter_T == 5)
			begin
			
				Counter_T = 0;
				SecTk = SecTk + 1;
				
				if(SecTk == 60)
					begin
					
						SecTk = 0;
						MinTk = MinTk + 1;
						
						if(MinTk == 60)
							begin
								
								MinTk = 0;
								HrTk = HrTk + 1;
								
								if(HrTk == 24)
									begin
									
										HrTk = 0;
									
									end	
							end
					end
			end
		if(Button2Tk)
			begin
				case(Edit)
					
					1:begin
					
						SecTk = 0;
					
					end
					
					
					2:begin
						
						MinTk = MinTk + 1;
						
						if(MinTk == 60)
							begin
								
								MinTk = 0;
							end
					
					end
					
					3:begin
						
						HrTk = HrTk + 1;
								
								if(HrTk == 24)
									begin
									
										HrTk = 0;
									
									end	
					end
				
				endcase
			end
	end

always @ (posedge Button1Tk)//changes the position of the cursor
	begin
		Edit = Edit + 1;
	end
	
endmodule