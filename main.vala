using GLFW;
//  using GL;

int main () {
    bool running = true;

    // Initialize GLFW
    //  glfwInit ();
    init ();

    // Open an OpenGL window (you can also try Mode.FULLSCREEN)
    Window window = new Window (640, 480, "Hello, world!");
    if (window == null) {
        terminate();
        return 1;
    }


    // Main loop
    while (running) {
        // OpenGL rendering goes here...
        //  glClear (GL_COLOR_BUFFER_BIT);
        
        //  glBegin (GL_TRIANGLES);
        //      glVertex3f ( 0.0f, 1.0f, 0.0f);
        //      glVertex3f (-1.0f,-1.0f, 0.0f);
        //      glVertex3f ( 1.0f,-1.0f, 0.0f);
        //  glEnd ();

        // Swap front and back rendering buffers
        //  glfwSwapBuffers ();
        window.swap_buffers ();

        // Check if ESC key was pressed or window was closed

        running = window.get_key (Key.ESCAPE) != ButtonState.PRESS;
    }

    // Close window and terminate GLFW
    //  glfwTerminate ();
    window.should_close = true;

    // Exit program
    return 0;
}