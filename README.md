# CosmicKeyboard

## Overview

CosmicKeyboard is an innovative electronic keyboard project designed to bring a unique musical experience. This project combines traditional electronic keyboard functionalities with advanced features like auto-play, learning mode, and an interactive song selection interface. It's perfect for both beginners and experienced musicians looking to explore music in a new, interactive way.
![CosmicKeyboard Image](keyboard.png "CosmicKeyboard")

## Features

- **Free Mode**: Play any note at will, just like a standard electronic keyboard.
- **Auto-Play Mode**: The keyboard automatically plays a selection of pre-loaded songs.
- **Learning Mode**: Lights guide the user to play specific songs, improving learning and engagement.
- **Song Selection**: Navigate through a library of songs using a next/previous interface, displayed on a seven-segment display.
- **Octave Control**: Shift the pitch of notes up or down to suit your musical preference.

## Hardware Requirements

- FPGA Board
- Clock source
- Seven-segment display
- Input buttons for mode selection and song navigation
- Speaker or audio output

## Modules

- **Main Module**: Coordinates all other modules and manages the mode of operation.
- **AutoPlay Module**: Handles the automatic playback of songs in the song library.
- **AutoPlayController Module**: Manages song selection and interfaces with the seven-segment display for song navigation.
- **ElectronicPiano Module**: Core functionality for playing notes in Free and Learning modes.
- **Buzzer Module**: Generates sound corresponding to the selected notes and octave settings.

## Installation

1. Clone the repository:
   ```
   git clone [repository-url]
   ```
2. Compile the Verilog files using your preferred FPGA development environment.
3. Load the compiled design onto your FPGA board.
4. Connect the necessary peripherals (display, buttons, speaker).

## Usage

- Power on the CosmicKeyboard.
- Select your desired mode using the mode selection buttons.
- For song navigation, use the next/previous buttons.
- Play music in Free Mode, follow along in Learning Mode, or sit back and listen in Auto-Play Mode.

## Contributing

Contributions to CosmicKeyboard are welcome! If you have suggestions or improvements, please open an issue or submit a pull request.
