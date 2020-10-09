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
wire z;

reg [2:0] status =0;

// bloque comparador
assign z=(A[2]==0)?1:0;


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
		done=0;
		lda=0;
		init=1;
		dv0=0;
    sh=0;
		dec=0;
		if (init) begin
			status=SHIFT_DEC;
		end
		end
	CHECK: begin
	done=0;
	lda=0;
	init=0;
	dv0=0;
	sh=0;
	dec=0;
		if (z==0) begin
		   if (A[2]==0)begin
			 status=ADD;
			 end
			 if (A[2]==1)begin
			 status=SHIFT_DEC;
			 end
		end
		else begin
		status=END1;
		end
		end

	ADD: begin
	done=0;
	lda=1;
	init=0;
	dv0=1;
	sh=0;
	dec=0;
	if (z==0)begin
	  status=SHIFT_DEC;
	end
	else begin
	  status=END1;
	end
	end

	SHIFT_DEC: begin
	done=0;
	lda=0;
	init=0;
	dv0=dv0;
	sh=1;
	dec=1;
	status=CHECK;
	end

	END1: begin
	done=1;
	lda=0;
	init=0;
	dv0=0;
	sh=0;
	dec=0;
	end
	 default:
		status =START;

	endcase

end


endmodule
