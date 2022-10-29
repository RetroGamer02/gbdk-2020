        .include    "global.s"

        .title  "Metasprites"
        .module Metasprites

        .area   _DATA

___current_metasprite:: 
        .ds     0x02
___current_base_tile::
        .ds     0x01

        .area   _CODE

; uint8_t __move_metasprite(uint8_t id, uint8_t x, uint8_t y) __z88dk_callee __preserves_regs(iyh,iyl);

___move_metasprite::
        ld      hl, #4
        add     hl, sp

        ld      b, (hl)
        dec     hl
        ld      c, (hl)
        dec     hl
        ld      e, (hl)

        ld      hl, (___current_metasprite)

        ld      a, (___render_shadow_OAM)
        ld      d, a
1$:
        ld      a, (hl)         ; dy
        inc     hl
        cp      #0x80
        jp      z, 2$
        add     b        
        ld      b, a
        cp      #0xD0
        jp      nz, 3$
        ld      a, #0xC0
3$:
        ld      (de), a
        inc     e

        ld      a, (hl)         ; dx
        inc     hl
        add     c
        ld      c, a
        ld      (de), a
        inc     e

        ld      a, (___current_base_tile)
        add     (hl)            ; tile
        inc     hl
        ld      (de), a
        inc     e

        ld      a, (hl)
        inc     hl
        ld      (de), a
        inc     e

        jp      1$
2$:
        pop     hl
        pop     bc
        inc     sp
        push    hl
        ld      a, e
        srl     a
        srl     a
        sub     c
        ld      l, a
        ret

___render_shadow_OAM::
        .db     #>_shadow_OAM
