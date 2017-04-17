`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2016 02:00:34
// Design Name: 
// Module Name: DisplayControl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DisplayControl(
    input logic clk,
    input logic [3:0] enables,
    input logic [4:0] digit3, digit2, digit0,
    output logic [3:0] AN,
    output logic [6:0] segment,
    output logic DP
    );
    
    logic [4:0] current_digit;
    logic [3:0] cur_dig_AN;
    logic [6:0] segments;
    
    assign AN = ~(enables & cur_dig_AN);// AN signals are active low,       
    assign DP = 1;      
                            
    logic [18:0] count, nextcount;
    
    always_ff @(posedge clk)
         count <= nextcount;
    
    always_comb
        nextcount = count + 1;
        
    always_comb
      case (count[18:17])
        2'b00: begin current_digit = digit3; cur_dig_AN = 4'b1000; end  
        2'b01: begin current_digit = digit2; cur_dig_AN = 4'b0100; end
        2'b10: begin                         cur_dig_AN = 4'b0000; end
        2'b11: begin current_digit = digit0; cur_dig_AN = 4'b0001; end
    endcase      
    
    always @(current_digit)
      case (current_digit)
//        5'b00000: segment = 7'b0000001;   //0
//        5'b00001: segment = 7'b1001111;   //1
//        5'b00010: segment = 7'b0010010;   //2
        5'b00011: segment = 7'b0000110;   //3
        5'b00100: segment = 7'b1001100;   //4
        5'b00101: segment = 7'b0100100;   //5
//        5'b00110: segment = 7'b0100000;   //6
//        5'b00111: segment = 7'b0001111;   //7
//        5'b01000: segment = 7'b0000000;   //8
//        5'b01001: segment = 7'b0000100;   //9
        5'b01010: segment = 7'b0001000;   //A
        5'b01011: segment = 7'b1100000;   //B
        5'b01100: segment = 7'b0110001;   //C
        5'b01101: segment = 7'b1000010;   //D
        5'b01110: segment = 7'b0110000;   //E
        5'b01111: segment = 7'b0111000;   //F
        5'b10000: segment = 7'b0100001;   //G
        5'b10001: segment = 7'b1001000;   //H
    endcase    
endmodule
