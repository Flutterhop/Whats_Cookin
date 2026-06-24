event_inherited()
draw_set_alpha(.5);
//mp_grid_draw(character_struct.grid.mp_grid_data);
if(path_index != -1){
	draw_path(path_index,x,y,true);
}

draw_set_alpha(1);
draw_self();