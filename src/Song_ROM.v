module SongROM(
    input wire [4:0] address,
    input wire [3:0] selected_song,
    output reg [3:0] note,
    output reg [15:0] note_duration
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
                0: note_duration = 3000;
                1: note_duration = 3000;
                2: note_duration = 3000;
                3: note_duration = 3000;
                4: note_duration = 3000;
                5: note_duration = 3000;
                6: note_duration = 6000;
                7: note_duration = 3000;
                8: note_duration = 3000;
                9: note_duration = 3000;
                10: note_duration = 3000;
                11: note_duration = 3000;
                12: note_duration = 3000;
                13: note_duration = 6000;
                14: note_duration = 3000;
                15: note_duration = 3000;
                16: note_duration = 3000;
                17: note_duration = 3000;
                18: note_duration = 3000;
                19: note_duration = 3000;
                20: note_duration = 6000;
                21: note_duration = 3000;
                22: note_duration = 3000;
                23: note_duration = 3000;
                24: note_duration = 3000;
                25: note_duration = 3000;
                26: note_duration = 3000;
                27: note_duration = 6000;
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
                0:note_duration = 1000;
                1:note_duration = 1000;
                2:note_duration = 2000;
                3:note_duration = 2000;
                4:note_duration = 4000;
                5:note_duration = 9000;

                6:note_duration = 1000;
                7:note_duration = 1000;
                8:note_duration = 2000;
                9:note_duration = 8000;

                10:note_duration = 1000;
                11:note_duration = 1000;
                12:note_duration = 2000;
                13:note_duration = 2000;
                14:note_duration = 4000;
                15:note_duration = 9000;

                16:note_duration = 1000;
                17:note_duration = 1000;
                18:note_duration = 2000;
                19:note_duration = 8000;

                20:note_duration = 1000;
                21:note_duration = 1000;
                22:note_duration = 2000;
                23:note_duration = 1000;
                24:note_duration = 1000;
                25:note_duration = 2000;
                26:note_duration = 2000;
                27:note_duration = 4000;
                28:note_duration = 9000;

                29:note_duration = 1000;
                30:note_duration = 1000;
                31:note_duration = 2000;
                default:note_duration = 0;
            endcase
        end
    endcase
end

endmodule
