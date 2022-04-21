extern "C" {
    #include "tinyPTC/tinyptc.h"
}
#include <cstdint>

u_int32_t screen[640*360];

u_int32_t sprite[4*4] = {
    0x00FF00000, 0x0000FF000, 0x0000000FF, 0x00FF00000,
    0x00FF00000, 0x0000FF000, 0x0000000FF, 0x00FF00000,
    0x00FF00000, 0x0000FF000, 0x0000000FF, 0x00FF00000,
    0x00FF00000, 0x0000FF000, 0x0000000FF, 0x00FF00000
};


int main(){
    ptc_open("window", 640, 360);

    for (;;) {
        for (u_int32_t i=0; i < 640*360; ++i) {
            screen[i] = 0x00FF00000;
        }
        
        u_int32_t *pscr = screen;
        u_int32_t *psprt = sprite;

        for (u_int32_t i=0; i < 4; ++i) {
            for (u_int32_t j=0; j < 4; ++j) {
                *pscr = *psprt;
                ++pscr;
                ++psprt;
            }
            pscr += 640 - 4;
        }
        
        ptc_update(screen);
    }
    
    ptc_close();

    return 0;
}