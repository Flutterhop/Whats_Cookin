event_inherited()

draw_self();
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

if(not_null(held_item)){
	if(not_null(held_item.struct.item_sprite)){
		draw_sprite_ext(held_item.struct.item_sprite,held_item.image_index,x,y - 2,.5,.5,0,c_white,1);
	}
}
var interact_coord = get_interact_shape(direction);

var x_pos = ((interact_coord[0] + x) + (interact_coord[2] + x))/2
var y_pos = ((interact_coord[1] + y) + (interact_coord[3] + y))/2
draw_rectangle_colour(x + interact_coord[0],y + interact_coord[1],x + interact_coord[2],y + interact_coord[3],c_black,c_black,c_black,c_black,true)
draw_circle_colour(x_pos,y_pos,2,c_red,c_red,true)