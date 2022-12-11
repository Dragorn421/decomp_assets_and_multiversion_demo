#include <stdint.h>

typedef struct MathConst {
    int8_t n_digits;
    uint8_t digits[31];
} MathConst;

MathConst pi = {
    9,
    { 3, 1, 4, 1, 5, 9, 2, 6, 5 },
};

MathConst e = {
    4,
    { 2, 7, 1, 8 },
};

#if VERSION==1
MathConst meme = {
    5,
    { 6, 9, 4, 2, 0 },
};
#endif
