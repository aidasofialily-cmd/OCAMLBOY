#!/bin/bash

# --- Camlboy Developer Tool ---
# This script automates the build process for both the emulator and the homebrew ROMs.

set -e # Exit on error

echo "🐫 Initializing Camlboy Environment..."

# 1. Check for OCaml/Opam dependencies
if ! command -v opam &> /dev/null; then
    echo "❌ Error: Opam is not installed. Please visit https://opam.ocaml.org/"
    exit 1
fi

# 2. Install library dependencies
echo "📦 Installing OCaml dependencies..."
opam install dune js_of_ocaml js_of_ocaml-ppx sdl2 containers --confirm-level=bench

# 3. Assemble Homebrew Games (if RGBDS is installed)
if command -v rgbasm &> /dev/null; then
    echo "🎮 Assembling homebrew ROMs..."
    mkdir -p roms/bin
    rgbasm -o roms/source/main.o roms/source/main.asm
    rgblink -o roms/bin/splash_demo.gb roms/source/main.o
    rgbfix -v -p 0 roms/bin/splash_demo.gb
    echo "✅ ROM compiled: roms/bin/splash_demo.gb"
else
    echo "⚠️  Note: RGBDS not found. Skipping ROM assembly (using pre-built ROMs)."
fi

# 4. Build the Emulator
echo "🏗️  Building Camlboy Emulator..."
dune build bin/main.exe

# 5. Run with the Homebrew Demo
echo "🚀 Launching Camlboy with Splash Demo..."
./_build/default/bin/main.exe roms/bin/splash_demo.gb
