`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2016 02:38:01
// Design Name: 
// Module Name: SpeakerControl
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


module SpeakerControl(
    input logic clk,
    input logic [4:0] note,
    output logic audio
    );
       
    logic [18:0] count;
    logic [18:0] value;

    always_ff @(posedge clk)
        if(count > 0)  count--; 
        else begin count <= value; audio <= ~audio; end
        
    always_comb
      case (note)
        // These values are wave lengths of notes with respect to time (10 nano sec)
        // value = 100,000,000 / (frequency of notes / 2)
        5'b00000: value = 1000;     //es
        5'b00001: value = 254817;   //G 3
        5'b00010: value = 240790;   //G#3
        5'b00011: value = 227273;   //A 3
        5'b00100: value = 214519;   //A#3
        5'b00101: value = 202478;   //B 3
        5'b00110: value = 191113;   //C 4
        5'b00111: value = 180388;   //C#4
        5'b01000: value = 170262;   //D 4
        5'b01001: value = 160705;   //D#4
        5'b01010: value = 151685;   //E 4
        5'b01011: value = 143172;   //F 4
        5'b01100: value = 135139;   //F#4
        5'b01101: value = 127553;   //G 4
        5'b01110: value = 120395;   //G#4
        5'b01111: value = 113636;   //A 4
        5'b10000: value = 107259;   //A#4
        5'b10001: value = 101238;   //B 4 
        5'b10010: value = 95557;    //C 5 
        5'b10011: value = 90194;    //C#5
        5'b10100: value = 85131;    //D 5
        5'b10101: value = 80353;    //D#5
        5'b10110: value = 75843;    //E 5
        5'b10111: value = 71587;    //F 5
        5'b11000: value = 67569;    //F#5
        5'b11001: value = 63776;    //G 5
        5'b11010: value = 60197;    //G#5
        5'b11011: value = 56818;    //A 5
        5'b11100: value = 53629;    //A#5
        5'b11101: value = 50619;    //B 5
        5'b11110: value = 286344;    //f 3
        5'b11111: value = 270278;    //f#3
      endcase
    
endmodule
