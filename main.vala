using SDL;
using SDLGraphics;
using SDLImage;

class Ball {
    public double r;
    public double x;
    public double y;
    double a;
    public double vx;
    public double vy;
    double v;
    double px;
    double py;
    bool cue;
    Video.Texture texture;

    public Ball(double x, double y, RWops tx, Video.Renderer renderer,double  vx = 1, double vy = 1, bool cue = false) {
        r = 17;
        this.x = x;
        this.y = y;
        a = 100;
        this.vx = vx;
        this.vy = vy;
        texture = load_texture_rw(renderer, tx);
        this.cue = cue;
        v = Math.sqrt(vx * vx + vy * vy);
    }

    double distSq( double x1, double y1, double x2, double y2) {
        double dx = x1 - x2;
        double dy = y1 - y2;
        return dx * dx + dy * dy;
    }

    bool checkCollision(Ball b) {
        double totalRadius = this.r + b.r;
        double totalSq = totalRadius * totalRadius;
        if (distSq(this.x, this.y, b.x, b.y) < totalSq) {
            return true;
        }
        return false;
    }

    public void move(double dt, Gee.List<Ball> balls) {
        print("x: %f, y: %f, vx: %f, vy: %f\n", x, y, vx, vy);
        x += vx * dt;
        y += vy * dt;

        if (vx.abs() < 0.5) vx = 0;
        if (vy.abs() < 0.5) vy = 0;

        if (x < r) {
            x = r;
            vx = -vx * 0.8;
        }
        if (x > 880 - r) {
            x = 880 - r;
            vx = -vx * 0.8;
        }
        if (y < r) {
            y = r;
            vy = -vy * 0.8;
        }
        if (y > 440 - r) {
            y = 440 - r;
            vy = -vy * 0.8;
        }

        foreach (Ball ball in balls) {
            if (checkCollision(ball)) {
                double dx = x - ball.x;
                double dy = y - ball.y;
                double dist = Math.sqrt(dx * dx + dy * dy);
                double nx = dx / dist;
                double ny = dy / dist;
                double p = 2 * (vx * nx + vy * ny - ball.vx * nx - ball.vy * ny) / (1 + 1);
                vx = vx - p * nx;
                vy = vy - p * ny;
                ball.vx = ball.vx + p * nx;
                ball.vy = ball.vy + p * ny;
            }
        }

        if (vx != 0 || vy != 0) {
            double f = (v - a * dt) / v;
            vx *= f;
            vy *= f;
            v = Math.sqrt(vx * vx + vy * vy);
        }

        px = x;
        py = y;
    }

    public void render(Video.Renderer renderer, double alpha = 1.0) {
        double ix = lerp(px, x, alpha);
        double iy = lerp(py, y, alpha);

        Video.Rect rect = Video.Rect();
        int m = cue ? 8 : 0;
        rect.x = (int16) (ix - r);
        rect.y = (int16) (iy - r);
        rect.w = (uint16) (2 * r) -m;
        rect.h = (uint16) (2 * r) -m;

        renderer.copy(texture, null, rect);
    }

    double lerp(double a, double b, double f) {
        return a + f * (b - a);
    }
}

double rowY(int rowNumber, int r) {
    return rowNumber * (Math.sqrt(5) * r);
}

double[]? rowXs(int rowNumber , int r) {
    switch (rowNumber) {
        case 0: return new double[] {0};
        case 1: return new double[] {-r, r};
        case 2: return new double[] {-2*r, 0, 2*r};
        case 3: return new double[] {-3*r, -r, r, 3*r};
        case 4: return new double[] {-4*r, -2*r, 0, 2*r, 4*r};
        default: return null;
    }
}


int main() {

    if (SDL.init(InitFlag.VIDEO) < 0) {
        print("SDL could not initialize! SDL_Error: %s\n", get_error());
    } else {

       
        //  Video.Window
        Video.Window window = new Video.Window("SDL Trial", (int) Video.Window.POS_CENTERED, (int) Video.Window.POS_CENTERED, 880, 440, Video.WindowFlags.RESIZABLE | Video.WindowFlags.OPENGL);
        if (window == null) {
            print("Window could not be created! SDL_Error: %s\n", get_error());
        } else {
            int w, h;
            window.get_size(out w, out h);
            SDL.Video.Renderer renderer;
            Video.Renderer.create_with_window(w, h, Video.WindowFlags.RESIZABLE | Video.WindowFlags.OPENGL, out window, out renderer);
            Event e;
            bool quit = false;

            RWops tx = new RWops.from_file("../bb.png", "rb");
            Ball ball = new Ball(50, 220, tx, renderer, 10,0,true);

            Gee.List<Ball> balls = new Gee.ArrayList<Ball>();

            for (int i = 0; i < 5; i++) {
                double y = rowY(i, 17);
                foreach (double x in rowXs(i, 17)) {
                    double bx = y + 500;
                    double by = x + 220;
                    RWops txb = new RWops.from_file("../8ball.png", "rb");
                    Ball bal = new Ball(bx, by, txb, renderer);
                    balls.add(bal);
                }
            }

            double current_time = SDL.Timer.get_ticks() / 1000.0f;
            double accumulator = 0.0f;
            double tick_rate = 1.0f / 1000.0f;
    
            
            while (!quit) {

                while (Event.poll(out e) != 0) {
                    if (e.type == EventType.MOUSEBUTTONDOWN) {
                        if (e.button.button == Input.MouseButton.LEFT) {
                            ball.vx = (e.button.x - ball.x) * 5;
                            ball.vy = (e.button.y - ball.y) * 5;
                        }
                    }
                    if (e.type == EventType.QUIT) {
                        quit = true;
                    }
                    if (e.type == EventType.KEYDOWN) {
                        if (e.key.keysym.sym == Input.Keycode.ESCAPE)quit = true;
                    }
                }

                double new_time = SDL.Timer.get_ticks() / 1000.0f;
                double frame_time = new_time - current_time;

                if (frame_time > 0.25) frame_time = 0.25;

                current_time = new_time;
                accumulator += frame_time;

                while (accumulator >= tick_rate) {
                    ball.move(tick_rate, balls);
                    foreach (Ball b in balls) {
                        Gee.List<Ball> bb = new Gee.ArrayList<Ball>();
                        bb.add_all(balls);
                        bb.remove(b);
                        b.move(tick_rate, bb);
                    }
                    accumulator -= tick_rate;
                }

                renderer.set_draw_color(0x15, 0x58, 0x43, 0xff);
                renderer.clear();

                double alpha = accumulator / tick_rate;
                ball.render(renderer, alpha);
                foreach (Ball b in balls) {
                    b.render(renderer, alpha);
                }

                renderer.present();
            }
            window.destroy();
        }
    }
    SDL.quit();
    return 1;
}