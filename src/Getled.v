`timescale 1ns / 1ps
module Getled(
    input wire [3:0] song_note, // 7-bit input representing the keys
    output reg [6:0] led_code // 4-bit output for the note
);

always @(*) begin
    led_code = 0;
    case(song_note)
        1: led_code = 7'b100_000_0;
        2: led_code = 7'b010_000_0;
        3: led_code = 7'b001_000_0;
        4: led_code = 7'b000_100_0;
        5: led_code = 7'b000_010_0;
        6: led_code = 7'b000_001_0;
        7: led_code = 7'b000_000_1;
        default: led_code = 0;
    endcase
end

endmodule