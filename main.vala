using SDL;
// using GLFW;
using SDLGraphics;
// using GL;

class Player {
    public const int DOT_WIDTH = 20;
    public const int DOT_HEIGHT = 20;
    public const int DOT_VEL = 1;
    public bool movedkah = false;
    int posX;
    int posY;
    int velX;
    int velY;
    int a;
    public double vel;
    double totalTime = 0;
    double previousTime;
    int interpX;
    int interpY;
    int previousX;
    int previousY;

    


    public Player() {
        interpX = posX;
        interpY = posY;
        posX = 200;
        posY = 50;
        velX = 500;
        velY = 500;
        a = 1;
        vel = Math.sqrt(Math.pow(velX, 2) + Math.pow(velY, 2));
        previousTime = getTime();
    }

    double dt() {
        double currentTime = getTime();
        double deltaTime = currentTime - previousTime;
        previousTime = currentTime;
        print("ct: %f\npt: %f\n", getTime(), previousTime);
        print("dt: %f\n", deltaTime);
        return deltaTime;
    }

    public void move2() {
            previousX = posX;
            previousY = posY;
            posX += (int) (velX * dt());
            posY += (int) (velY * dt());
            print("posX: %d\nposY: %d\n", posX, velY);

            if (posX < DOT_HEIGHT - 1) {
                velX = -velX;
                //  posX = 2 * (DOT_HEIGHT - posX);
            }
            if (posX > 640 - DOT_HEIGHT + 1) {
                velX = -velX;
                //  posX = 2 * (640 - DOT_HEIGHT) - posX;
            }
            if (posY < DOT_HEIGHT - 1) {
                velY = -velY;
                //  posY = 2 * (DOT_HEIGHT - posY);
            }
            if (posY > 480 - DOT_HEIGHT + 1) {
                velY = -velY;
                //  posY = 2 * (480 - DOT_HEIGHT) - posY;
            }
            double vele = Math.sqrt(Math.pow(velX, 2) + Math.pow(velY, 2));
            if (vel > 0) vel -= a * dt();
            if (vel < 0) vel += a * dt();
            velX = (int)(vel*(velX/vele));
            velY = (int)(vel*(velY/vele));
            print("vel: %f\na: %f\ndt: %f\n", vel, a, dt());
    }

    public void render(Video.Renderer renderer) {
        Circle.fill_rgba(renderer, (int16) interpX, (int16) interpY, (int16) DOT_WIDTH,
                         0x00, 0x00, 0x00, 0xff);
        Circle.fill_rgba(renderer, (int16) interpX, (int16) interpY, (int16) 9, 0xff, 0xff, 0xff, 0xff);
    }

    double getTime() {
        return SDL.Timer.get_performance_counter() / 1000.0;  
    }

    public void lerp(double alpha) {
        interpX = (int) (previousX + (posX - previousX) * alpha);
        interpY = (int) (previousY + (posY - previousY) * alpha);
    }

}



    

int main() {

    uint64 lastTime = SDL.Timer.get_performance_counter();

    double getElapsedTime() {

        return SDL.Timer.get_performance_counter();

        //  uint64 currentTime = SDL.Timer.get_performance_counter();
        //  double elapsed = (currentTime - lastTime) / SDL.Timer.get_performance_frequency ();
        //  lastTime = currentTime;
        //  return elapsed;
      
    }

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

            Player player = new Player();
            renderer.present();


            double accumulator = 0;
            const double TIME_STEP = 0.01; 
            while (!quit) {

                while (Event.poll(out e) != 0) {
                    if (e.type == EventType.QUIT) {
                        quit = true;
                    }
                    if (e.type == EventType.KEYDOWN) {
                        if (e.key.keysym.sym == Input.Keycode.ESCAPE)quit = true;
                    }
                }
                accumulator += getElapsedTime();
                print("elapsed: %f\n", getElapsedTime());
                print("acc: %f\n", accumulator);
                print("ts: %f\n", TIME_STEP);
                if (accumulator >= TIME_STEP) {
                    accumulator -= TIME_STEP;
                    player.move2();
                }
                renderer.set_draw_color(0x15, 0x58, 0x43, 0xff);
                renderer.clear();
                player.lerp(accumulator / TIME_STEP);
                player.render(renderer);
                renderer.present();
            }
            window.destroy();
        }
    }
    quit();
    return 1;
}