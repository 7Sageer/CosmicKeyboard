`timescale 1ns / 1ps

module Main_testbench();

reg clk;
reg [2:0] mode_select;
reg [6:0] key_in;
reg [1:0] octave_keys;
reg next_song;
reg prev_song;
reg reset;
wire speaker;
wire [6:0] song_num;
wire [3:0] note_out;

// 实例�? Main 模块
Main uut(
    .clk(clk),
    .mode_select(mode_select),
    .key_in(key_in),
    .octave_keys(octave_keys),
    .next_song(next_song),
    .prev_song(prev_song),
    .reset(reset),
    .speaker(speaker),
//    .song_num(song_num),
    .note_out(note_out)
);

// 时钟信号生成
initial begin
    clk = 0;
    forever #10 clk = ~clk; // 生成时钟信号
end
initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, Main_testbench);
end

// 测试序列
initial begin
    // 初始化输�?
    reset = 1; mode_select = 0; key_in = 0; octave_keys = 0; next_song = 0; prev_song = 0;
    #100; // 等待�?段时�?

    // 重置
    reset = 0;
    #20;

    // 测试自由模式
    mode_select = 3'd0; // 自由模式
    key_in = 7'b0000001; // 模拟按键输入
    #100;
    key_in = 7'b0000010;
    #100;
    key_in = 7'b0000100;
    #100;

    // 切换到自动演奏模�?
    mode_select = 3'd1; // 自动演奏模式
    #1000000;

    // 切换到学习模�?
    mode_select = 3'd2; // 学习模式
    #1000;

    // 测试结束
    $finish;
end

endmodule
