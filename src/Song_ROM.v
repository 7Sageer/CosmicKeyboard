module SongROM(
    input wire [8:0] address,
    input wire [3:0] selected_song,
    output reg [3:0] note,
    output reg [31:0] note_duration
);

always @(address) begin
    case(selected_song)
        2'd0: begin
            case (address)
                0: note = 4'd1;
                1: note = 4'd1;
                2: note = 4'd5;
                3: note = 4'd5;
                4: note = 4'd6;
                5: note = 4'd6;
                6: note = 4'd5;
                7: note = 4'd4;
                8: note = 4'd4;
                9: note = 4'd3;
                10: note = 4'd3;
                11: note = 4'd2;
                12: note = 4'd2;
                13: note = 4'd1;
                14: note = 4'd5;
                15: note = 4'd5;
                16: note = 4'd4;
                17: note = 4'd4;
                18: note = 4'd3;
                19: note = 4'd3;
                20: note = 4'd2;
                21: note = 4'd5;
                22: note = 4'd5;
                23: note = 4'd4;
                24: note = 4'd4;
                25: note = 4'd3;
                26: note = 4'd3;
                27: note = 4'd2;
                default: note = 4'd0;
            endcase

            case (address)
                0: note_duration = 300_000_0;
                1: note_duration = 300_000_0;
                2: note_duration = 300_000_0;
                3: note_duration = 300_000_0;
                4: note_duration = 300_000_0;
                5: note_duration = 300_000_0;
                6: note_duration = 600_000_0;
                7: note_duration = 300_000_0;
                8: note_duration = 300_000_0;
                9: note_duration = 300_000_0;
                10: note_duration = 300_000_0;
                11: note_duration = 300_000_0;
                12: note_duration = 300_000_0;
                13: note_duration = 600_000_0;
                14: note_duration = 300_000_0;
                15: note_duration = 300_000_0;
                16: note_duration = 300_000_0;
                17: note_duration = 300_000_0;
                18: note_duration = 300_000_0;
                19: note_duration = 300_000_0;
                20: note_duration = 600_000_0;
                21: note_duration = 300_000_0;
                22: note_duration = 300_000_0;
                23: note_duration = 300_000_0;
                24: note_duration = 300_000_0;
                25: note_duration = 300_000_0;
                26: note_duration = 300_000_0;
                27: note_duration = 600_000_0;
                default: note_duration = 0;
            endcase
        end
        2'd1:begin
            case(address)
                0:note = 4'd3;
                1:note = 4'd3;
                2:note = 4'd6;
                3:note = 4'd6;
                4:note = 4'd3;
                5:note = 4'd0;

                6:note = 4'd3;
                7:note = 4'd3;
                8:note = 4'd3;
                9:note = 4'd0;

                10:note = 4'd3;
                11:note = 4'd3;
                12:note = 4'd6;
                13:note = 4'd6;
                14:note = 4'd3;
                15:note = 4'd0;

                16:note = 4'd3;
                17:note = 4'd3;
                18:note = 4'd3;
                19:note = 4'd0;

                20:note = 4'd3;
                21:note = 4'd3;
                22:note = 4'd3;
                23:note = 4'd3;
                24:note = 4'd3;
                25:note = 4'd6;
                26:note = 4'd6;
                27:note = 4'd3;
                28:note = 4'd0;

                29:note = 4'd3;
                30:note = 4'd3;
                31:note = 4'd3;
                default:note = 4'd0;
            endcase
            case(address)
                0:note_duration = 5_000_00;
                1:note_duration = 5_000_00;
                2:note_duration = 10_000_00;
                3:note_duration = 10_000_00;
                4:note_duration = 20_000_00;
                5:note_duration = 45_000_00;

                6:note_duration = 5_000_00;
                7:note_duration = 5_000_00;
                8:note_duration = 10_000_00;
                9:note_duration = 40_000_00;

                10:note_duration = 5_000_00;
                11:note_duration = 5_000_00;
                12:note_duration = 10_000_00;
                13:note_duration = 10_000_00;
                14:note_duration = 20_000_00;
                15:note_duration = 45_000_00;

                16:note_duration = 5_000_00;
                17:note_duration = 5_000_00;
                18:note_duration = 10_000_00;
                19:note_duration = 40_000_00;

                20:note_duration = 5_000_00;
                21:note_duration = 5_000_00;
                22:note_duration = 10_000_00;
                23:note_duration = 5_000_00;
                24:note_duration = 5_000_00;
                25:note_duration = 10_000_00;
                26:note_duration = 10_000_00;
                27:note_duration = 20_000_00;
                28:note_duration = 45_000_00;

                29:note_duration = 5_000_00;
                30:note_duration = 5_000_00;
                31:note_duration = 10_000_00;
                default:note_duration = 0;
            endcase
        end
    endcase
end

endmodule
