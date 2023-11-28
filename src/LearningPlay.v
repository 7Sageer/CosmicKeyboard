module LearningPlay(
    input wire clk,
    input wire reset,
    input wire [6:0] key_in,
    input wire [1:0] octave_keys,
    input wire [3:0] selected_song,
    output reg speaker,
    output wire [3:0] note_out
);

localparam GAP_DURATION = 15'd500,
           SIZE = 32,
           S = 3'b000,
           A = 3'b001,
           B = 3'b010,
           C = 3'b011,
           Miss = 3'b100;


wire [3:0] note;
reg [4:0] index;
reg [31:0] counter;
reg [2:0] score = 3'b0;

reg [15:0] gap_counter;
reg [15:0] gap_delta;

wire [15:0] song_durations;
wire octave_up, octave_down;

wire piano_speaker;

reg [15:0] total_score = 0;


OctaveControl octave_control(
    .octave_keys(octave_keys),
    .octave_up(octave_up),
    .octave_down(octave_down)
);
KeyboardInput keyboard_input(
    .key_in(key_in),
    .note_out(note)
);

reg en = 1'b1;
Buzzer buzzer(
    .clk(clk),
    .note(note_out),
    .octave_up(octave_up),
    .octave_down(octave_down),
    .en(en),
    .speaker(piano_speaker)
);

SongROM song_rom(
    .address(index),
    .note(note_out),
    .note_duration(song_durations),
    .selected_song(selected_song)
);

//todo
ScoreDisplay score_display(
);
always @(posedge clk) begin
    if (reset) begin
        index <= 0;
        counter <= 0;
        speaker <= 0;
        gap_counter <= 0;
    end gap_counter <= gap_counter + 1;
end
always@(key_in) begin
    if (note == note_out) begin
        gap_delta = gap_counter - GAP_DURATION;
        gap_delta = (gap_delta[15] == 1'b1)?~gap_delta + 1'b1:gap_delta;
        if(gap_delta < 15'd150) score = S;
        else if(gap_delta < 15'd250) score = A;
        else if(gap_delta < 15'd350) score = B;
        else if(gap_delta < 15'd500) score = C;
        speaker = piano_speaker;
        gap_counter = 0;
        index = index + 1;
    end
    else begin
        score = Miss;
        gap_counter = 0;
        index = index + 1;
    end
    case(score)
        S:total_score = total_score + 4;
        A:total_score = total_score + 3;
        B:total_score = total_score + 2;
        C:total_score = total_score + 1;
    endcase
    //todo check the meaning of size and song_durations
    if (index == SIZE) begin
        total_score = total_score / 4 / song_durations;
        index = 0;
    end
end

endmodule
