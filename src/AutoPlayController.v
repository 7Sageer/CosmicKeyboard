module AutoPlayController(
    input wire clk,
    input wire reset,
    input wire next_song,
    input wire prev_song,
    output reg [3:0] song_number,
    output wire [7:0] display_output,
    output wire speaker,
    output wire [3:0] note_out,
    output wire tub_sel,
    output reg [6:0] led
);

localparam TOTAL_SONGS = 2;
always @(posedge clk or posedge reset) begin
    if (reset) begin
    end else begin
        if (next_song && song_number < TOTAL_SONGS - 1) begin
            song_number <= song_number + 1;
        end else if (prev_song && song_number > 0) begin
            song_number <= song_number - 1;
        end

        case(note_out)
            1: begin
                led <= 7'b0000001;
            end
            2: begin
                led <= 7'b0000010;
            end
            3: begin
                led <= 7'b0000100;
            end
            4: begin
                led <= 7'b0001000;
            end
            5: begin
                led <= 7'b0010000;
            end
            6: begin
                led <= 7'b0100000;
            end
            7: begin
                led <= 7'b1000000;
            end
            default: begin
                led <= 7'b0000000;
            end
        endcase
    end
end

AutoPlay auto_play(
    .clk(clk),
    .reset(reset),
    .selected_song(song_number),
    .speaker(speaker),
    .note_out(note_out)
);

SevenSegmentDecoder decoder(
    .digit(song_number),
    .display(display_output),
    .tub_sel(tub_sel)
);

endmodule
