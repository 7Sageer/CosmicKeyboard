`timescale 1ns / 1ps

module ElectronicPiano(
    input wire clk,
    input wire reset,
    input wire adjustment_switch, // Switch to enter adjustment mode
    input wire confirm_button, // Confirmation button
    input wire [6:0] key_in, // Keys for notes
    input wire [1:0] octave_keys, // Keys for octave control
    output wire speaker,
    output wire [6:0] Input_Led,
    output wire [1:0] octave_Led,
    output wire adjustment_switch_Led,
    output wire loud,
    output wire [4:0] light
    
);
wire octave_up, octave_down;
wire [3:0] note, note_ad;
wire [2:0] display_number;
wire [6:0] key_mapping_0, key_mapping_1, key_mapping_2, key_mapping_3, 
          key_mapping_4, key_mapping_5, key_mapping_6;

assign adjustment_switch_Led = adjustment_switch;
assign octave_Led = octave_keys;
assign Input_Led = key_in;
//assign note_tb = note;
//assign key_mapping__0 = key_mapping_0;
//assign key_mapping__1 = key_mapping_1;
//assign key_mapping__2 = key_mapping_2;
//assign key_mapping__3 = key_mapping_3;
//assign key_mapping__4 = key_mapping_4;
//assign key_mapping__5 = key_mapping_5;
//assign key_mapping__6 = key_mapping_6;



KeyboardInput keyboard_input(
    .key_in(key_in),
    .note_ad(note_ad),
    .key_mapping_0(key_mapping_0),
    .key_mapping_1(key_mapping_1),
    .key_mapping_2(key_mapping_2),
    .key_mapping_3(key_mapping_3),
    .key_mapping_4(key_mapping_4),
    .key_mapping_5(key_mapping_5),
    .key_mapping_6(key_mapping_6),
    .adjustment_mode(adjustment_switch),
    .note_out(note)
);

AdjustmentModeControl adjustment_control(
    .clk(clk),
    .reset(reset),
    .adjustment_mode(adjustment_switch),
    .confirm(confirm_button),
    .key_in(key_in),
    .note_to_play(note_ad),
    .key_mapping_0(key_mapping_0),
    .key_mapping_1(key_mapping_1),
    .key_mapping_2(key_mapping_2),
    .key_mapping_3(key_mapping_3),
    .key_mapping_4(key_mapping_4),
    .key_mapping_5(key_mapping_5),
    .key_mapping_6(key_mapping_6),
    .light(light)
);

Buzzer buzzer(
    .clk(clk),
    .note(note),
    .octave_up(octave_up),
    .octave_down(octave_down),
    .speaker(speaker)
);


OctaveControl octave_control(
    .octave_keys(octave_keys),
    .octave_up(octave_up),
    .octave_down(octave_down)
);

assign loud = 1;

endmodule
