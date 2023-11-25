`timescale 1ns / 1ps

module KeyboardInput(
    input wire [6:0] key_in, // 8-bit input representing the keys
    output reg [3:0] note_out // 4-bit output for the note
);

always @(*) begin
    case (key_in)
        7'b0000001: note_out = 1; // do
        7'b0000010: note_out = 2; // re
        7'b0000100: note_out = 3; 
        7'b0001000: note_out = 4; 
        7'b0010000: note_out = 5; 
        7'b0100000: note_out = 6; 
        7'b1000000: note_out = 7; 
        default: note_out = 0; // No note
    endcase
end

endmodule
