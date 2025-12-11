/// @description Insert description here
// You can write your code in this editor
event_user(EV_INIT); //define menu elements
event_user(EV_METHOD_BINDING);
load_users(INPUT_MAX_PLAYERS);
load_bind_rules();
InputSetHotswap(true);
set_default_game_settings();
load_game_settings();

