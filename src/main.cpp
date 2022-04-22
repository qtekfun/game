extern "C" {
    #include <tinyPTC/src/tinyptc.h>
}
#include <cstdint>
#include <iostream>

constexpr uint32_t kR = 0x00FF00000;
constexpr uint32_t kG = 0x0000FF000;
constexpr uint32_t kB = 0x0000000FF;

constexpr u_int32_t sprite[8*8] = {
    kR, kG, kB, kR,
    kR, kG, kB, kR,
    kR, kG, kB, kR,
    kR, kG, kB, kR
};

constexpr uint32_t kSCRWIDTH  { 640 };
constexpr uint32_t kSCRHEIGHT { 360 };

struct Screen_t {

    Screen_t(uint32_t w, uint32_t h) : screen(new uint32_t[w*h]) {}
    ~Screen_t() {
        std::cout << "Paso? \n";
        delete [] screen;
    }

    uint32_t * screen {nullptr};
};

void execute(){
    ptc_open("window", kSCRWIDTH, kSCRHEIGHT);

    Screen_t scr (kSCRWIDTH, kSCRHEIGHT);

    for (;;) {
        for (u_int32_t i=0; i < 640*360; ++i) {
            scr.screen[i] = kR;
        }
        
        u_int32_t *pscr = scr.screen;
        const u_int32_t *psprt = sprite;

        for (u_int32_t i=0; i < 4; ++i) {
            for (u_int32_t j=0; j < 4; ++j) {
                *pscr = *psprt;
                ++pscr;
                ++psprt;
            }
            pscr += 640 - 4;
        }
        
        throw "Exception";

        ptc_update(scr.screen);
    }
    
    ptc_close();
}

int main(){
    try{
        execute();
    }
    catch(std::exception& e){
        std::cout << "Capturada\n";
    }
    catch(const char * s){
        std::cout << "Capturada: " << s << "\n";
    }
    catch(...){
        std::cout << "Capturada default: \n";
    }

    return 0;
}