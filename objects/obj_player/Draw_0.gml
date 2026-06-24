event_inherited()

draw_self();
if(not_null(struct)){
	switch(struct.direction_facing){
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

if(not_null(held_item)){
	if(not_null(held_item.item_struct.item_sprite)){
		draw_sprite_ext(held_item.item_struct.item_sprite,0,x,y - 2,.5,.5,0,c_white,1);
	}
}