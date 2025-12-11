/// @description Insert description here
// You can write your code in this editor
player_element_buffer = 155;
anchor_point_x = (room_width / 3) + (player_element_buffer * player_number); 
anchor_point_y = get_screen_center_y();
x = anchor_point_x;
y = anchor_point_y;
is_active = false;
player_sprite = "";
is_ready = false;
blink_timer = 0;

