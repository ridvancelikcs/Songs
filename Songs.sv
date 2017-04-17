//////////////////////////////////////////////////////////////////////////////////
// Company: Bilkent University 
// Engineer: Rıdvan Çelik
// 
// Create Date: 07.05.2016 02:37:22
// Design Name: 
// Module Name: Songs
// Project Name: Songs 
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


module Songs(
    input logic clk,
    input logic [15:0] sw,
    output logic sound,
    output logic [3:0] AN,
    output logic [6:0] segment,
    output logic DP
    );
    
    logic [3:0] enables;
    logic [4:0] digit3, digit2, digit0;
    logic [15:0] count;
    logic [4:0] note; 
    logic [16:0] duration;
    logic clear, dclk;
    
    always_ff@(posedge clk)
        if (count > 0) count--;                             //generates new clock 
        else begin count <= 50_000; dclk <= ~dclk; end      //so we can use duratoin as mili second
    
    always@(posedge dclk) begin
        if (clear) duration = 0;
        else duration++; end

    DisplayControl dc(clk, enables, digit3, digit2, digit0, AN, segment, DP);    
    SpeakerControl sc(clk, note, sound);  
   
    always_comb
      case (note)
        5'b00000:                                               enables = 4'b0000;          //es
        5'b11110: begin digit3 = 15;                digit0 = 3; enables = 4'b1001;  end     //f 3
        5'b11111: begin digit3 = 15; digit2 = 17;   digit0 = 3; enables = 4'b1101;  end     //f#3        
        5'b00001: begin digit3 = 16;                digit0 = 3; enables = 4'b1001;  end     //G 3
        5'b00010: begin digit3 = 16; digit2 = 17;   digit0 = 3; enables = 4'b1101;  end     //G#3
        5'b00011: begin digit3 = 10;                digit0 = 3; enables = 4'b1001;  end     //A 3
        5'b00100: begin digit3 = 10; digit2 = 17;   digit0 = 3; enables = 4'b1101;  end     //A#3
        5'b00101: begin digit3 = 11;                digit0 = 3; enables = 4'b1001;  end     //B 3
        5'b00110: begin digit3 = 12;                digit0 = 4; enables = 4'b1001;  end     //C 4
        5'b00111: begin digit3 = 12; digit2 = 17;   digit0 = 4; enables = 4'b1101;  end     //C#4
        5'b01000: begin digit3 = 13;                digit0 = 4; enables = 4'b1001;  end     //D 4
        5'b01001: begin digit3 = 13; digit2 = 17;   digit0 = 4; enables = 4'b1101;  end     //D#4
        5'b01010: begin digit3 = 14;                digit0 = 4; enables = 4'b1001;  end     //E 4
        5'b01011: begin digit3 = 15;                digit0 = 4; enables = 4'b1001;  end     //F 4
        5'b01100: begin digit3 = 15; digit2 = 17;   digit0 = 4; enables = 4'b1101;  end     //F#4
        5'b01101: begin digit3 = 16;                digit0 = 4; enables = 4'b1001;  end     //G 4
        5'b01110: begin digit3 = 16; digit2 = 17;   digit0 = 4; enables = 4'b1101;  end     //G#4
        5'b01111: begin digit3 = 10;                digit0 = 4; enables = 4'b1001;  end     //A 4
        5'b10000: begin digit3 = 10; digit2 = 17;   digit0 = 4; enables = 4'b1101;  end     //A#4
        5'b10001: begin digit3 = 11;                digit0 = 4; enables = 4'b1001;  end     //B 4 
        5'b10010: begin digit3 = 12;                digit0 = 5; enables = 4'b1001;  end     //C 5 
        5'b10011: begin digit3 = 12; digit2 = 17;   digit0 = 5; enables = 4'b1101;  end     //C#5
        5'b10100: begin digit3 = 13;                digit0 = 5; enables = 4'b1001;  end     //D 5
        5'b10101: begin digit3 = 13; digit2 = 17;   digit0 = 5; enables = 4'b1101;  end     //D#5
        5'b10110: begin digit3 = 14;                digit0 = 5; enables = 4'b1001;  end     //E 5
        5'b10111: begin digit3 = 15;                digit0 = 5; enables = 4'b1001;  end     //F 5
        5'b11000: begin digit3 = 15; digit2 = 17;   digit0 = 5; enables = 4'b1101;  end     //F#5
        5'b11001: begin digit3 = 16;                digit0 = 5; enables = 4'b1001;  end     //G 5
        5'b11010: begin digit3 = 16; digit2 = 17;   digit0 = 5; enables = 4'b1101;  end     //G#5
        5'b11011: begin digit3 = 10;                digit0 = 5; enables = 4'b1001;  end     //A 5
        5'b11100: begin digit3 = 10; digit2 = 17;   digit0 = 5; enables = 4'b1101;  end     //A#5
        5'b11101: begin digit3 = 11;                digit0 = 5; enables = 4'b1001;  end     //B 5
      endcase


    always_comb
      case(sw)
        16'b0000000000000001:   begin  clear <= 0;
//                              THE GODFATHER
                                if(500 > duration)
                                    note <= 5'b01101; //g 4
                                else if (1000 > duration)  
                                    note <= 5'b10010; //c 5   
                                else if (1500 > duration)  
                                    note <= 5'b10101; //d#5
                                else if (2000 > duration)  
                                    note <= 5'b10100; //d 5         
                                else if (2500 > duration)  
                                    note <= 5'b10010; //c 5   
                                else if (3000 > duration)  
                                    note <= 5'b10101; //d#5 
                                else if (3500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if (4000 > duration)  
                                    note <= 5'b10100; //d 5
                                else if (4500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if (5000 > duration)  
                                    note <= 5'b01110; //g#4        
                                else if (5500 > duration)  
                                    note <= 5'b10000; //a#4
                                else if (7500 > duration)  
                                    note <= 5'b01101; //g 4
                                else if (8000 > duration)  
                                    note <= 5'b00000; //es
                                else if (8500 > duration)
                                    note <= 5'b01101; //g 4
                                else if (9000 > duration)  
                                    note <= 5'b10010; //c 5   
                                else if (9500 > duration)  
                                    note <= 5'b10101; //d#5
                                else if(10000 > duration)  
                                    note <= 5'b10100; //d 5         
                                else if(10500 > duration)  
                                    note <= 5'b10010; //c 5   
                                else if(11000 > duration)  
                                    note <= 5'b10101; //d#5 
                                else if(11500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if(12000 > duration)  
                                    note <= 5'b10100; //d 5
                                else if(12500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if(13000 > duration)  
                                    note <= 5'b01101; //g 4
                                else if(13500 > duration)  
                                    note <= 5'b01100; //f#4
                                else if(15500 > duration)  
                                    note <= 5'b01011; //f 4
                                else if(16000 > duration)  
                                    note <= 5'b00000; //es
                                else if(16500 > duration)  
                                    note <= 5'b01011; //f 4 
                                else if(17000 > duration)  
                                    note <= 5'b01110; //g#4 
                                else if(17500 > duration)  
                                    note <= 5'b10001; //b 4 
                                else if(19500 > duration)  
                                    note <= 5'b10100; //d 5
                                else if(20000 > duration)  
                                    note <= 5'b00000; //es       
                                else if(20500 > duration)  
                                    note <= 5'b01011; //f 4 
                                else if(21000 > duration)  
                                    note <= 5'b01110; //g#4 
                                else if(21500 > duration)  
                                    note <= 5'b10001; //b 4 
                                else if(23500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if(24000 > duration)  
                                    note <= 5'b00000; //es        
                                else if(24500 > duration)  
                                    note <= 5'b00110; //c 4      
                                else if(25000 > duration)  
                                    note <= 5'b01001; //d#4 
                                else if(25500 > duration)  
                                    note <= 5'b10000; //a#4   
                                else if(26000 > duration)  
                                    note <= 5'b01110; //g#4      
                                else if(26500 > duration)  
                                    note <= 5'b01101; //g 4     
                                else if(27000 > duration)  
                                    note <= 5'b10000; //a#4     
                                else if(27450 > duration)  
                                    note <= 5'b01110; //g#4      
                                else if(27500 > duration)  
                                    note <= 5'b00000; //es  
                                else if(28000 > duration)  
                                    note <= 5'b01110; //g#4   
                                else if(28450 > duration)  
                                    note <= 5'b01101; //g 4  
                                else if(28500 > duration)  
                                    note <= 5'b00000; //es   
                                else if(29000 > duration)  
                                    note <= 5'b01101; //g 4   
                                else if(29500 > duration)  
                                    note <= 5'b00101; //b 3   
                                else if(31500 > duration)  
                                    note <= 5'b00110; //c 4   
                                else if(32000 > duration)  
                                    note <= 5'b00000; //es
                                
                                else if(32450 > duration)  
                                    note <= 5'b10010; //c 5 
                                else if(32500 > duration)  
                                    note <= 5'b00000; //es               
                                else if(33000 > duration)  
                                    note <= 5'b10010; //c 5 
                                else if(33500 > duration)  
                                    note <= 5'b10001; //b 4
                                else if(34950 > duration)  
                                    note <= 5'b10000; //a#4
                                else if(35000 > duration)  
                                    note <= 5'b00000; //es
                                else if(35500 > duration)  
                                    note <= 5'b10000; //a#4
                                else if(36500 > duration)  
                                    note <= 5'b10100; //d 5
                                else if(37000 > duration)  
                                    note <= 5'b10010; //c 5
                                else if(37500 > duration)  
                                    note <= 5'b01110; //g#4
                                else if(39500 > duration)  
                                    note <= 5'b01101; //g 4       
                                else if(40000 > duration)  
                                    note <= 5'b00000; //es
                                else if(40500 > duration)  
                                    note <= 5'b01101; //g 4
                                else if(41000 > duration)  
                                    note <= 5'b10000; //a#4
                                else if(41500 > duration)  
                                    note <= 5'b01101; //g 4
                                else if(43950 > duration)  
                                    note <= 5'b01011; //f 4
                                else if(44000 > duration)  
                                    note <= 5'b00000; //es        
                                else if(44500 > duration)  
                                    note <= 5'b01011; //f 4
                                else if(45000 > duration)  
                                    note <= 5'b01110; //g#4
                                else if(45500 > duration)  
                                    note <= 5'b01100; //f#4
                                else if(47500 > duration)  
                                    note <= 5'b01101; //g 4
                                else if(48000 > duration)  
                                    note <= 5'b00000; //es
                                
                                else if(48500 > duration)
                                    note <= 5'b01101; //g 4
                                else if(49000 > duration)  
                                    note <= 5'b10010; //c 5   
                                else if(49500 > duration)  
                                    note <= 5'b10101; //d#5
                                else if(50000 > duration)  
                                    note <= 5'b10100; //d 5         
                                else if(50500 > duration)  
                                    note <= 5'b10010; //c 5   
                                else if(51000 > duration)  
                                    note <= 5'b10101; //d#5 
                                else if(51500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if(52000 > duration)  
                                    note <= 5'b10100; //d 5
                                else if(52500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if(53000 > duration)  
                                    note <= 5'b01110; //g#4        
                                else if(53500 > duration)  
                                    note <= 5'b10000; //a#4
                                else if(55500 > duration)  
                                    note <= 5'b01101; //g 4
                                else if(56000 > duration)  
                                    note <= 5'b00000; //es
                                else if(56500 > duration)
                                    note <= 5'b01101; //g 4
                                else if(57000 > duration)  
                                    note <= 5'b10010; //c 5   
                                else if(57500 > duration)  
                                    note <= 5'b10101; //d#5
                                else if(58000 > duration)  
                                    note <= 5'b10100; //d 5         
                                else if(58500 > duration)  
                                    note <= 5'b10010; //c 5   
                                else if(59000 > duration)  
                                    note <= 5'b10101; //d#5 
                                else if(59500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if(60000 > duration)  
                                    note <= 5'b10100; //d 5
                                else if(60500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if(61000 > duration)  
                                    note <= 5'b01101; //g 4
                                else if(61500 > duration)  
                                    note <= 5'b01100; //f#4
                                else if(63500 > duration)  
                                    note <= 5'b01011; //f 4
                                else if(64000 > duration)  
                                    note <= 5'b00000; //es
                                else if(64500 > duration)  
                                    note <= 5'b01011; //f 4 
                                else if(65000 > duration)  
                                    note <= 5'b01110; //g#4 
                                else if(65500 > duration)  
                                    note <= 5'b10001; //b 4 
                                else if(67500 > duration)  
                                    note <= 5'b10100; //d 5
                                else if(68000 > duration)  
                                    note <= 5'b00000; //es       
                                else if(68500 > duration)  
                                    note <= 5'b01011; //f 4 
                                else if(69000 > duration)  
                                    note <= 5'b01110; //g#4 
                                else if(69500 > duration)  
                                    note <= 5'b10001; //b 4 
                                else if(71500 > duration)  
                                    note <= 5'b10010; //c 5
                                else if(72000 > duration)  
                                    note <= 5'b00000; //es        
                                else if(72500 > duration)  
                                    note <= 5'b00110; //c 4      
                                else if(73000 > duration)  
                                    note <= 5'b01001; //d#4 
                                else if(73500 > duration)  
                                    note <= 5'b10000; //a#4   
                                else if(74000 > duration)  
                                    note <= 5'b01110; //g#4      
                                else if(74500 > duration)  
                                    note <= 5'b01101; //g 4     
                                else if(75000 > duration)  
                                    note <= 5'b10000; //a#4     
                                else if(75450 > duration)  
                                    note <= 5'b01110; //g#4      
                                else if(75500 > duration)  
                                    note <= 5'b00000; //es  
                                else if(76000 > duration)  
                                    note <= 5'b01110; //g#4   
                                else if(76450 > duration)  
                                    note <= 5'b01101; //g 4  
                                else if(76500 > duration)  
                                    note <= 5'b00000; //es   
                                else if(77000 > duration)  
                                    note <= 5'b01101; //g 4   
                                else if(77500 > duration)  
                                    note <= 5'b10001; //b 4   
                                else if(79500 > duration)  
                                    note <= 5'b10010; //c 5   
                                
                                else 
                                    note <= 5'b00000; //stop
                                end       
        
        16'b0000000000000010:   begin  clear <= 0 ;
//                              GAME OF THRONES
                                if ( 1200 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 2400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 2600 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 2800 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 3600 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 4400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 4600 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 4800 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 5200 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 5600 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 5800 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 6000 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 6400 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 6800 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 7000 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 7200 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 7600 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 8000 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 8200 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 8400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 8800 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 9200 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 9400 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 9600 > duration )
                                    note <= 5'b00110; //c4
                                
                                else if ( 10800 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 12000 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 12200 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 12400 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 13200 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 14000 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 14200 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 14400 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 15600 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 16000 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 16400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 16600 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 16800 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 17200 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 17600 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 17800 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 18000 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 18400 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 18800 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 19000 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 19200 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 20400 > duration )
                                    note <= 5'b11001; //g5
                                else if ( 21600 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 21800 > duration )
                                    note <= 5'b10101; //d#5
                                else if ( 22000 > duration )
                                    note <= 5'b10111; //f5
                                 else if ( 22800 > duration )
                                    note <= 5'b11001; //g5
                                else if ( 23600 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 23800 > duration )
                                    note <= 5'b10101; //d#5
                                else if ( 24000 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 24400 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 24800 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 25000 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 25200 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 25600 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 26000 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 26200 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 26400 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 26800 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 27200 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 27400 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 27600 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 28000 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 28400 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 28600 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 28800 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 30000 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 31200 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 31400 > duration )
                                    note <= 5'b10101; //d#5
                                else if ( 31600 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 32400 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 33200 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 33400 > duration )
                                    note <= 5'b10101; //d#5
                                else if ( 33600 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 34000 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 34400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 34600 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 34800 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 35200 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 35600 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 35800 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 36000 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 36400 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 36800 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 37000 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 37200 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 37600 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 38000 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 38200 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 38400 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 39600 > duration )
                                    note <= 5'b11001; //g5
                                else if ( 40800 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 41000 > duration )
                                    note <= 5'b10101; //d#5
                                else if ( 41200 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 42000 > duration )
                                    note <= 5'b11001; //g5
                                else if ( 42800 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 43000 > duration )
                                    note <= 5'b10101; //d#5
                                else if ( 43200 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 43600 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 44000 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 44200 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 44400 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 44800 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 45200 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 45400 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 45600 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 46000 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 46400 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 46600 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 46800 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 47200 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 47600 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 47800 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 48000 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 49200 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 50400 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 51000 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 51600 > duration )
                                    note <= 5'b10101; //d#5
                                else if ( 52200 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 52800 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 53200 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 53600 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 53800 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 54000 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 54400 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 54800 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 55000 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 55200 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 55600 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 56000 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 56200 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 56400 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 56800 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 57200 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 57400 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 57600 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 58000 > duration )
                                    note <= 5'b01101; //g4///////////
                                else if ( 58400 > duration )
                                    note <= 5'b00100; //a#3//////
                                else if ( 58600 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 58800 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 59200 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 59600 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 59800 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 60000 > duration )
                                    note <= 5'b01001; //d#4
                                //else if ( 60070 > duration )
                                //    note <= 5'b00000; //es
                                    
                                else if ( 60400 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 60800 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 61000 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 61200 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 61600 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 62000 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 62200 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 62400 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 62800 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 63200 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 63400 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 63600 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 64000 > duration )
                                    note <= 5'b01101; //g4 ///////////
                                else if ( 64400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 64600 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 64800 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 65200 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 65600 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 65800 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 66000 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 66400 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 66800 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 67000 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 67200 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 67600 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 68000 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 68200 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 68400 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 68800 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 69200 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 69400 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 69600 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 70800 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 72000 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 72400 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 72800 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 73000 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 73200 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 73600 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 74000 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 74200 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 74400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 74800 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 75200 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 75400 > duration )
                                    note <= 5'b00100; //a#3
                                else if ( 75600 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 77200 > duration )
                                    note <= 5'b10010; //c5
                                else if ( 78800 > duration )
                                    note <= 5'b10000; //a#4
                                else if ( 80400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 82000 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 83600 > duration )
                                    note <= 5'b00010; //g#3
                                else if ( 84400 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 85200 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 85600 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 86000 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 86200 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 86400 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 86800 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 87200 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 87400 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 87600 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 88000 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 88400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 88600 > duration )
                                    note <= 5'b01001; //d#4
                                else if ( 88800 > duration )
                                    note <= 5'b01011; //f4
                                //else if ( 90000 > duration )
                                //	note <= 5'b10010; //c5
                                //else if ( 90200 > duration )
                                //	note <= 5'b10010; //c5
                                 
                                else 
                                    note <= 5'b00000; //stop
                                end
                                
        16'b0000000000000100:   begin  clear <= 0 ;
//1                             THE LAST OF THE MOHICANS
                                     if ( 200 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 266 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 334 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 400 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 600 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 800 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 1000 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 1200 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 1268 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 1334 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 1400 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 1600 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 1800 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 2000 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 2200 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 2400 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 2420 > duration )
                                    note <= 5'b00000; //es
                                else if ( 2620 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 2686 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 2754 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 2820 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 3020 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 3220 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 3420 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 3620 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 3688 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 3754 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 3820 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 4020 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 4220 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 4420 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 4620 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 4820 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 4840 > duration )
                                    note <= 5'b00000; //es
                                //2	
                                else if ( 5040 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 5106 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 5174 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 5240 > duration )
                                    note <= 5'b00101; //b3
                                else if ( 5440 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 5640 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 5706 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 5774 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 5840 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 6040 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 6240 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 6420 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 6440 > duration )
                                    note <= 5'b00000; //es
                                else if ( 6620 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 6640 > duration )
                                    note <= 5'b00000; //es
                                else if ( 6708 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 6774 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 6840 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 7040 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 7240 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 7260 > duration )
                                    note <= 5'b00000; //es
                                else if ( 7460 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 7526 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 7594 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 7660 > duration )
                                    note <= 5'b00101; //b3
                                else if ( 7860 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 8060 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 8126 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 8194 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 8260 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 8460 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 8660 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 8840 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 8860 > duration )
                                    note <= 5'b00000; //es
                                else if ( 9040 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 9060 > duration )
                                    note <= 5'b00000; //es
                                else if ( 9128 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 9194 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 9260 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 9460 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 9660 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 9680 > duration )
                                    note <= 5'b00000; //es
                                //3	
                                else if ( 9880 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 9946 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 10014 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 10080 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 10260 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 10280 > duration )
                                    note <= 5'b00000; //es
                                else if ( 10480 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 10546 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 10614 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 10680 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 10880 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 11080 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 11260 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 11280 > duration )
                                    note <= 5'b00000; //es
                                else if ( 11460 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 11480 > duration )
                                    note <= 5'b00000; //es
                                else if ( 11680 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 11880 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 12080 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 12100 > duration )
                                    note <= 5'b00000; //es
                                else if ( 12300 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 12366 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 12434 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 12500 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 12680 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 12700 > duration )
                                    note <= 5'b00000; //es
                                else if ( 12900 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 12966 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 13034 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 13100 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 13300 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 13500 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 13680 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 13700 > duration )
                                    note <= 5'b00000; //es
                                else if ( 13880 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 13900 > duration )
                                    note <= 5'b00000; //es
                                else if ( 14100 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 14300 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 14500 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 14520 > duration )
                                    note <= 5'b00000; //es
                                //4
                                else if ( 14720 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 14920 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 15100 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 15120 > duration )
                                    note <= 5'b00000; //es
                                else if ( 15320 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 15520 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 15720 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 15920 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 15988 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 16054 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 16120 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 16320 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 16520 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 16700 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 16720 > duration )
                                    note <= 5'b00000; //es
                                else if ( 16920 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 16940 > duration )
                                    note <= 5'b00000; //es
                                else if ( 17140 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 17340 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 17520 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 17540 > duration )
                                    note <= 5'b00000; //es
                                else if ( 17740 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 17940 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 18140 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 18340 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 18540 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 18740 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 18940 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 19140 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 19340 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 19360 > duration )
                                    note <= 5'b00000; //es
                                //1
                                else if ( 19560 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 19626 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 19694 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 19760 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 19960 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 20160 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 20360 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 20560 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 20628 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 20694 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 20760 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 20960 > duration )
                                    note <= 5'b01000; //d4
                                
                                else if ( 21160 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 21360 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 21560 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 21760 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 21780 > duration )
                                    note <= 5'b00000; //es
                                else if ( 21980 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 22046 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 22114 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 22180 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 22380 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 22580 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 22780 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 22980 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 23048 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 23114 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 23180 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 23380 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 23580 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 23780 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 23980 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 24180 > duration )
                                    note <= 5'b00001; //g3
                                else if ( 24200 > duration )
                                    note <= 5'b00000; //es
                                //2
                                else if ( 24400 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 24466 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 24534 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 24600 > duration )
                                    note <= 5'b00101; //b3
                                else if ( 24800 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 25000 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 25066 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 25134 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 25200 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 25400 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 25600 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 25780 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 25800 > duration )
                                    note <= 5'b00000; //es
                                else if ( 25980 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 26000 > duration )
                                    note <= 5'b00000; //es
                                else if ( 26068 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 26134 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 26200 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 26400 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 26600 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 26620 > duration )
                                    note <= 5'b00000; //es
                                else if ( 26820 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 26886 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 26954 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 27020 > duration )
                                    note <= 5'b00101; //b3
                                else if ( 27220 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 27420 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 27486 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 27554 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 27620 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 27820 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 28020 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 28200 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 28220 > duration )
                                    note <= 5'b00000; //es
                                else if ( 28400 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 28420 > duration )
                                    note <= 5'b00000; //es
                                else if ( 28488 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 28554 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 28620 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 28820 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 29020 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 29040 > duration )
                                    note <= 5'b00000; //es
                                //3
                                else if ( 29240 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 29306 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 29374 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 29440 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 29620 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 29640 > duration )
                                    note <= 5'b00000; //es
                                else if ( 29840 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 29906 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 29974 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 30040 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 30240 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 30440 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 30620 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 30640 > duration )
                                    note <= 5'b00000; //es
                                else if ( 30820 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 30840 > duration )
                                    note <= 5'b00000; //es
                                else if ( 31040 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 31240 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 31440 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 31460 > duration )
                                    note <= 5'b00000; //es
                                else if ( 31660 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 31726 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 31794 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 31860 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 32040 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 32060 > duration )
                                    note <= 5'b00000; //es
                                else if ( 32260 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 32326 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 32394 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 32460 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 32660 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 32860 > duration )
                                    note <= 5'b01101; //g4
                                else if ( 33040 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 33060 > duration )
                                    note <= 5'b00000; //es
                                else if ( 33240 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 33260 > duration )
                                    note <= 5'b00000; //es
                                else if ( 33460 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 33660 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 33860 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 33880 > duration )
                                    note <= 5'b00000; //es
                                //4
                                else if ( 34080 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 34280 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 34460 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 34480 > duration )
                                    note <= 5'b00000; //es
                                else if ( 34680 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 34880 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 35080 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 35280 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 35348 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 35414 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 35480 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 35680 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 35880 > duration )
                                    note <= 5'b00011; //a3
                                else if ( 36060 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 36080 > duration )
                                    note <= 5'b00000; //es
                                else if ( 36260 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 36280 > duration )
                                    note <= 5'b00000; //es
                                else if ( 36480 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 36680 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 36860 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 36880 > duration )
                                    note <= 5'b00000; //es
                                else if ( 37080 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 37280 > duration )
                                    note <= 5'b00110; //c4
                                else if ( 37480 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 37680 > duration )
                                    note <= 5'b01011; //f4
                                else if ( 37880 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 38080 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 38280 > duration )
                                    note <= 5'b01010; //e4
                                else if ( 38480 > duration )
                                    note <= 5'b01000; //d4
                                else if ( 38680 > duration )
                                    note <= 5'b00110; //c4
                                //5
                                else if ( 38800 > duration )
                                    note <= 5'b00000; //es
                                else if ( 40800 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 41100 > duration )
                                    note <= 5'b10110; //e5
                                else if ( 41400 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 43400 > duration )
                                    note <= 5'b01111; //a4
                                else if ( 43700 > duration )
                                    note <= 5'b10100; //d5
                                else if ( 44000 > duration )
                                note <= 5'b10111; //f5
                                else if ( 44300 > duration )
                                    note <= 5'b10110; //e5
                                else if ( 46300 > duration )
                                    note <= 5'b11001; //g5
                                else if ( 46600 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 48600 > duration )
                                    note <= 5'b10110; //e5
                                else if ( 48900 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 50900 > duration )
                                    note <= 5'b11011; //a5
                                else if ( 51200 > duration )
                                    note <= 5'b11001; //g5
                                else if ( 51500 > duration )
                                    note <= 5'b10111; //f5
                                else if ( 51800 > duration )
                                    note <= 5'b10110; //e5
                                else if ( 53800 > duration )
                                    note <= 5'b11001; //g5
                                else if ( 54400 > duration )
                                    note <= 5'b10110; //e5
                                else if ( 56400 > duration )
                                    note <= 5'b10100; //d5
                                else 
                                    note <= 5'b00000; //stop
                             end

//        16'b0000000000001000:
//        16'b0000000000010000:
//        16'b0000000000100000:
//        16'b0000000001000000:
//        16'b0000000010000000:
//        16'b0000000100000000:        
//        16'b0000001000000000:
//        16'b0000010000000000:
//        16'b0000100000000000:
//        16'b0001000000000000:        
//        16'b0010000000000000:
//        16'b0100000000000000:
//        16'b1000000000000000:
        default: begin clear <= 1; note = 0; end
      endcase

  
endmodule
