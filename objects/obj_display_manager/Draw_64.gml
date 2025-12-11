
/// @description Insert description here
// You can write your code in this editor
// In the Draw event of an object:

// Set the transparency (alpha) for the grid
draw_set_alpha(0.1); // Adjust the value for the desired transparency level (0 = fully transparent, 1 = fully opaque)

// Set the color for the grid lines
draw_set_color(c_black); // Change color as needed

// Get the size of the game view (or room)
var view_width = room_width;  // Or view_wview[0] if you're using views
var view_height = room_height; // Or view_hview[0] if you're using views

// Draw vertical lines
for (var i = 0; i <= view_width; i++) {
    draw_line(i, 0, i, view_height);
}

// Draw horizontal lines
for (var j = 0; j <= view_height; j++) {
    draw_line(0, j, view_width, j);
}

// Reset alpha to default (fully opaque)
draw_set_alpha(1);