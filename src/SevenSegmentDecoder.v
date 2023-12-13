module SevenSegmentDecoder(
    input [3:0] digit,
    output reg [7:0] display,
    output wire tub_sel
);
assign tub_sel = 1'b1;
always @(digit) begin
    case(digit)
        4'b0000: display = 8'b11111100; // 0
        4'b0001: display = 8'b01100000; // 1
        4'b0010: display = 8'b11011010; // 2
        4'b0011: display = 8'b11110010; // 3
        4'b0100: display = 8'b01100110; // 4
        4'b0101: display = 8'b10110110; // 5
        4'b0110: display = 8'b10111110; // 6
        4'b0111: display = 8'b11100000; // 7
        4'b1000: display = 8'b11111110; // 8
        4'b1001: display = 8'b11110110; // 9
        default: display = 8'b00000000; // 其他输入时熄灭所有段
    endcase
end

endmodule
