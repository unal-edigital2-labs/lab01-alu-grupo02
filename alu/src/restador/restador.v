`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:47 09/15/2020 
// Design Name: 
// Module Name:    restador 
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
module restador(
    init, xi, yi,co,sal);

  input init;
  input [3 :0] xi;
  input [3 :0] yi;
  output co;
  output [3 :0] sal;
  
  
  wire [4:0] st;
  assign sal= st[3:0];
  assign Cout = st[4];

  assign st  = 	xi-yi;



endmodule
