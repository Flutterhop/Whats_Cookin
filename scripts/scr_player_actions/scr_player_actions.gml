
function player_input_right(player){
	var instance = player.player_instance;
	with(instance){
		if(!direction_locked){	
			right_num = 1;
		}
	}
}

function player_input_left(player){
	var instance = player.player_instance;
	with(instance){
		if(!direction_locked){	
			left_num = 1;
		}
	}
}
	
function player_input_up(player){
	var instance = player.player_instance;
	with(instance){
		if(!direction_locked){
			up_num = 1;
		}
	}
}

function player_input_down(player){
	var instance = player.player_instance;
	with(instance){
		if(!direction_locked){
			down_num = 1;
		}
	}
}
	
function player_input_action_1(player){
	if (!player.holding){
	
	}

}
	
function player_input_action_1_released(player){
	if(grappled){
		var index_check = sprite_get_number(sprite_index);
		if((grapple_source.image_index + 1) >= index_check){
			grapple_source.image_index = 0;
			grapple_source.break_out_counter++;
		}else{
			grapple_source.break_out_counter++;
			grapple_source.image_index++;
		}
		if(grapple_source.break_out_counter >= grapple_source.break_out_target){
			grapple_source.spit_out();
		}
		return;
	}
	var instance = player.player_instance;
	with(instance){
		holdDirection = false;
		shootDirection = face;
	}
}
	
function player_input_action_2(_player){
	var instance = _player.player_instance;
	with(instance){
		if(!round_ended){
			if (!bomb_remote) {
				// Only spawn bombs when bomb_remote is false
				if (bomb_current > 0) {
				    ds_list_add(bomb_bar.unique_bomb_ui_timers, 80);
            
				    // Spawn bomb for player
				    instance_create_layer(x, y, "Bullets", obj_bomb, {player : instance,
																		sprite_index : bomb_sprite,
																		lure : bomb_lure 
																		});

				    // Spawn bomb for mirror at its position
				    if (not_null(mirror_instance) && instance_exists(mirror_instance)) {
				        mirror_instance.mirror_bomb(bomb_sprite,bomb_lure);
				    }

				    bomb_current--;
				} else {
					obj_audio_manager.play_sfx(menu_blip, "low", .6)
				}
			} else {
				// Remote Bomb Detonation
				if (bomb_toggle) {
				    // Spawn bomb mode
				    if (bomb_current > 0) {
				        ds_list_add(bomb_bar.unique_bomb_ui_timers, 80);

				        // Spawn bomb for player
				        instance_create_layer(x, y, "Bullets", obj_bomb, {player : instance,
																			sprite_index : bomb_sprite,
																			lure : bomb_lure
																			});

					    // Spawn bomb for mirror at its position
					    if (not_null(mirror_instance) && instance_exists(mirror_instance)) {
					        mirror_instance.mirror_bomb(bomb_sprite,bomb_lure);
					    }

				        bomb_current--;
				        bomb_toggle = false; // Switch to detonate mode
				    } else {
				        obj_audio_manager.play_sfx(menu_blip, "low", .6)
				    }
				} else {
				    // Detonate all bombs
				    with (obj_bomb) {
				        remote_detonate();
				    }
				    bomb_toggle = true; // Switch back to spawn mode
				}
			}
		}		
	}
}
	
function player_input_action_3(player){
	if(!dash){return;}
	
	if(!dash_on_cooldown && (xaxis != 0 || yaxis != 0)){
		iframes = true;
		player_is_dashing = true;
		dash_on_cooldown = true;
		direction_locked = true;
		player_speed = dash_speed;
		alarm[5] = dash_frames;
		alarm[6] = dash_cooldown;
	}
}