`timescale 1ns / 1ps
module Main(
    input wire clk,
    input wire [2:0] mode_select,
    input wire [6:0] key_in,
    input wire [1:0] octave_keys,
    input wire adjustment_switch, // Switch to enter adjustment mode
    input wire confirm_button,
    input wire next_song,
    input wire prev_song,
    input wire reset,
//    output wire [3:0] note_out,
    output wire speaker,
    output wire tub_sel_song_num,
    output wire [7:0] song_num,
    output wire loud,
    output wire [6:0] led
);

localparam FREE_MODE = 3'd0;
localparam AUTO_PLAY_MODE = 3'd1;
localparam LEARNING_MODE = 3'd2;

reg [2:0] current_mode;

wire [3:0] note_out;
wire [3:0] note_free;
wire [3:0] note_auto;
wire [3:0] note_learn;

wire piano_speaker;
wire auto_play_speaker;
wire learn_speaker;
ElectronicPiano piano(
    .clk(clk),
    .reset(reset),
    .adjustment_switch(adjustment_switch),
    .confirm_button(confirm_button),
    .key_in(key_in),
    .octave_keys(octave_keys),
    .speaker(piano_speaker)
);

AutoPlayController auto_play_controller(
    .clk(clk),
    .reset(reset),
    .next_song(next_song),
    .prev_song(prev_song),
    .tub_sel(tub_sel_song_num),
    .display_output(song_num),
    .speaker(auto_play_speaker),
    .note_out(note_auto)
);
wire [6:0] learn_show_led;
LearningConroller learning_controller(
    .clk(clk),
    .key_in(key_in),
    .reset(reset),
    .next_song(next_song),
    .prev_song(prev_song),
    .tub_sel(tub_sel_song_num),
    .display_output(song_num),
    .speaker(learn_speaker),
    .learn_show_led(learn_show_led),
    .note_out(note_auto)
);
// AutoPlay auto_play(
//     .clk(clk),
//     .res
// )
//TODO: Add other modules here

always @(posedge clk) begin
    if (reset) begin
        current_mode <= FREE_MODE;
    end else begin
        case (mode_select)
            FREE_MODE: current_mode <= FREE_MODE;
            AUTO_PLAY_MODE: current_mode <= AUTO_PLAY_MODE;
            LEARNING_MODE: current_mode <= LEARNING_MODE;
            default: current_mode <= FREE_MODE;
        endcase
    end
end
//always @(posedge clk) begin
//    case (mode_select)
//        FREE_MODE: current_mode <= FREE_MODE;
//        AUTO_PLAY_MODE: current_mode <= AUTO_PLAY_MODE;
//        LEARNING_MODE: current_mode <= LEARNING_MODE;
//        default: current_mode <= FREE_MODE;
//    endcase
//end

//TODO: Add other modes here
assign speaker = (current_mode == FREE_MODE) ? piano_speaker :
                 (current_mode == AUTO_PLAY_MODE) ? auto_play_speaker : learn_speaker;

//assign speaker = piano_speaker;

//assign note_out = (current_mode == FREE_MODE) ? note_free :
//                  (current_mode == AUTO_PLAY_MODE) ? note_auto : 0;

assign led = (current_mode == LEARNING_MODE)? learn_show_led:key_in;
assign loud = 1;
endmodule