INCLUDE "hardware.inc"

SECTION "Header", ROM0[$100]
    jp Start
    ds $150 - @, 0 ; Space for the internal header

Start:
    ; Wait for VBlank to safely turn off the LCD
.waitVBlank
    ld a, [rLY]
    cp 144
    jr c, .waitVBlank

    xor a ; ld a, 0
    ld [rLCDC], a ; Turn off LCD

    ; Load "Hello OCaml" into VRAM
    ; (Simplified: In a real game, you'd copy font tiles here)

    ld a, %10010001 ; LCD On, BG On
    ld [rLCDC], a

MainLoop:
    jr MainLoop
