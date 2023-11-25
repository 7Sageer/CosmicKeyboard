`timescale 1ns / 1ps
module Main(
    input wire clk,
    input wire [2:0] mode_select, 
    input wire [6:0] key_in, 
    input wire [1:0] octave_keys,
    input wire next_song,
    input wire prev_song,
    input wire reset,
    output wire speaker,
    output wire [6:0] song_num
);

localparam FREE_MODE = 3'd0;
localparam AUTO_PLAY_MODE = 3'd1;
localparam LEARNING_MODE = 3'd2;

reg [2:0] current_mode;

wire [3:0] note;
wire piano_speaker;
wire auto_play_speaker;
ElectronicPiano piano(
    .clk(clk),
    .key_in(key_in),
    .octave_keys(octave_keys),
    .speaker(piano_speaker)
);
AutoPlayController auto_play_controller(
    .clk(clk),
    .reset(reset),
    .next_song(next_song),
    .prev_song(prev_song),
    //.song_number(),
    .display_output(song_num),
    .speaker(auto_play_speaker)
);
//TODO: Add other modules here

always @(posedge clk) begin
    case (mode_select)
        FREE_MODE: current_mode <= FREE_MODE;
        AUTO_PLAY_MODE: current_mode <= AUTO_PLAY_MODE;
        LEARNING_MODE: current_mode <= LEARNING_MODE;
        default: current_mode <= FREE_MODE;
    endcase
end

//TODO: Add other modes here
assign speaker = (current_mode == FREE_MODE) ? piano_speaker : 
                 (current_mode == AUTO_PLAY_MODE) ? auto_play_speaker : 0;
endmodule

