`timescale 1ns / 1ps
module AdjustmentModeControl(
    input wire clk,
    input wire reset,
    input wire adjustment_mode, 
    input wire confirm, 
    input wire [6:0] key_in, 
    output reg [3:0] note_to_play,
    output reg [6:0] key_mapping_0,
    output reg [6:0] key_mapping_1,
    output reg [6:0] key_mapping_2,
    output reg [6:0] key_mapping_3,
    output reg [6:0] key_mapping_4,
    output reg [6:0] key_mapping_5,
    output reg [6:0] key_mapping_6,
    output reg [4:0] light
);

// Local parameters for state definitions
localparam IDLE = 3'b000,
           PLAY_NOTE = 3'b001,
           WAIT_FOR_KEY = 3'b010,
           CONFIRM_KEY = 3'b011,
           COMPLETE = 3'b100;


// State and next state registers
reg [2:0] state, next_state;
// Output registers
reg [3:0] current_note;
reg [6:0] selected_key;
reg key_selected,con;

// Mealy state machine
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset state and set default key mappings
        state <= IDLE;
      
//        note_to_play <= 0;
    end else begin
        state <= next_state;
    end
end

initial begin
current_note <= 0;
note_to_play <= 0;
end

always@(*) begin
    case (state)
        IDLE: begin
            if (adjustment_mode) next_state <= PLAY_NOTE;
            else next_state <= IDLE;  
        end
        
        PLAY_NOTE: begin
         if ((!key_selected) && (!confirm)) begin next_state <= WAIT_FOR_KEY; end
        else begin next_state <= PLAY_NOTE; end
        
        if (current_note > 7) begin next_state <= COMPLETE; end// Check if all notes played

        end
        
        WAIT_FOR_KEY: begin
            if (key_selected) next_state <= CONFIRM_KEY;
            else next_state <= WAIT_FOR_KEY;
        end
        
        CONFIRM_KEY: begin
            if (con) next_state <= PLAY_NOTE;
            else next_state <= CONFIRM_KEY;
        end
        
         COMPLETE: begin
         if(!adjustment_mode) next_state <= IDLE;
         else next_state <= COMPLETE;
         end
         
        default next_state <= IDLE;    
          
           endcase
       end
       


always@(*) begin
    case (state)
        IDLE: begin
            current_note <= 4'b0001; // Start from 1
            key_selected <= 1;
//            display_number = 1;
            light <= 5'b00001;
            if (reset) begin
//                          key_mapping_0 = 7'b0000001;
//                          key_mapping_1 = 7'b0000010;
//                          key_mapping_2 = 7'b0000100;
//                          key_mapping_3 = 7'b0001000;
//                          key_mapping_4 = 7'b0010000;
//                          key_mapping_5 = 7'b0100000;
//                          key_mapping_6 = 7'b1000000;
                  key_mapping_6 <= 7'b0000001;
                  key_mapping_5 <= 7'b0000010;
                  key_mapping_4 <= 7'b0000100;
                  key_mapping_3 <= 7'b0001000;
                  key_mapping_2 <= 7'b0010000;
                  key_mapping_1 <= 7'b0100000;
                  key_mapping_0 <= 7'b1000000;
                    end
        end
        
        PLAY_NOTE: begin
            note_to_play <= current_note;
            key_selected <= 0;
            con <= 0;
            
            case(current_note)
            0:light <= 5'b00011;
            1:light <= 5'b00111;
            2:light <= 5'b01111;
            3:light <= 5'b11111;
            4:light <= 5'b00011;
            default   light <= 5'b10001;


            endcase
        end
        
        WAIT_FOR_KEY: begin
//        if (current_note != 1) light = 5'b10000;
//        else light = 5'b00100;
       light <= 5'b01110;
        if (key_in) begin
            selected_key <= key_in;
            key_selected <= 1;
        end
            
        end
        CONFIRM_KEY: begin
        if (confirm) begin
        con = 1;
                case (note_to_play)
                    1: begin key_mapping_0 <= selected_key; 
                                   current_note <= 2;
                    end
                    2: begin key_mapping_1 <= selected_key;
                      current_note <= 3;
                                      end
                    3: begin key_mapping_2 <= selected_key;
                      current_note <= 4;
                                      end
                    4: begin key_mapping_3 <= selected_key;
                      current_note <= 5;
                                      end
                    5: begin key_mapping_4 <= selected_key;
                      current_note <= 6;
                                      end
                    6: begin key_mapping_5 <= selected_key;
                      current_note <= 7;
                                      end
                    7: begin key_mapping_6 <= selected_key;
                      current_note <= 8;
                                      end
                endcase
 
//                light = 5'b01000;
        end
        end
        COMPLETE: begin
//        note_to_play = 0; 
        light <= 5'b11111;     
        end
        
        default  note_to_play <= 0; 
    endcase
end

endmodule
