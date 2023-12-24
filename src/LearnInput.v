`timescale 1ns / 1ps
module LearnInput(
    input wire [6:0] key_in, // 7-bit input representing the keys
    output reg [3:0] note_out // 4-bit output for the note
);

always @(*) begin
    note_out = 0; // Default to no note
    case(key_in)
        7'b100_000_0: note_out = 1;
        7'b010_000_0: note_out = 2;
        7'b001_000_0: note_out = 3;
        7'b000_100_0: note_out = 4;
        7'b000_010_0: note_out = 5;
        7'b000_001_0: note_out = 6;
        7'b000_000_1: note_out = 7;
        default: note_out = 0;
    endcase
end

endmodule