(* Example of opcode decoding in OCaml *)
type registers = { mutable a: int; mutable b: int; ... }

let execute_opcode cpu mmu opcode =
  match opcode with
  | 0x00 -> () (* NOP *)
  | 0x3E ->    (* LD A, d8 *)
      let data = Mmu.read_byte mmu cpu.pc in
      cpu.a <- data;
      cpu.pc <- cpu.pc + 1
  | 0xC3 ->    (* JP nn *)
      let addr = Mmu.read_word mmu cpu.pc in
      cpu.pc <- addr
  | _ -> failwith (Printf.sprintf "Unknown opcode: %02x" opcode)
