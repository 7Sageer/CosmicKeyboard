`timescale 1ns / 1ps

module LEARNING_MODE(
    input wire clk,
    input wire [6:0] key_in, // Keys for notes
    input wire [1:0] l_r_page, // Keys for paginf
    output wire [7 * 8 - 1:0] light,// light for leading
    output wire speaker
);

reg [5:0] songId = 5'b0;
wire [3:0] note;
wire octave_up, octave_down;

MusicLibrary music_library(
    .clk(clk),
    .key_in(key_in),
    .songId(songId),
    .light(light),
    .speaker(speaker)
);
always@(*) begin
    case (l_r_page)
        2'b10:songId = songId + (~5'b00001) + 1'b1;
        2'b01:songId = songId + 1'b1;
    endcase
end
//choose the song
//todo : check

endmodule
