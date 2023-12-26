应包含 
0. 团队分工（各成员工作以及贡献百分比）【0.5】，开发计划日程安排和实施情况【1】
1. 系统功能列表 【1】
2. 系统使用说明（含系统 的输入、输出端口的说明），可参考“输入输出端口说明图示例” 示意图 【1】
2. 系统结构说明（系统内部各模块及模块间信号线的关系）【2】
3. 子模块功能说明： 输入、输出端口说明、子模块功能说明 【1】
4. bonus 的实现说明（仅对实现bonus的小组有要求，如缺少这部分，bonus总分打7折）
5. 项目总结（团队合作、开发及测试工作的总结【2】
6. 假如你们团队负责project出题，请给出基于ego1可实现的project的想法和建议，可以借鉴网上的方案，但需给出reference【1.5】）"


0.
夏辰曦： ElectronicPiano模块，自由模式基础功能与标准功能，调整模式。前期设备绑定调试，组织小组会议讨论。

日程安排：
10月初，小组会议讨论，初步分工
10~11月，自由模式基础功能与标准功能，初次上板测试。
12月10号~20号，挑战bonus功能。

1.
2.
3.

4.
5.


# Main Module Documentation

## Overview

The Main module serves as the central control unit for an electronic piano, managing different playing modes (Free Mode, Auto-Play Mode, and Learning Mode) and handling user inputs and outputs.

## Input and Output Ports

### Inputs

- `clk`: Clock signal.
- `mode_select`: Mode selection signal (0 for Free Mode, 1 for Auto-Play Mode, 2 for Learning Mode).
- `key_in`: Keyboard input (7-bit, representing different keys).
- `octave_keys`: Octave control keys (2-bit, representing octave shifts).
- `adjustment_switch`: Switch to enter adjustment mode.
- `confirm_button`: Button to confirm selections or actions.
- `next_song`: Button to select the next song.
- `prev_song`: Button to select the previous song.
- `reset`: Reset signal to initialize the module.

### Outputs

- `speaker`: Speaker output signal.
- `tub_sel_song_num`: Control signal for song number display.
- `song_num`: Song number (8-bit, displaying the current song number).
- `loud`: Volume control signal (binary signal).
- `led`: LED output (7-bit, indicating various statuses).
- `tub_sel_score1`: Control signal for score display part 1.
- `tub_sel_score2`: Control signal for score display part 2.
- `score2`: Score display (8-bit).

## Operating Modes

- **Free Mode** (`FREE_MODE`): Allows free playing of notes.
- **Auto-Play Mode** (`AUTO_PLAY_MODE`): Plays pre-set songs automatically.
- **Learning Mode** (`LEARNING_MODE`): Assists in learning songs with guided lights and scores.

## Error Handling and Boundary Conditions

- In case of invalid `mode_select` input, the system defaults to Free Mode.
- LED indicators provide visual feedback in case of errors or mode changes.
- Reset signal initializes all settings to default, ensuring recovery from any inconsistent state.

---

# AutoPlayController Module Documentation

## Overview

The AutoPlayController module automates the playback of pre-set songs, controlling song selection, playback, and related audio-visual outputs.

## Input and Output Ports

### Inputs

- `clk`: Clock signal.
- `reset`: Reset signal to initialize the module.
- `next_song`: Button to select the next song.
- `prev_song`: Button to select the previous song.

### Outputs

- `song_number`: Current song number (4-bit).
- `display_output`: Display output for the song number (8-bit).
- `speaker`: Speaker output signal.
- `note_out`: Note output signal (4-bit).
- `tub_sel`: Tube selection signal for display.
- `led`: LED output (7-bit).

## Functionality

- Manages song selection using `next_song` and `prev_song` buttons.
- Generates audio signals based on the selected song.
- Uses `SevenSegmentDecoder` to display the current song number.

## Performance and Resource Usage

- Resource-efficient design ensures minimal clock cycles per operation.
- LED indicators provide low-overhead status updates.

## Application Example

```verilog
// Instantiate the AutoPlayController in a larger system
AutoPlayController auto_play (
    .clk(clk),
    .reset(reset),
    // Other connections as per system design
);
```