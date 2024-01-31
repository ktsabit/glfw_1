using SDL;
// using GLFW;
using SDLGraphics;
// using GL;

class Player {
    public const int DOT_WIDTH = 20;
    public const int DOT_HEIGHT = 20;
    public const int DOT_VEL = 1;
    public bool movedkah = false;
    int mPosX;
    int mPosY;
    int mVelX;
    int mVelY;

    int vx = 100;
    int vy = 120;
    double dt = 1;
    int a = 1;
    double mVel;

    public Player() {
        mPosX = 200;
        mPosY = 50;
        mVelX = 0;
        mVelY = 0;
        mVelX = vx;
        mVelY = vy;
        mVel = Math.sqrt(Math.pow(mVelX, 2) + Math.pow(mVelY, 2));
    }

    public void handleEvent(Event e) {
        if (e.type == EventType.KEYDOWN && e.key.repeat == 0) {
            switch (e.key.keysym.sym) {
            case Input.Keycode.UP: mVelY -= DOT_VEL; print("UP\n"); break;
            case Input.Keycode.DOWN: mVelY += DOT_VEL; print("DOWN\n");  break;
            case Input.Keycode.LEFT: mVelX -= DOT_VEL; print("LEFT\n");  break;
            case Input.Keycode.RIGHT: mVelX += DOT_VEL; print("RIGHT\n");  break;
            default: break;
            }
        } else if (e.type == EventType.KEYUP && e.key.repeat == 0) {
            switch (e.key.keysym.sym) {
            case Input.Keycode.UP: mVelY += DOT_VEL; print("UP\n"); break;
            case Input.Keycode.DOWN: mVelY -= DOT_VEL; print("DOWN\n");  break;
            case Input.Keycode.LEFT: mVelX += DOT_VEL; print("LEFT\n");  break;
            case Input.Keycode.RIGHT: mVelX -= DOT_VEL; print("RIGHT\n");  break;
            default: break;
            }
        }
    }

    public void move() {
        mPosX += mVelX;
        if (mPosX < 0 || mPosX + DOT_WIDTH > 640)mPosX -= mVelX;
        mPosY += mVelY;
        if (mPosY < 0 || mPosY + DOT_HEIGHT > 480)mPosY -= mVelY;
    }

    public void move2() {
        
            mPosX += (int) (mVelX * dt);
            mPosY += (int) (mVelY * dt);
            if (mPosX < DOT_HEIGHT) {
                mVelX = -mVelX;
                mPosX = 2 * (DOT_HEIGHT - mPosX);
            }
            if (mPosX > 640 - DOT_HEIGHT) {
                mVelX = -mVelX;
                mPosX = 2 * (640 - DOT_HEIGHT) - mPosX;
            }
            if (mPosY < DOT_HEIGHT) {
                mVelY = -mVelY;
                mPosY = 2 * (DOT_HEIGHT - mPosY);
            }
            if (mPosY > 480 - DOT_HEIGHT) {
                mVelY = -mVelY;
                mPosY = 2 * (480 - DOT_HEIGHT) - mPosY;
            }
            double mVele = Math.sqrt(Math.pow(mVelX, 2) + Math.pow(mVelY, 2));
            //  if (mVel < )break;
            if (mVel > 0) mVel -= a * dt;
            if (mVel < 0) mVel += a * dt;
            //  if (mVel < dt) return;
            mVelX = (int)(mVel*(mVelX/mVele));
            mVelY = (int)(mVel*(mVelY/mVele));
            print("mVel: %f\na: %f\ndt: %f\n", mVel, a, dt);
            SDL.Timer.delay(10);
    }

    public void render(Video.Renderer renderer) {
        Circle.fill_rgba(renderer, (int16) mPosX, (int16) mPosY, (int16) DOT_WIDTH,
                         0x00, 0x00, 0x00, 0xff);
        Circle.fill_rgba(renderer, (int16) mPosX, (int16) mPosY, (int16) 9, 0xff, 0xff, 0xff, 0xff);
    }
}

int main() {
    if (SDL.init(InitFlag.VIDEO) < 0) {
        print("SDL could not initialize! SDL_Error: %s\n", get_error());
    } else {

        Video.Window window = new Video.Window("SDL Trial", (int) Video.Window.POS_CENTERED, (int) Video.Window.POS_CENTERED, 640, 480, Video.WindowFlags.RESIZABLE | Video.WindowFlags.OPENGL);
        if (window == null) {
            print("Window could not be created! SDL_Error: %s\n", get_error());
        } else {
            int w, h;
            window.get_size(out w, out h);
            SDL.Video.Renderer renderer;
            Video.Renderer.create_with_window(w, h, Video.WindowFlags.RESIZABLE | Video.WindowFlags.OPENGL, out window, out renderer);
            Event e;
            bool quit = false;
            // renderer.set_draw_color (0xaa, 0xff, 0xff, 0xff);
            // rend
            ////  renderer.fill_rect (null);
            // renderer.present ();

            Player player = new Player();
            renderer.present();


            double timeStep = 0.01; 
            double currentTime = 0;
            double accumulator = 0;
            double previousTime = 0;

            while (!quit) {
                currentTime = SDL.Timer.get_ticks() / 1000;
                
                accumulator += currentTime - previousTime;
                while (Event.poll(out e) != 0) {
                    if (e.type == EventType.QUIT) {
                        quit = true;
                    }
                    if (e.type == EventType.KEYDOWN) {
                        ////  if (e.key.keysym.sym == Input.Keycode.i) {
                        ////      print("yeah\n");
                        ////      //  Circle.fill_color (renderer, 640/2-50,  480/2-50, 100, 0xffaacc);
                        ////      renderer.set_draw_color (0xaa, 0xff, 0xff, 0xff);

                        ////      renderer.fill_rect (null);
                        ////      Circle.fill_rgba (renderer, 640/2-50,  480/2-50, 100, 0xff, 0xaa, 0xcc, 0xff);

                        ////      //  renderer.clear ();
                        ////      //  Video.Rect rect =  Video.Rect ();
                        ////      //  rect.x = 640/2-50;
                        ////      //  rect.y = 480/2-50;
                        ////      //  rect.w = 100;
                        ////      //  rect.h = 100;
                        ////      //  renderer.set_draw_color (0xff, 0xaa, 0xcc, 0xff);
                        ////      //  renderer.fill_rect (rect);
                        ////      //  print("ret: %d\n", ret);
                        ////      renderer.present ();

                        ////      //  window.update_surface ();
                        ////  }
                        if (e.key.keysym.sym == Input.Keycode.ESCAPE)quit = true;
                    }

                    player.handleEvent(e);
                }
                // player.move ();
                player.move2();
                // renderer.set_draw_color (0xaa, 0xff, 0xff, 0xff);
                renderer.set_draw_color(0x15, 0x58, 0x43, 0xff);
                renderer.clear();
                player.render(renderer);
                renderer.present();
            }
            window.destroy();
        }
    }
    quit();
    return 1;
}