/// @description Insert description here
// You can write your code in this editor
event_user(EV_INIT);
event_user(EV_METHOD_BINDING);
init_sprites();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											START OF STATE FUNCTIONS																				  //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function idle(){
//when idle, the enemy is not moving but will face in the direction of the player. This is a temp state between move and fire.
	
	if(is_null(target_player) && !instance_exists(target_player)){
		target_player = find_target();
	}
	set_direction(); //setting direction from create event.
	image_speed = 1;
	if(idle_timer_set == false && alarm[0] < 1){
		alarm[0] = set_random_idle_time();
		alarm[10] = iframe_reset_time;
		idle_timer_set = true;
	}else if(idle_timer_set == true && alarm[0] < 1){
		idle_timer_set = false;
	}
}
function decide_movement(){
	//when moving, the enemy determines a vector based on player position and moves towards that position, however we want the enemy to stop when
	//a timer goes off, not when it reaches its destination.
	var angle_to_player = 0;
	// will chase based on the enemies chase odds. Greater the chase odds less chance of chase.
	if (get_chase_odds()) {
		// Move toward player
		if (not_null(target_player) && instance_exists(target_player)) {
		    angle_to_player = point_direction(x, y, target_player.x, target_player.y);
		    move_x = lengthdir_x(move_speed, angle_to_player);
		    move_y = lengthdir_y(move_speed, angle_to_player);

		} else {
		    target_player = find_target();
		}
	} else {
		// Random direction
		var random_angle = irandom(359);
		move_x = lengthdir_x(move_speed, random_angle);
		move_y = lengthdir_y(move_speed, random_angle);
	}
	//set alarm so that the enemy stops when we want it to.
	//We need this state code to run only once, since we want the enemy to decide what direction to move once, and then move.
	set_direction();
	change_state(enemy_state,"move","Movement decided, changing to move state.");
	//We set this alarm at this point in order to have a background timer deciding when to have the enemy stop moving.
	alarm[1] = movement_amount;
}
function move(){
	//Just moving. That's all for now. The alarm[0] will alter the state asyncronusly so this is all this case has to do.	
	if (has_local_avoidance){                
        var _move_x = move_x + avoid_x;
        var _move_y = move_y + avoid_y;
        _dist = sqrt(_move_x * _move_x + _move_y * _move_y);
        if (_dist != 0){
            _move_x = _move_x / _dist * move_speed;
            _move_y = _move_y / _dist * move_speed;
        }
	}else{
        _move_x = move_x;
        _move_y = move_y;
    }
	move_and_collide(move_x,move_y,[obj_boundary,obj_enemy_parent]);
	
}
//////////////////////////////////////////////// RANGED STATE FUNCTIONS//////////////////////////////////////////////////////////////////////////////////


function begin_firing(){
	if(not_null(target_player) && instance_exists(target_player)){
		//Begin the startup for firing, this is here because we have an animation we need to run before actually spawning the bullet.
		var target_x = target_player.x;
		var target_y = target_player.y;
		set_attack_direction();
		if(image_index == 12){
			change_state(enemy_state,"fire","Fire bullet, the correct frame has been reached. (this is obsolete and specific to an animation.)");
			set_direction();
			return;
		}
	}else{
		change_state(enemy_state,"idle","no target, returning to idle.");
	}
}		



function fire(){
//So anyways I started blasting.	
	var bullet = instance_create_layer(x,y,"Bullets",obj_enemy_bullet, {damage : damage_amount, target_player : target_player});
	change_state(enemy_state,"idle","Bullet fired, return to idle.");
	bullet_fired = false;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											END OF STATE FUNCTIONS																					  //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
