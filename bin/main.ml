open Camlboy_lib

(* 1. Initialize the Emulator State *)
let cpu = Cpu.create ()
let mmu = Mmu.create ()
let gpu = Gpu.create ()

(* 2. Define the "Tick" logic *)
(* This function is what the C++ bridge will call 60 times per second *)
let camlboy_tick () =
  let cycles_per_frame = 70224 in (* Standard DMG frame cycles *)
  let rec loop cycles =
    if cycles > 0 then begin
      let inst_cycles = Cpu.step cpu mmu in
      Gpu.step gpu inst_cycles;
      loop (cycles - inst_cycles)
    end
  in
  loop cycles_per_frame;
  (* Once the frame is done, we could theoretically pass the 
     pixel buffer back to C++ here if needed. *)
  ()

(* 3. Register for C++ Access *)
(* This string must match the 'caml_named_value' in Emulator.cpp *)
let () =
  Callback.register "camlboy_tick" camlboy_tick

(* 4. Main Entry Point *)
let () =
  Printf.printf "🐫 Camlboy Core Initialized...\n";
  
  (* Handle ROM loading from CLI *)
  let args = Sys.argv in
  if Array.length args > 1 then begin
    let rom_path = args.(1) in
    Mmu.load_rom mmu rom_path;
    Printf.printf "📖 Loaded ROM: %s\n" rom_path
  end else begin
    Printf.printf "⚠️ No ROM provided. Running in idle mode.\n"
  end;

  (* If we are running purely in OCaml/SDL2 mode: *)
  (* Camlboy_app.run ~tick:camlboy_tick *)
  
  (* If we are handing control to the C++ bridge: *)
  Printf.printf "🔌 Handing execution to C++ Bridge...\n"
