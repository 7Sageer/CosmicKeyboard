`timescale 1ns / 1ps

module AutoPlay_tb;

reg clk;
reg reset;
reg [3:0] selected_song;
reg [1:0] octave_keys;
wire speaker;
wire [3:0]note_out;

AutoPlay uut (
    .clk(clk),
    .reset(reset),
    .octave_keys(octave_keys),
    .note_out(note_out),
    .speaker(speaker),
    .selected_song(selected_song)
);


initial begin
    clk = 0;
    forever #100000 clk = ~clk;
end

initial
begin            
    $dumpfile("wave.vcd");
    $dumpvars(0, AutoPlay_tb);
end

initial begin
    selected_song = 4'b0001;
    reset = 1;
    octave_keys = 2'b00;
    #1000000000;
    reset = 0;
    #300000000;
    $finish;
end

endmodule
