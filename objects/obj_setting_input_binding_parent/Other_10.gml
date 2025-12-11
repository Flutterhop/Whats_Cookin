/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
player = get_input_player();
bind_sprite = InputIconGet(icon_index,0,player.player_number);
text_size_mod = .5;
icon_size_mod = .8;
bind_alert = "";

is_gamepad = InputDeviceIsGamepad(player.device);

bind = InputBindingGet(is_gamepad,icon_index,0,player.player_number);
verb = InputBindingFind(is_gamepad,bind,player.player_number);