/// @description Insert description here
// You can write your code in this editor
if(not_null(grid)){
	if(not_null(grid.grid_data)){
		for (var i = 0; i < grid.width; i++;){
			for (var j = 0; j < grid.height; j++;){
				var cell = ds_grid_get(grid.grid_data,i,j);
				var tile_bottom_x_pos = (i * grid.cell_width)
				var tile_bottom_y_pos = (j * grid.cell_height)
				var tile_top_x_pos = (i * grid.cell_width) + (grid.cell_width);
				var tile_top_y_pos = (j * grid.cell_height) + (grid.cell_height);
				//draw_rectangle_colour(tile_top_x_pos,tile_top_y_pos,tile_bottom_x_pos,tile_bottom_y_pos,c_blue,c_blue,c_blue,c_blue,true);
				//scribble(string_concat(cell.x_pos)).starting_format("main_sm").draw(cell.x_pos - 10,cell.y_pos - 20)
				//scribble(string_concat(cell.y_pos)).starting_format("main_sm").draw(cell.x_pos - 10,cell.y_pos - 10)
			}
		}
	}
	draw_set_alpha(0.3);
	mp_grid_draw(grid.mp_grid_data);
	draw_set_alpha(1);
	
}