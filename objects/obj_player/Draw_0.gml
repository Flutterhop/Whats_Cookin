event_inherited()


if(not_null(equipment_sprite)){
    draw_sprite_ext(equipment_sprite,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
}
if(not_null(struct.held_entity)){
	if(not_null(struct.held_entity.struct.item_sprite)){
		draw_sprite_ext(struct.held_entity.struct.item_sprite,struct.held_entity.image_index,struct.held_entity.x,struct.held_entity.y - 10,1,1,0,c_white,1);
	}
}
var interact_coord = get_interact_shape(direction);

var x_pos = ((interact_coord[0] + x) + (interact_coord[2] + x))/2
var y_pos = ((interact_coord[1] + y) + (interact_coord[3] + y))/2
draw_rectangle_colour(x + interact_coord[0],y + interact_coord[1],x + interact_coord[2],y + interact_coord[3],c_black,c_black,c_black,c_black,true)
draw_circle_colour(x_pos,y_pos,2,c_red,c_red,true)


