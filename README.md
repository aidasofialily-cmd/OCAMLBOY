# 🐫 Camlboy

A Game Boy emulator written in **OCaml**. This project explores functional programming patterns in the context of low-level hardware emulation.

## 🚀 Features
- **LR35902 CPU Core:** Accurate opcode implementation with passing Blargg tests.
- **Cross-Platform:** Compiles to native code (using SDL2) and Web (via `js_of_ocaml`).
- **Functional Architecture:** Immutable state where possible, leveraging OCaml's module system for clean MMU/GPU separation.

## 🛠️ Build Instructions
1. **Native (SDL2):**
   ```bash
   opam install sdl2
   dune build bin/main.exe
