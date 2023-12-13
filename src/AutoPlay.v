/**
 * @module AutoPlay
 * @brief This module implements an automatic music player.
 *
 * The AutoPlay module takes in a clock signal, a reset signal, octave keys, and a selected song.
 * It generates a speaker output and a note output based on the selected song and the state of the octave keys.
 * The module uses an OctaveControl module to handle the octave control logic, a Buzzer module to generate the note output,
 * and a SongROM module to retrieve the notes and durations of the selected song.
 *
 * The AutoPlay module keeps track of the current index and counter for the song playback.
 * It also handles the generation of gaps between notes.
 *
 * @param clk The clock signal.
 * @param reset The reset signal.
 * @param octave_keys The octave keys input.
 * @param selected_song Thbe selected song input.
 * @param speaker The speaker output.
 * @param note_out The note output.
 */

module AutoPlay(
    input wire clk,
    input wire reset,
    input wire [1:0] octave_keys,
    input wire [3:0] selected_song,
    output reg speaker,
    output wire [3:0] note_out
);

localparam GAP_DURATION = 15'd1000_000_000;
localparam BATCH_SIZE = 20;
localparam GAP_BATCH_SIZE = 200;
localparam SIZE = 32;


reg [4:0] index; // current index of the song notes
reg [31:0] counter; // current counter for the note duration
reg [31:0] batch_counter; // current counter for the batch duration

reg in_gap; // whether the current state is in a gap
reg [15:0] gap_counter; // current counter for the gap duration

wire [63:0] song_durations; // the durations of the notes in the selected song_note
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
        if (gap_counter < GAP_BATCH_SIZE) begin
            gap_counter <= gap_counter + 1;
            speaker <= 0;
            in_gap <= 1;
        end else begin
            gap_counter <= 0;
            batch_counter <= batch_counter + 1;
            if(batch_counter > GAP_DURATION) begin
                batch_counter <= 0;
                in_gap <= 0;
                index <= index + 1;
            end
        end
    end else begin
        if (counter < BATCH_SIZE) begin
            counter <= counter + 1;
            speaker <= piano_speaker;
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


endmodule
