if (!fully_closed && is_fade_in) {
    // Increase alpha value for fade effect
    alpha_value += fade_speed;
    
    // Clamp alpha_value to a maximum of 1
    if (alpha_value >= 1) {
        alpha_value = 1; // Fully black screen
        fully_closed = true; // Fade effect is complete
		is_fade_in = false;
    }
}

if (!fully_closed && is_fade_out) {
    // Increase alpha value for fade effect
    alpha_value -= fade_speed;
    
    // Clamp alpha_value to a maximum of 1
    if (alpha_value <= 0) {
        alpha_value = 0; // Fully black screen
        fully_closed = true; // Fade effect is complete
		is_fade_out = false;
		instance_destroy(id)
    }
}
