if(struct.stun_amount > 0){
	draw_sprite_ext(spr_effect_stun,image_index,x,y,1,1,0,c_white,1);
}
event_inherited()

if(not_null(direction_facing)){
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
}

if(not_null(shadow_sprite)){
	draw_sprite_ext(shadow_sprite,0,x,y+z_position,1,1,0,c_white,1);
}
if(not_null(sprite_index) and sprite_index != -1){
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,1)
}

draw_health()