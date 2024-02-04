/**
 * @(#)SongEditor.java
 * @author Rıdvan Çelik
 * @version 1.00 2016/5/13
 * 
 * This program is to help for writng notes as system verilog code
 * You should write note name with octave press enter then write its duratios as millisecond press enter 
 * Example: A3 + enter + 200 + enter
 * End of the composition, program will out a txt file including some part of system verilog code.
 */
 
import java.util.*;
import java.io.*;

public class SongEditor{
        
	private static Scanner scan = new Scanner(System.in);
	private static PrintWriter outFile;
	private static int duration=0, totDuration=0;
	private static String noteName, noteValue, str1, str2;

    public static void main(String[] args) throws IOException {
    	
    	File myFile = new File("Sample.txt");
        outFile = new PrintWriter(myFile);
        System.out.print ("duration till now on: ");
        totDuration = scan.nextInt();

		do{
			System.out.print ("note name: ");
			noteName = scan.next();
			if(noteName.equalsIgnoreCase("-1"))
				break;
			System.out.print ("duration as mili second: ");
			duration = scan.nextInt();
			totDuration += duration;
			str1 = "else if ( " + totDuration + " > duration )";
			str2 = "\tnote <= 5'b" + valueOfNote(noteName) + "; //" + noteName;
			outFile.println(str1);
			outFile.println(str2);						
		}while(true);
  	
    	outFile.close();
    }
       
    private static String valueOfNote (String noteName){
    	String noteValue;  	
    	switch(noteName.toLowerCase()){
    		case "es":	noteValue = "00000";	break;
    		case "g3":	noteValue = "00001";	break;
    		case "g#3":	noteValue = "00010";	break;
    		case "a3":	noteValue = "00011";	break;
    		case "a#3":	noteValue = "00100";	break;
    		case "b3":	noteValue = "00101";	break;
    		case "c4":	noteValue = "00110";	break;
    		case "c#4":	noteValue = "00111";	break;
    		case "d4":	noteValue = "01000";	break;
    		case "d#4":	noteValue = "01001";	break;
    		case "e4":	noteValue = "01010";	break;
    		case "f4":	noteValue = "01011";	break;
    		case "f#4":	noteValue = "01100";	break;
    		case "g4":	noteValue = "01101";	break;
    		case "g#4":	noteValue = "01110";	break;
    		case "a4":	noteValue = "01111";	break;		
    		case "a#4":	noteValue = "10000";	break;
    		case "b4":	noteValue = "10001";	break;	
    		case "c5":	noteValue = "10010";	break;
    		case "c#5":	noteValue = "10011";	break;
    		case "d5":	noteValue = "10100";	break;
    		case "d#5":	noteValue = "10101";	break;		
    		case "e5":	noteValue = "10110";	break;
    		case "f5":	noteValue = "10111";	break;
    		case "f#5":	noteValue = "11000";	break;
    		case "g5":	noteValue = "11001";	break;
    		case "g#5":	noteValue = "11010";	break;
    		case "a5":	noteValue = "11011";	break;		
    		case "a#5":	noteValue = "11100";	break;
    		case "b5":	noteValue = "11101";	break;
    		case "f3":	noteValue = "11110";	break;
    		case "f#3":	noteValue = "11111";	break;			
    		default: noteValue = "00000";	break;
    	}    	
    	return noteValue;  	
    }
    
}
//      case (note)
//        // These values are wave lengths of notes with respect to time (10 nano sec)
//        // value = 100,000,000 / (frequency of notes / 2)
//        5'b00000: value = 1000;     //es
//        5'b00001: value = 255102;   //G 3
//        5'b00010: value = 240790;   //G#3
//        5'b00011: value = 227273;   //A 3
//        5'b00100: value = 214519;   //A#3
//        5'b00101: value = 202478;   //B 3
//        5'b00110: value = 191113;   //C 4
//        5'b00111: value = 180388;   //C#4
//        5'b01000: value = 170262;   //D 4
//        5'b01001: value = 160705;   //D#4
//        5'b01010: value = 151685;   //E 4
//        5'b01011: value = 143172;   //F 4
//        5'b01100: value = 135139;   //F#4
//        5'b01101: value = 127553;   //G 4
//        5'b01110: value = 120395;   //G#4
//        5'b01111: value = 113636;   //A 4
//        5'b10000: value = 107259;   //A#4
//        5'b10001: value = 101238;   //B 4 
//        5'b10010: value = 95557;    //C 5 
//        5'b10011: value = 90194;    //C#5
//        5'b10100: value = 85131;    //D 5
//        5'b10101: value = 80353;    //D#5
//        5'b10110: value = 75843;    //E 5
//        5'b10111: value = 71587;    //F 5
//        5'b11000: value = 67569;    //F#5
//        5'b11001: value = 63776;    //G 5
//        5'b11010: value = 60197;    //G#5
//        5'b11011: value = 56818;    //A 5
//        5'b11100: value = 53629;    //A#5
//        5'b11101: value = 50619;    //B 5
