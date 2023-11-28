`timescale 1ns / 1ps
//module Buzzer (
//input wire clk , // Clock signal
//input wire [3:0] note , // Note ( Input 1 outputs a signal for 'do , ' 2 for 're , ' 3 for 'mi , ' 4 ,and so on)
//output wire speaker // Buzzer output signal
//);

//wire [31:0] notes [7:0];
//reg [31:0] counter ;
//reg pwm ;
//// Frequencies of do , re , mi , fa , so , la , si
//// Obtain the ratio of how long the buzzer should be active in one second
//assign notes [1]=381680;
//assign notes [2]=340136;
//assign notes [3]=303030;
//assign notes [4]=285714;
//assign notes [5]=255102;
//assign notes [6]=227273;
//assign notes [7]=202429;
//initial
//    begin
//        pwm =0;
//    end
//always @ ( posedge clk ) begin
//    if ( counter < notes [ note ]|| note ==1'b0 ) begin
//        counter <= counter + 1'b1 ;
//    end else begin
//        pwm =~ pwm ;
//        counter <= 0;
//    end
//end

//assign speaker = pwm ; // Output a PWM signal to the buzzer
//endmodule

module Buzzer (
    input wire clk, // Clock signal
    input wire [3:0] note, // Note number
    input wire octave_up, // Octave up control
    input wire octave_down, // Octave down control
    input wire en, // work?
    output wire speaker // Buzzer output signal
);

// Base frequencies for notes do, re, mi, fa, so, la, si
reg [31:0] base_frequencies[7:0];
initial begin
    base_frequencies[0] = 0;
    base_frequencies[1] = 381680; // do
    base_frequencies[2] = 340136; // re
    base_frequencies[3] = 303030; // mi
    base_frequencies[4] = 285714; // fa
    base_frequencies[5] = 255102; // so
    base_frequencies[6] = 227273; // la
    base_frequencies[7] = 202429; // si
end

reg [31:0] counter;
reg pwm;
reg [31:0] current_frequency;

// Update the frequency based on the octave adjustments
always @(*) begin
    if (octave_up && !octave_down) begin
        current_frequency = base_frequencies[note] >> 1; // Double the frequency for one octave up
    end else if (octave_down && !octave_up) begin
        current_frequency = base_frequencies[note] << 1; // Half the frequency for one octave down
    end else begin
        current_frequency = base_frequencies[note]; // Base frequency
    end
end

// PWM signal generation
always @(posedge clk) begin
    if (counter < current_frequency || note == 0) begin
        counter <= counter + 1;
    end else begin
        pwm = ~pwm;
    end
end

assign speaker = en?pwm:base_frequencies[0]; // Output a PWM signal to the buzzer

endmodule
