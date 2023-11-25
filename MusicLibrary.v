module MusicLibrary(
    input wire clk,
    input wire [6:0] key_in, // Keys for notes
    input wire [5:0] songId,
    output wire [7 * 8 - 1:0] light,// light for leading(no support for array in port)
    output wire speaker
);

wire [3:0] note;
reg [3:0]noteShow;
wire [3:0]song[5:0][10:0];// note,the number of songs,the max number of notes
wire [1:0]songOctave[5:0];
wire [10:0]cnt_end[5:0];
reg[16:0]time_cnt;
//todo: fill
reg flag = 1'b0;
parameter cnt = 10'b0,score=10'b0;
KeyboardInput keyboard_input(
    .key_in(key_in),
    .note_out(note)
);
Buzzer buzzer(
    .clk(clk),
    .note(note),
    .octave_up(songOctave[songId][0]),
    .octave_down(songOctave[songId][1]),
    .speaker(speaker)
);//todo : need a new input to ignore USER's note
Light light1(

);//todo:1~8 to show the name of the song

Led led(
);//todo : note to led

always @(posedge clk) begin
    time_cnt = time_cnt + 1'b1;
end

always @(*) begin
    noteShow = song[songId][cnt];
    case (cnt)
        cnt_end[songId]://todo:end
        begin
        end
    endcase
    case (note)
        song[songId][cnt]:
        begin
            flag = 1'b0;
            cnt = cnt + 1'b1;
            if(time_cnt < 6000000) score = score + 1'b1;
            time_cnt = 17'b0;
        end
    endcase
end
endmodule

