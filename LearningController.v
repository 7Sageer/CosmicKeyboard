module LearningConroller(
    input wire clk,
    input wire [6:0] key_in,
    input wire reset,
    input wire next_song,
    input wire prev_song,
    output reg [3:0] song_number,
    output wire [7:0] display_output,
    output wire speaker,
    output wire [6:0] learn_show_led,
    output wire tub_sel,
    output wire [7:0] score2,
    output wire tub_1,
    output wire tub_2
);
localparam TOTAL_SONGS = 2;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        song_number <= 0;
    end else begin
        if (next_song && song_number < TOTAL_SONGS - 1) begin
            song_number <= song_number + 1;
        end else if (prev_song && song_number > 0) begin
            song_number <= song_number - 1;
        end
    end
end
LearningPlay learning_play(
    .clk(clk),
    .reset(reset),
    .key_in(key_in),
    .selected_song(song_number),
    .learn_show_led(learn_show_led),
    .speaker(speaker),
    .tub_1(tub_1),
    .tub_2(tub_2),
    .score2(score2)
);
SevenSegmentDecoder decoder(
    .digit(song_number),
    .display(display_output),
    .tub_sel(tub_sel)
);
//todo show the scores
endmodule