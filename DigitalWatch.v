module DigitalWatch(

input Clk_50MHz,

input Button0_Rw,//reseved button "Mode"
input Button1_Rw,
input Button2_Rw,
input Button3_Rw,

output [6:0]Sec0,
output [6:0]Sec1,
output [6:0]Min0,
output [6:0]Min1,
output [6:0]Hr0,
output [6:0]Hr1,
output [6:0]AlmSeg,
output [6:0]State0,

output BuzzerBit,

output button0Led,
output button1Led,
output button2Led,
output button3Led

);

assign button0Led = Button0;
assign button1Led = Button1Sw;
assign button2Led = Button2Sw;
assign button3Led = Button3Sw;

//************Display State**************//
reg [1:0]State = 0;

reg StateTk;
reg StateSW;
reg StateAlm;

always @ (posedge Button0)
	begin
		
		State = State + 1;
		if (State == 3)
			begin
				
				State = 0 ;
			
			end

	end
////************Signal Debouncer**************//
wire Button0;
wire Button1;
wire Button2;
wire Button3;

SignalDebounce SD0(Clk_50MHz,Button0_Rw,Button0);
SignalDebounce SD1(Clk_50MHz,Button1_Rw,Button1);
SignalDebounce SD2(Clk_50MHz,Button2_Rw,Button2);
SignalDebounce SD3(Clk_50MHz,Button3_Rw,Button3);

//************Button Functions**************//
wire Button1Tk;
wire Button2Tk;
wire Button3Tk;//pass through to stop the alarm

wire Button1Sw;
wire Button2Sw;
wire Button3Sw;

wire Button1Alm;
wire Button2Alm;
wire Button3Alm;


//Buttons for Time keeper
assign Button1Tk = StateTk & Button1;
assign Button2Tk = StateTk & Button2;
//assign Button3Tk = StateTk & Button3;

//Buttons for Stop Watch

assign Button1Sw = StateSW & Button1;
assign Button2Sw = StateSW & Button2;
assign Button3Sw = StateSW & Button3;

//Button Functions for Alarm

assign Button1Alm = StateAlm & Button1;
assign Button2Alm = StateAlm & Button2;
assign Button3Alm = (StateTk & Button3) | (StateAlm & Button3);

	
always @(State)
	begin
		case(State)
				
				0: begin
					
					SecBuffer = SecTk;
					MinBuffer = MinTk;
					HrBuffer = HrTk;
					
					StateTk = 1;
					StateSW = 0;
					StateAlm = 0;
					
					case(Blink)
						0: begin
							BlinkSecBuff= 1'b0;
							BlinkMinBuff = 1'b0;
							BlinkHrBuff = 1'b0;
						
						end
						
						1:begin
							
							BlinkSecBuff= 1'b1;
							BlinkMinBuff = 1'b0;
							BlinkHrBuff = 1'b0;

						
						end
						
						
						2:begin
							
							BlinkSecBuff= 1'b0;
							BlinkMinBuff = 1'b1;
							BlinkHrBuff = 1'b0;
						
						end
						
						
						3:begin
							
							BlinkSecBuff= 1'b0;
							BlinkMinBuff = 1'b0;
							BlinkHrBuff = 1'b1;
						
						end
					
					
					endcase
					
				
				end
				
				1: begin
				
					
					SecBuffer = MiliSecSW;
					MinBuffer = SecSW;
					HrBuffer = MinSW;
					
					StateTk = 0;
					StateSW = 1;
					StateAlm = 0;
					
					case(BlinkSW)
						
						0:	begin
							BlinkSecBuff= 1'b0;
							BlinkMinBuff = 1'b0;
							BlinkHrBuff = 1'b0;
						
						
						end
						
						
						
						1: begin
							BlinkSecBuff= 1'b1;
							BlinkMinBuff = 1'b1;
							BlinkHrBuff = 1'b1;
						
						
						end
						
					endcase
				
				end
				
				2: begin
					
					MinBuffer = MinAlm;
					HrBuffer = HrAlm;
					SecBuffer = 0;
						
					StateTk = 0;
					StateSW = 0;
					StateAlm = 1;
					
					case(BlinkAlm)
						0: begin
							BlinkSecBuff= 1'b0;
							BlinkMinBuff = 1'b0;
							BlinkHrBuff = 1'b0;
						
						end
						
						1:begin
							
							BlinkSecBuff= 1'b0;
							BlinkMinBuff = 1'b1;
							BlinkHrBuff = 1'b0;

						
						end
						
						
						2:begin
							
							BlinkSecBuff= 1'b0;
							BlinkMinBuff = 1'b0;
							BlinkHrBuff = 1'b1;
						
						end
						
						
						3:begin
							
							BlinkSecBuff= 1'b0;
							BlinkMinBuff = 1'b0;
							BlinkHrBuff = 1'b0;
						
						end
					endcase
				end
			endcase
	
	end
//*****************Stop Watch***************//
wire [6:0]MiliSecSW;
wire [5:0]SecSW;
wire [4:0]MinSW;
wire BlinkSW;

Stopwatch S0(Clk_50MHz,Button1Sw,Button2Sw,Button3Sw,MiliSecSW,SecSW,MinSW,BlinkSW);

//*****************Alarm********************//

wire [5:0]MinAlm;
wire [4:0]HrAlm;
wire Alarm;
wire [1:0]BlinkAlm;

Alarm A0 (SecTk,MinTk,HrTk,Button1Alm,Button2Alm,Button3Alm,MinAlm,HrAlm,Alarm,BuzzerBit,BlinkAlm);


//*****************RTC********************//

wire [5:0]SecTk;
wire [5:0]MinTk;
wire [4:0]HrTk;
wire [1:0]Blink;

Timekeeper Tk0(Clk_50MHz,Button1Tk,Button2Tk,SecTk,MinTk,HrTk,Blink );

//----------------------------------------//
//************Display Driver**************//
reg [6:0]SecBuffer;
reg [6:0]MinBuffer;
reg [6:0]HrBuffer;
reg [1:0]AlmBuffer;

reg BlinkSecBuff;
reg BlinkMinBuff;
reg BlinkHrBuff;


DisplayDriver D0(SecBuffer,Clk_50MHz,BlinkSecBuff,Sec0,Sec1);
DisplayDriver D1(MinBuffer,Clk_50MHz,BlinkMinBuff,Min0,Min1);
DisplayDriver D2(HrBuffer,Clk_50MHz,BlinkHrBuff,Hr0,Hr1);
DisplayAlarmState D3(Alarm, AlmSeg);
SingleDigit D4(State,State0);
//----------------------------------------//

endmodule