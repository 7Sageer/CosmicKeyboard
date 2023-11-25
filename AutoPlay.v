module AutoPlay(
    input wire clk,
    input wire reset,
    input wire [1:0] octave_keys,
    input wire [3:0] selected_song,
    output reg speaker,
    output wire [3:0] note_out
);

localparam GAP_DURATION = 15'd500;
localparam SIZE = 32;


reg [4:0] index;
reg [31:0] counter;

reg in_gap;
reg [15:0] gap_counter;

wire [15:0] song_durations;
wire octave_up, octave_down;

wire piano_speaker;


OctaveControl octave_control(
    .octave_keys(octave_keys),
    .octave_up(octave_up),
    .octave_down(octave_down)
);
Buzzer buzzer(
    .clk(clk),
    .note(note_out),
    .octave_up(octave_up),
    .octave_down(octave_down),
    .speaker(piano_speaker)
);

SongROM song_rom(
    .address(index),
    .note(note_out),
    .note_duration(song_durations),
    .selected_song(selected_song)
);

always @(posedge clk) begin
    if (reset) begin
        index <= 0;
        counter <= 0;
        speaker <= 0;
        in_gap <= 0;
        gap_counter <= 0;
    end else if (in_gap) begin
        if (gap_counter < GAP_DURATION) begin
            gap_counter <= gap_counter + 1;
            speaker <= 0;
        end else begin
            in_gap <= 0;
            gap_counter <= 0;
            index <= index + 1;
            if (index == SIZE) begin
                index <= 0;
            end
        end
    end else begin
        if (counter < song_durations) begin
            counter <= counter + 1;
            speaker <= piano_speaker;
        end else begin
            counter <= 0;
            in_gap <= 1;
            gap_counter <= 0;
        end
    end
end


endmodule
