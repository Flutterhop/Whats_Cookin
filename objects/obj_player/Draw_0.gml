event_inherited();
pal_swap_set(player.character.palette,player.palette_index,false);
///HANDLE BRAMBLE BEHIND PLAYER
if(global.debug){
	if(debug_iframes){
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,get_screen_center_y() * 1.6,"debug iframes are active.",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
	}
	if(iframes){
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,get_screen_center_y() * 1.3,"iframes are active.",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
	}
}
draw_self();
switch(direction_facing){
	case "up":
		image_xscale = 1;

	break;
	case "down":
		image_xscale = 1;

	break;
	case "left":
		image_xscale = 1;

	break;
	case "right":
		image_xscale = -1;

	break;
}
///HANDLE SHIELD EFFECTS

if(shield_bullet > 0){
	
	draw_sprite_ext(spr_shield_bullet,bullet_shield_frame,x,y,1,1,0,c_white,1);
	if(alarm[3] <= 0){ alarm[3] = shield_effect_timer;}
	if(bullet_shield_frame >= sprite_get_number(spr_shield_bullet)){
		bullet_shield_frame = 0;
	}
}
if(draw_reflect){
	bullet_reflect_time--;
	draw_sprite_ext(reflect_sprite,bullet_reflect_time,x,y,1,1,0,c_white,1);
	if(bullet_reflect_time <= 0){
		draw_reflect = false;
	}
}
if(shield_explosion > 0){
	draw_sprite_ext(spr_shield_explosion,explosion_shield_frame,x,y,1,1,0,c_white,1);
	if(alarm[3] <= 0){ alarm[3] = shield_effect_timer;}
	if(explosion_shield_frame >= sprite_get_number(spr_shield_explosion)){
		explosion_shield_frame = 0;
	}
}

if(global.debug && global.debug_setting == debug_type.player_debug){
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fnt_normal);
	if(player != 0){
		draw_text(x - 40, y,string_concat("up: ",player.up));
		draw_text(x - 40, y + 15,string_concat("down: ",player.down));
		draw_text(x - 40, y + 30,string_concat("left: ",player.left));
		draw_text(x - 40, y + 45,string_concat("right: ",player.right));

		draw_text(x - 40, y + 60,string_concat("action_1: ",player.action_1));
		draw_text(x - 40, y + 75,string_concat("action_2: ",player.action_2));
		
		draw_text(x + 40, y,string_concat("face: ",face));
		draw_text(x + 40, y + 15,string_concat("player_direction: ",player_direction));
		draw_text(x + 40, y + 30,string_concat("holdDirection: ",holdDirection));
		draw_text(x + 40, y + 45,string_concat("xaxis: ",xaxis));
		draw_text(x + 40, y + 60,string_concat("yaxis: ",yaxis));

		draw_text(x + 40, y + 75,string_concat("Base Gain: ",obj_audio_manager.base_gain));
		draw_text(x + 40, y + 90,string_concat("Current Gain: ",obj_audio_manager.currentMusicGain));
		draw_text(x + 40, y + 105,string_concat("Music Group Gain: ",obj_audio_manager.musicVolume));
		draw_text(x + 40, y + 120,string_concat("depth: ",depth));
		draw_text(x + 40, y + 140,string_concat("palette_index ",player.palette_index));
	}

}

// Ensure a valid sprite exists

if (damage_timer > 0 && (damage_timer mod 4) < 2) {
    gpu_set_blendmode(bm_add); // Use GPU blend mode for brightness
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, 0.4); // Reduce brightness effect
    gpu_set_blendmode(bm_normal);
} else {
    draw_self(); // Normal rendering
}
if(shield_bramble > 0){
	if(alarm[11] <= 0){
		alarm[11] = bramble_effect_timer;
	}
}
pal_swap_reset();