module LearningPlay(
    input wire clk,
    input wire reset,
    input wire [6:0] key_in,
    input wire [1:0] octave_keys,
    input wire [3:0] selected_song,
    output reg [6:0] learn_show_led,
    output reg speaker,
    output wire [3:0] note_out
);
localparam GAP_DURATION = 15'd1000_000_000;
localparam SIZE = 32,
           S = 3'b000,
           A = 3'b001,
           B = 3'b010,
           C = 3'b011,
           Miss = 3'b100,
           BATCH_SIZE = 20,
           GAP_BATCH_SIZE = 400;


reg [4:0] index; // current index of the song notes
reg [31:0] counter; // current counter for the note duration
reg [31:0] batch_counter; // current counter for the batch duration
reg [31:0] prev_cnt;
reg in_gap; // whether the current state is in a gap
reg [15:0] gap_counter; // current counter for the gap duration

wire [63:0] song_durations; // the durations of the notes in the selected song_note
wire octave_up, octave_down;

wire piano_speaker;

reg [15:0] total_score = 0;

wire [3:0] in_note_out;
LearnInput learn_input(
    .key_in(key_in),
    .note_out(in_note_out)
);
OctaveControl octave_control(
    .octave_keys(octave_keys),
    .octave_up(octave_up),
    .octave_down(octave_down)
);
Getled get_led(
    .song_note(note_out),
    .led_code(learn_show_led)
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
reg flag_work;
always @(posedge clk) begin
    if (reset) begin
        index <= 0;
        counter <= 0;
        speaker <= 0;
        in_gap <= 0;
        gap_counter <= 0;
        flag_work <= 0;
        total_score <= 0;
        prev_cnt <= 0;
    end else if (in_gap) begin
        if (gap_counter < GAP_BATCH_SIZE) begin
            gap_counter <= gap_counter + 1;
            speaker <= 0;
            in_gap <= 1;
        end else begin
            gap_counter <= 0;
            batch_counter <= batch_counter + 1;
            if(flag_work) prev_cnt <= prev_cnt + 1;
            if(batch_counter > GAP_DURATION) begin
                batch_counter <= 0;
                in_gap <= 0;
                index <= index + 1;
            end
        end
    end else begin
        if (counter < BATCH_SIZE) begin
            counter <= counter + 1;
            speaker <= flag_work?piano_speaker:0;
            in_gap <= 0;
        end else begin
            counter <= 0;
            batch_counter <= batch_counter + 1;
            if(batch_counter > song_durations) begin
                batch_counter <= 0;
                in_gap <= 1;
            end
        end
    end
end
reg [31:0] delta;
always @(key_in) begin
    if(in_note_out == note_out) begin
        in_gap = 0;
        flag_work = 1;
        delta = (song_durations - batch_counter) < 0?~(song_durations - batch_counter)+1:(song_durations - batch_counter);
        if(song_durations - batch_counter < 0) begin
            if(delta <  song_durations / 5) total_score = total_score + S;
            else if(delta < song_durations / 5 * 2) total_score = total_score + A;
            else if(delta < song_durations / 5 * 3) total_score = total_score + B;
            else total_score = total_score + C;
        end
        else begin
            if(in_gap) begin
                if(prev_cnt < GAP_DURATION / 2) total_score = total_score + S;
                else if(prev_cnt < GAP_DURATION / 3) total_score = total_score + A;
                else if(prev_cnt < GAP_DURATION / 4) total_score = total_score + B;
                else total_score = total_score + C;
            end else begin
                if(delta >  song_durations / 5 * 4) total_score = total_score + S;
                else if(delta > song_durations / 5 * 3) total_score = total_score + A;
                else if(delta > song_durations / 5 * 2) total_score = total_score + B;
                else total_score = total_score + C;
            end

        end
    end else begin
        batch_counter = 0;
        in_gap = 0;
        index = index + 1;
    end
end

endmodule