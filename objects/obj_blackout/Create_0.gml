// Initialize fade variables
alpha_value = 0; // Start with full visibility (no fade)
fade_speed = 0.02; // How fast the screen fades to black
fully_closed = false; // Track when fade is complete
is_fade_in = true;
is_fade_out = false;
depth = -999; // Ensure it's always at the front


function fade_in(){
	is_fade_in = true;
	fully_closed = false;
	is_fade_out = false;
}

function fade_out(){
	is_fade_out = true;
	fully_closed = false;
	is_fade_in = false;
}