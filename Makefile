# --- Configuration ---
BINARY = _build/default/bin/main.exe
ROM_SRC = roms/source/main.asm
ROM_BIN = roms/bin/splash_demo.gb

# --- Build Rules ---

.PHONY: all build rom run clean test setup

all: build rom

# Build the OCaml emulator and C++ bridge
build:
	@echo "🏗️  Building Camlboy..."
	dune build bin/main.exe --profile release

# Assemble the homebrew Game Boy ROM
rom:
	@echo "🎮 Assembling Homebrew ROM..."
	@mkdir -p roms/bin
	rgbasm -o roms/source/main.o $(ROM_SRC)
	rgblink -o $(ROM_BIN) roms/source/main.o
	rgbfix -v -p 0 $(ROM_BIN)

# Run the emulator with the default demo
run: build rom
	@echo "🚀 Launching Camlboy..."
	./$(BINARY) $(ROM_BIN)

# Install necessary OCaml dependencies
setup:
	@echo "📦 Installing opam dependencies..."
	opam install . --deps-only
	@echo "✅ Ready to build."

# Clean build artifacts
clean:
	@echo "🧹 Cleaning up..."
	dune clean
	rm -f roms/source/*.o
	rm -rf roms/bin/

# Run the test suite
test:
	@echo "🧪 Running Opcode Tests..."
	dune runtest
