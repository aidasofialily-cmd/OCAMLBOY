let read_byte mmu addr =
  if addr >= 0x0000 && addr <= 0x7FFF then
    Cartridge.read mmu.cartridge addr
  else if addr >= 0x8000 && addr <= 0x9FFF then
    Gpu.read_vram mmu.gpu addr
  else
    (* Handle other memory regions *)
