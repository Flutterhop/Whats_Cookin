/// @description Insert description here
// You can write your code in this editor
event_inherited();
generate_medkit			 = method(id,core_generate_medkit);
check_player_medkit		 = method(id,core_check_player_medkit);
spawn_players			 = method(id,core_spawn_players);
load_items				 = method(id,core_load_items);
start_match				 = method(id,core_start_match);
end_game				 = method(id,core_end_game);
enable_priority			 = method(id,core_enable_priority);
disable_priority		 = method(id,core_disable_priority);
set_priority_enforcement = method(id,core_set_priority_enforcement);
recall_bramble			 = method(id,core_recall_bramble);


///STATE FUNCTION///
toggle_shop				 = method(id,state_toggle_shop);
enable_shop				 = method(id,state_enable_shop);
disable_shop			 = method(id,state_disable_shop);
check_player_status		 = method(id,state_check_player_status);

///SHOP FUNCTION///
init_shop_items			 = method(id,shop_initialize_items);///dont even ask me why this still works

///ARENA FUNCTION///
track_players			 = method(id,arena_track_players);

///INPUT FUNCTION///
input_action_1_pressed	 = method(id,game_manager_input_action_1_pressed);


///GAME MANAGER FUNCTION///
end_match				 = method(id,game_manager_end_match);
set_next_round			 = method(id,game_manager_set_next_round);
init_items				 = method(id,game_manager_init_items);
reset_arena				 = method(id,game_manager_reset_arena);
quit_adventure			 = method(id,game_manager_quit_adventure);
quit_default			 = method(id,game_manager_quit_default);

