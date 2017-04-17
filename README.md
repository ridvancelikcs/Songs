# Songs
monophonic songs on the fpga board (BASYS3)

This project includes one-bit songs. 
Each note between F3 and B5 has their uniqe square wave time length. 
To get these wave length the formula is half wave length =100,000,000 / (frequency of notes / 2) since BASYS3 board has 100 MHz clock.
For example A note of the 4th octave's wave length is 100,000,000 / (440/2) = 454,545. 
That means to get A4 note, output signal should be 0 during 4545.45 nanosecond,
then it should be 1 during the same time interval and oscillates in the same way. 
After we create the keys, now it is time to write songs.

Note: the output signal pin is K17. You should plug in your mini speaker's wires to K17 pin and ground on BASYS3 board.

Here is the demo video. watch and enjoy :D
https://www.youtube.com/watch?v=jtOrFZe8aa0
