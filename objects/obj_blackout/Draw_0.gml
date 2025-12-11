// Set the drawing alpha to the current fade value
draw_set_alpha(alpha_value);

// Set the draw color to black
draw_set_color(c_black);

// Draw a black rectangle that covers the entire screen
draw_rectangle(0, 0, display_get_width(), display_get_height(), false);

// Reset the alpha to 1 for other objects to be drawn normally
draw_set_alpha(1);
