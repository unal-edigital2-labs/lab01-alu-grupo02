`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    18:40:46 09/13/2019
// Design Name:
// Module Name:    divisor
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module divisor( input [2:0] DV,
							 input [2:0] DR,
							input init,
							 input clk,
							 output reg [5:0] pp,
							 output reg done
    );

reg sh;
reg rst;
reg add;
reg count;
reg [5:0] A;
reg [2:0] B;
wire z;

reg [2:0] status =0;

// bloque comparador
assign z=(B==0)?1:0;


//bloques de registros de desplazamiento para A y B
always @(posedge clk) begin

	if (rst) begin
		A = {3'b000,DV};
		count=3;
	end
	else	begin
		if (sh) begin
			A= A << 1;
			count=count-1;
		end
	end

end

//bloque de add pp
always @(posedge clk) begin

	if (rst) begin
		pp =0;
	end
	else	begin
		if (add) begin
		pp =pp+A;
		end
	end

end

// FSM
parameter START =0,  CHECK =1, ADD =2, SHIFT_DEC =3, END1 =4;

always @(posedge clk) begin
	case (status)
	START: begin
		SH=0;
		DONE=0;
		LDA=0
		if (START) begin
			status=SHIFT_DEC;
			DONE =0;
			rst=1;
		end
		end
	CHECK: begin
		done=0;
		rst=0;
		sh=0;
		add=0;
		if (B[0]==1)
			status=ADD;
		else
			status=SHIFT;
		end
	ADD: begin
		done=0;
		rst=0;
		sh=0;
		add=1;
		status=SHIFT;
		end
	SHIFT_DEC: begin
		done=0;
		rst=0;
		sh=1;
		add=0;
		if (z==1)
			status=END1;
		else
			status=CHECK;
		end
	END1: begin
		done =1;
		rst =0;
		sh =0;
		add =0;
		status =START;
	end
	 default:
		status =START;
	endcase

end


endmodule
