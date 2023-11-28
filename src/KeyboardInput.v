`timescale 1ns / 1ps

module KeyboardInput(
    input wire [6:0] key_in, // 8-bit input representing the keys
    output reg [3:0] note_out, // 4-bit output for the note
    output reg [6:0] led_out // 7-bit output for the LEDs
);

always @(*) begin
    case (key_in)
        7'b0000001: begin
            note_out = 1; // do
            led_out = 7'b0000001;
        end
        7'b0000010: begin
            note_out = 2; // re
            led_out = 7'b0000010;
        end
        7'b0000100: begin
            note_out = 3;
            led_out = 7'b0000100;
        end
        7'b0001000: begin
            note_out = 4;
            led_out = 7'b0001000;
        end
        7'b0010000: begin
            note_out = 5;
            led_out = 7'b0010000;
        end
        7'b0100000: begin
            note_out = 6;
            led_out = 7'b0100000;
        end
        7'b1000000: begin
            note_out = 7;
            led_out = 7'b1000000;
        end
        default: begin
            note_out = 0; // No note
            led_out = 7'b0000000; // All LEDs off
        end
    endcase
end

endmodule
