## 🎮 Included Homebrew
This repo includes a custom-built ROM to verify emulator performance:
- **Splash Demo:** A basic Assembly program that tests VBlank interrupts and LCD status registers.
- **OCaml-Tetris (WIP):** A proof-of-concept game logic compiled to GB bytecode.

### 🛠️ Compiling the Game
To modify the demo, you will need the [RGBDS](https://github.com/rednex/rgbds) assembler:
```bash
rgbasm -o main.o main.asm
rgblink -o splash_demo.gb main.o
rgbfix -v -p 0 splash_demo.gb
