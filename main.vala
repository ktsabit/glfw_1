using SDL;

// using SDLGraphics;

int main () {
 
    if (init (InitFlag.VIDEO) < 0) {
        print ("SDL could not initialize! SDL_Error: %s\n", get_error ());
    } else {
        //  string driver = Video.get_current_driver ();
        //  print ("Driver: %s\n", driver);
        
        Video.Window window = new Video.Window ("SDL Tutorial", (int)Video.Window.POS_CENTERED, (int)Video.Window.POS_CENTERED, 640, 480, Video.WindowFlags.FULLSCREEN_DESKTOP | Video.WindowFlags.OPENGL  );
        //  window.
        if (window == null) {
            print ("Window could not be created! SDL_Error: %s\n", get_error ());
        }
        // SDL.Timer.delay (4000);
        else {
            Event e;
            bool quit = false;
            
            SDL.Video.DisplayMode m = { 800, 600, 0, 0 };
            window.set_display_mode (m);
            //  window.show ();
            int a,b;
            window.get_position (out a, out b);
            print("Position: %d, %d\n", a, b);
            float brightness = window.get_brightness ();
            print("Brightness: %f\n", brightness);
            window.get_size (out a, out b);
            print("Size: %d, %d\n", a, b);
            window.get_gl_drawable_size (out a, out b);
            print("GL Drawable Size: %d, %d\n", a, b);
            Video.DisplayMode mode;
            window.get_display_mode (out mode);
            print("Display Mode: %d, %d, %d, %d\n", mode.format, mode.w, mode.h, mode.refresh_rate);
            print("Flags: %l\n", window.get_flags ());
            //  window.
            //  window.raise ();

            Video.GL.Context ctx = Video.GL.get_current_context ();
            Video.GL.make_current (window, ctx);

            Video.Window wincheck = Video.GL.get_current_window ();
            int display = wincheck.get_display ();
            int display_o = window.get_display ();
            print("Display: %d\n", display);
            print("Display ori: %d\n", display_o);
            Video.Surface screenSurface = window.get_surface ();
            screenSurface.fill_rect (null, 0xFFAABB);
            window.update_surface ();
            //  window.show ();

            //  SDL.Timer.delay (3000);
            while (!quit) {
                while (Event.poll(out e) != 0) {
                    if (e.type == EventType.QUIT) {
                        quit = true;
                    }
                    if (e.type == EventType.KEYDOWN) {
                        quit = true;
                    }
                }
            }
            window.destroy ();
        }
    }
    quit ();
    return 1;
}