module SevenSegmentDecoder(
    input [3:0] digit,
    output reg [6:0] display
);

always @(digit) begin
    case(digit)
        4'b0000: display = 7'b1111110; // 0
        4'b0001: display = 7'b0110000; // 1
        4'b0010: display = 7'b1101101; // 2
        4'b0011: display = 7'b1111001; // 3
        4'b0100: display = 7'b0110011; // 4
        4'b0101: display = 7'b1011011; // 5
        4'b0110: display = 7'b1011111; // 6
        4'b0111: display = 7'b1110000; // 7
        4'b1000: display = 7'b1111111; // 8
        4'b1001: display = 7'b1111011; // 9
        default: display = 7'b0000000; // 其他输入时熄灭所有段
    endcase
end

endmodule
