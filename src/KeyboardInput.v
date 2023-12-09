`timescale 1ns / 1ps
module KeyboardInput(
    input wire [6:0] key_in, // 7-bit input representing the keys
    input wire [3:0] note_ad,
    input wire [6:0] key_mapping_0, // Mapping for note 0
    input wire [6:0] key_mapping_1, // Mapping for note 1
    input wire [6:0] key_mapping_2, // Mapping for note 2
    input wire [6:0] key_mapping_3, // Mapping for note 3
    input wire [6:0] key_mapping_4, // Mapping for note 4
    input wire [6:0] key_mapping_5, // Mapping for note 5
    input wire [6:0] key_mapping_6, // Mapping for note 6
    input wire adjustment_mode,
    output reg [3:0] note_out // 4-bit output for the note
);


always @(*) begin
    note_out = 0; // Default to no note
    if (adjustment_mode) note_out = note_ad;
    else if (key_in & key_mapping_0) note_out = 1;
    else if (key_in & key_mapping_1) note_out = 2;
    else if (key_in & key_mapping_2) note_out = 3;
    else if (key_in & key_mapping_3) note_out = 4;
    else if (key_in & key_mapping_4) note_out = 5;
    else if (key_in & key_mapping_5) note_out = 6;
    else if (key_in & key_mapping_6) note_out = 7;
end

endmodule

