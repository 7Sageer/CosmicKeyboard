module LearningPlay(
    input wire clk,
    input wire reset,
    input wire [6:0] key_in,
    input wire [1:0] octave_keys,
    input wire [3:0] selected_song,
    output wire [6:0] learn_show_led,
    output reg speaker,
     output wire [7:0] score2,
       output wire tub_1,
       output wire tub_2
);
localparam GAP_DURATION = 15'd1000_000_000;
localparam SIZE = 32,
           S = 3'b100,
           A = 3'b011,
           B = 3'b010,
           C = 3'b001,
           BATCH_SIZE = 20,
           GAP_BATCH_SIZE = 400;

wire [3:0] note_out;
reg [4:0] index; // current index of the song notes
reg [31:0] counter; // current counter for the note duration
reg [31:0] batch_counter; // current counter for the batch duration

reg [15:0] gap_counter; // current counter for the gap duration

wire [63:0] song_durations; // the durations of the notes in the selected song_note
wire octave_up, octave_down;

wire piano_speaker;

reg [15:0] total_score = 0;

wire [3:0] in_note_out;

LearnInput learn_input(
    .key_in(key_in),
    .note_out(in_note_out)
);
OctaveControl octave_control(
    .octave_keys(octave_keys),
    .octave_up(octave_up),
    .octave_down(octave_down)
);
Getled get_led(
    .song_note(note_out),
    .led_code(learn_show_led)
);
Buzzer buzzer(
    .clk(clk),
    .note(note_out),
    .octave_up(octave_up),
    .octave_down(octave_down),
    .speaker(piano_speaker)
);

SongROM2 song_rom2(
    .address(index),
    .note(note_out),
    .note_duration(song_durations),
    .selected_song(selected_song)
);
reg flag_work;
reg [31:0] cnt;
//always @(posedge clk) begin
//    if (reset) begin
//        index <= 0;
//        counter <= 0;
//        speaker <= 0;
//        gap_counter <= 0;
//        total_score <= 0;
//        cnt <= 0;
//        state1 <= 0;
//    end  if(flag_work == 1'b1) begin
//        speaker <= (isCorrect == 1'b1)?piano_speaker:1000000; 
//        if (counter < BATCH_SIZE) begin
//            counter <= counter + 1;
//        end else begin
//            counter <= 0;
//            batch_counter <= batch_counter + 1;
//            if(batch_counter > song_durations) begin
//                batch_counter <= 0;
//                index <= index + 1;
//                state1 <= 1;
//                cnt <= 0;
//            end else state1 <= 0;
//        end
//    end else begin
//        cnt <= cnt + 1;
//        speaker <= 0;
//    end
//    if(state1 == 1'b1) begin
//        flag_work <= 0;
//        state1 <= 0;
//    end
//end
//reg state1;
//reg state2;
//reg state3;
//always @(clk) begin
//    if(state1) begin
//        speaker <= 0;
//        state1 <= 0;
//    end
//    else if(state2) begin
//        speaker <= piano_speaker;
//        state2 <= 0;
//    end
//    else if(state3) begin
//            speaker <= 1000000;;
//            state3 <= 0;
//    end else speaker <= 0;
//end
localparam N = 14; 
 reg [N-1:0] regN; 
wire[3:0] digit;
reg fuwei;
reg ff;
always@(key_in) begin
    if(key_in == 7'b000_000_0) begin
        fuwei = 1;
        ff = 0;
    end
    else begin  fuwei = 0;
                ff = 1;
    end
end
reg isOut;
reg isRight;
 always@(posedge clk) begin
 //speaker <= piano_speaker;
   regN <= regN + 1;
   if(reset)begin
            index <= 0;
            counter <= 0;
            //speaker <= 0;
            total_score <= 0;
            flag_work <= 0;
            batch_counter <= 0;
            //key_in_prev <= 7'b000_000_0;
            fuwei <= 1;
            cnt <= 0;
            regN <= 0;
            total_score <= 0;
            isOut <= 0;
            isRight <= 0;
            //score2 <= 0;
           // score2<=0;
    end
  else begin
            if(note_out == 0) begin
                if (counter < BATCH_SIZE) begin
                            counter <= counter + 1;
                        end else begin
                            counter <= 0;
                            batch_counter <= batch_counter + 1;
                            if(batch_counter > song_durations) begin
                                batch_counter <= 0;
                                counter <= 0;
                                flag_work <= 0;
                                index <= index + 1;
                                //speaker <= 0;
                               end
                        end
            end
         if (key_in != 7'b000_000_0&&~flag_work&&fuwei) begin
             flag_work = 1;
             batch_counter = 0;
             counter = 0;
             if(in_note_out == note_out) begin
                    isRight <= 1;
                     if(cnt < GAP_DURATION) begin 
                           total_score = total_score + S;
                           cnt = 0;
                           end
                     else if(cnt < GAP_DURATION * 2) begin 
                            total_score = total_score + A;
                            cnt = 0;
                            end
                     else if(cnt < GAP_DURATION * 3) begin
                            total_score= total_score + B;
                            cnt = 0;
                            end
                     else begin 
                            total_score = total_score + C;
                            cnt = 0;
                            end
              end else isRight <= 0;
        end
        if(!ff) begin 
                    flag_work = 0;
                    speaker = 0;
                    isOut = 0;
                    
                end
             
        if(flag_work&&~isOut) begin
                if(isRight) speaker <= piano_speaker;
                if (counter < BATCH_SIZE) begin
                    counter <= counter + 1;
                    end 
                else begin
                        counter <= 0;
                        batch_counter <= batch_counter + 1;
                        if(batch_counter > 300_000_0) begin
                            batch_counter <= 0;
                            counter <= 0;
                            index <= index + 1;
                            isOut <= 1;
                            //speaker <= 0;
                        end
                end
      end else cnt = cnt + 1;  
  end
end 
assign tub_1 = (regN[N-1:N-2] == 2'b00)?1:
               (regN[N-1:N-2] == 2'b01)?1:0;
assign tub_2 = (regN[N-1:N-2] == 2'b00)?0:
               (regN[N-1:N-2] == 2'b01)?0:1;   
assign digit =  (regN[N-1:N-2] == 2'b00)?total_score / 10:
                (regN[N-1:N-2] == 2'b01)?total_score / 10:total_score % 10;   
assign score2 = (digit == 4'b0000)? 8'b11111100: // 0
        (digit == 4'b0001)?8'b01100000: // 1
       (digit == 4'b0010)?8'b11011010: // 2
        (digit == 4'b0011)?8'b11110010: // 3
        (digit == 4'b0100)? 8'b01100110: // 4
        (digit == 4'b0101)? 8'b10110110: // 5
        (digit == 4'b0110)? 8'b10111110:// 6
        (digit == 4'b0111)? 8'b11100000: // 7
        (digit == 4'b1000)?8'b11111110: // 8
        (digit == 4'b1001)? 8'b11110110:8'b00000000;
endmodule
//assign tub_2 = (regN[N-1:N-2] == 2'b00)?0:
//               (regN[N-1:N-2] == 2'b01)?0:1;                                             
//always @(*) begin
//   case(regN[N-1:N-2]) 
//        2'b00:begin 
//            digit = 1;
//            tub_1 = 1;
//            tub_2 = 0;
//            end
//        2'b01:begin 
//             digit = 1;
//             tub_1 = 1;
//             tub_2 = 0;
//            end
//       2'b11: begin 
//            digit =2'b11;
//            tub_1 = 0;
//            tub_2 = 1;
//           end
//     2'b10: begin 
//             digit =2'b11;
//             tub_1 = 0;
//             tub_2 = 1;
//           end
//       default:begin
//         digit =2'b11;
//         tub_1 = 0;
//        tub_2 = 1;
//       end
//   endcase
        
//end
//always @(posedge clk) begin
//case(digit)
//        4'b0000: score2 = 8'b11111100; // 0
//        4'b0001: score2 = 8'b01100000; // 1
//        4'b0010: score2 = 8'b11011010; // 2
//        4'b0011: score2 = 8'b11110010; // 3
//        4'b0100: score2 = 8'b01100110; // 4
//        4'b0101: score2 = 8'b10110110; // 5
//        4'b0110: score2 = 8'b10111110; // 6
//        4'b0111: score2 = 8'b11100000; // 7
//        4'b1000:score2 = 8'b11111110; // 8
//        4'b1001: score2 = 8'b11110110; // 9
//        default: score2 = 8'b00000000; // ��������ʱϨ�����ж�
//    endcase
//end
//always @(posedge key_in) begin
//       // flag_work = 1;
//        //isCorrect = 1;
//        if(in_note_out == note_out) begin
//           if(cnt < GAP_DURATION) total_score = total_score + S;
//           else if(cnt < GAP_DURATION * 2) total_score = total_score + A;
//           else if(cnt < GAP_DURATION * 3) total_score = total_score + B;
//           else total_score = total_score + C;
//           speaker = piano_speaker;
//        end else begin
//            speaker = 1000000;
//            isCorrect = 0;
//        end
//end
//always @(negedge key_in) begin
//        //flag_work = 1;
//        //isCorrect = 1;
//        index = index + 1;
////        if(in_note_out == note_out) begin
////           if(cnt < GAP_DURATION) total_score = total_score + S;
////           else if(cnt < GAP_DURATION * 2) total_score = total_score + A;
////           else if(cnt < GAP_DURATION * 3) total_score = total_score + B;
////           else total_score = total_score + C;
////        end else begin
////            isCorrect = 0;
////        end
//end
