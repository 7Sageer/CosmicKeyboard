`timescale 1ns / 1ps

//module ElectronicPiano(
//    input wire clk,
//    input wire [6:0] key_in,
//    output wire speaker
//);

//wire [3:0] note;
//KeyboardInput keyboard(.key_in(key_in), .note_out(note));
//Buzzer buzzer(.clk(clk), .note(note), .speaker(speaker));

//endmodule

module ElectronicPiano(
    input wire clk,
    input wire [6:0] key_in, // Keys for notes
    input wire [1:0] octave_keys, // Keys for octave control
    output wire speaker
);

wire [3:0] note;
wire octave_up, octave_down;

KeyboardInput keyboard_input(
    .key_in(key_in),
    .note_out(note)
);

OctaveControl octave_control(
    .octave_keys(octave_keys),
    .octave_up(octave_up),
    .octave_down(octave_down)
);

Buzzer buzzer(
    .clk(clk),
    .note(note),
    .octave_up(octave_up),
    .octave_down(octave_down),
    .speaker(speaker)
);

endmodule
