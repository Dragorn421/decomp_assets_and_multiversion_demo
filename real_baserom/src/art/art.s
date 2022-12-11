.data

emote_name_str:
.global emote_name_str
#if VERSION==0
.asciz "figW"
#else
.asciz "capy"
#endif

.align 0x20
jesaistout_png:
.global jesaistout_png
.incbin "src/art/jesaistout.png"

#if VERSION==1
.align 0x20
skawoUHHUH_png:
.global skawoUHHUH_png
.incbin "src/art/skawoUHHUH.png"
#endif
