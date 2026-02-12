#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/alloc.h>
#include <iostream>

extern "C" {
    // This allows C++ to call the OCaml "tick" function
    void run_emulator_tick() {
        static const value * tick_closure = NULL;
        if (tick_closure == NULL) {
            tick_closure = caml_named_value("camlboy_tick");
        }
        caml_callback(*tick_closure, Val_unit);
    }

    // High-performance pixel buffer transfer
    void render_frame(unsigned char* buffer) {
        // Here you would interface with SDL2 or a GPU shader
        // to render the 160x144 Game Boy screen
        std::cout << "Rendering frame via C++ bridge..." << std::endl;
    }
}
