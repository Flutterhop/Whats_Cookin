event_inherited();

player_speed = 1.4;
player_direction = 0;
direction_facing = "left";
direction_moving = dir
credits = 0;
item_list = ds_list_create();
potential_rewards = ds_list_create();
is_shopping = false;

//These represent whether the player is within the bounds of each direction.
x_rightInBounds = true; 
x_leftInBounds = true;
y_downInBounds = true;
y_upInBounds = true;
xr_buffer = 20;
xl_buffer = 20;
yt_buffer = 16;
yb_buffer = 80;

xaxis = 0;
yaxis = 0;
horizontal_axis = 0;
vertical_axis = 0;
up_num = 0;
down_num = 0;
left_num = 0;
right_num = 0;

bomb_bar = "";
bomb_shrapnel = false;
shrapnel_upgraded = false;
bomb_lure = false;
bomb_remote = false;
bomb_toggle = true; //to do with bomb_remote, leave as true
bombDamageValue = 10;
bomb_max = 15;
bomb_start = 3;
bomb_current = bomb_start;

//Health Vars
health_bar = "";
base_hp = 5;
hp_increment = 5;
hp_start = 5;
hp_current = hp_start;
damage_timer = 0;
dead = false;

//Shield Vars
shield_bramble = 0;
shield_bullet = 0;
bullet_shield_frame = 0;
shield_explosion = 0;
explosion_shield_frame = 0;
bramble_effect_timer = 20;
shield_effect_timer = 30;
draw_reflect = false;
bullet_reflect_time = sprite_get_number(reflect_sprite);

//Ranged Vars
bullet_x = 0;
bullet_y = 0;
gunCooldown = true;
holdDirection = false;
shootDirection = dir;
bullet_speed = 5;
shot_speed = 20;
shot_power = 1;
bullets_upgraded = false;
shot_ricochet = false;
shot_split = false;
shot_split_three = false;

//Melee Vars
melee_x = 0;
melee_y = 0;
melee_width = 5
melee_height = 20
meleeCooldown = true;
melee_speed = 5;
melee_power = 3;

//Dash Vars
dash = false;
player_is_dashing = false;
dash_damage = 5;
dash_frames = 20;
dash_cooldown = 30;
dash_speed = 4;
dash_on_cooldown = false;
direction_locked = false;

//for dash effects
dash_effect_frequency = 0;
dash_blend_factor = 0;

//for "iframes" between rounds
round_ended = false;
effect_reset = true;

//the mirror
mirror = false;
mirror_instance = 0;
mirror_hp_start = 20;
mirror_hp_current = 20;
initial_position_set = false
player_initial_x = x;
player_initial_y = y;
offset_x = x - player_initial_x;
offset_y = y - player_initial_y;

medkit_time = 0;

if(player.weapon == weapon_type.dagger){
	knockback_strength = 3
	friction_factor = 0.4
}else{
	knockback_strength = 1
}