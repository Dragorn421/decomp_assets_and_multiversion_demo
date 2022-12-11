#include "art.h"

char everyones_favurite_emote[] =
#if VERSION == 0
    "figW"
#else
    "capy"
#endif
    ;

uint8_t purple_png[] = {
#include "build/assets/_extracted/art/purple.png.inc.c"
};

#if VERSION==1
uint8_t toonlink_png[] = {
#include "build/assets/_extracted/art/toonlink.png.inc.c"
};
#endif
