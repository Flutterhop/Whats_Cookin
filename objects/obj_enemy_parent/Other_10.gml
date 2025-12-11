event_inherited();
spawner = "";
enemy_state = "idle";
hp = 1;
target_player = 0;
enemy_scale = 1;
idle_timer_set = false;
shoot_chance = 80;

damage_timer = 0;
move_x = 0;
move_y = 0;
avoidance = instance_create_depth(x,y,0,obj_avoidance,{entity : id } );

direction_facing = "left";

move_timer_set = false;

//knockback
knockback_timer = 0;  // Tracks the duration of knockback, change in collision to adjust
dir = 0; //changed by bullet's direction
knockback_strength = 1;  // Adjust for desired knockback force

has_local_avoidance = true;
avoid_radius_x = sprite_width;
avoid_radius_y = sprite_height;

avoid_x = 0;
avoid_y = 0;
_dist = 0;

bomb_search_radius = 50;

iframe_backup = 0;