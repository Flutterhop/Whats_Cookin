is_gamepad = InputDeviceIsGamepad(player.device);
player = get_input_player();
bind = InputBindingGet(is_gamepad,icon_index,0,player.player_number);
verb = InputBindingFind(is_gamepad,bind,player.player_number);

