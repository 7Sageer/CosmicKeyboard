`timescale 1ns / 1ps

module OctaveControl(
    input wire [1:0] octave_keys, // Two keys for octave control
    output reg octave_up, // Octave up control
    output reg octave_down // Octave down control
);

always @(*) begin
    octave_up = octave_keys[0]; // Assuming first bit for octave up
    octave_down = octave_keys[1]; // Assuming second bit for octave down
end

endmodule