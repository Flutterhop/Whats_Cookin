if(live_call())return live_result;
draw_sprite_ext(type_window,0,get_screen_center_x(),get_screen_center_y(),1,1,0,c_white,1);
//////DRAW TEXT BOX
draw_set_font(fnt_Retro_typer);

draw_set_color(c_black);
var text_box_x = sprite_get_width(type_window) / 4.3;
var text_box_y = sprite_get_height(type_window) / 6
draw_rectangle( text_box_x,
				text_box_y,
				sprite_get_width(type_window) - 110, 
				sprite_get_height(type_window) / 3.7,
				false);
scribble("[fnt_Retro_typer]" + input_string).draw(text_box_x,text_box_y);
var text_cursor_x = text_box_x + 2;
text_cursor_x += (string_width(input_string))
draw_set_color(c_white);
draw_rectangle(text_cursor_x,
				text_box_y + 24,
				text_cursor_x + 15,
				text_box_y + 24,
				false);
for(var i = 0;i < array_length(type_grid);i++){
	var current_row = type_grid[i];
	var prev_x = 0;
	for(var j = 0; j < array_length(type_grid[i]);j++){
		var current_item = type_grid[i][j];
		if(i == 4){
			///prev_element.x + prev_element.sprite_width + temp_shop.menu_element_buffer;
			draw_set_font(fnt_Retro);
			var char_width = string_width(current_item);
			var char_height = string_height(current_item);
			var x_pos = (get_screen_center_x() - (sprite_get_width(type_window) / 3.5));///Starting pos
			var previous_item = 0;
			var prev_width = 0;
			if(j != 0){
				previous_item = type_grid[i][j - 1];
				prev_width = string_width(previous_item); 
				prev_x = prev_x + prev_width + 10;
			}
			if(not_null(previous_item)){
				x_pos += prev_x//add buffer and multiplier for each item
				
			}else{
				
			}
			var y_pos = (get_screen_center_y()- sprite_get_height(type_window)/5) + (i * 30)
			scribble("[fnt_Retro]" + current_item).draw(x_pos,y_pos);
			if(type_grid[i][j] == type_grid[highlight_index_x][highlight_index_y]){
				/*draw_set_color(c_white);
				draw_set_alpha(.8);
				draw_rectangle(x_pos,
								y_pos,
								x_pos + char_width,
								y_pos + char_height,
								false);
				draw_set_alpha(1);
				*/
				core_draw_highlight(current_item,1,x_pos,y_pos,x_pos + char_width,y_pos + char_height);
			}
		}else{
			draw_set_font(fnt_Retro_typer);
			var x_pos = (get_screen_center_x() - sprite_get_width(type_window) /3.5) + (j * 20)
			var y_pos = (get_screen_center_y()- sprite_get_height(type_window)/5) + (i * 30)
			var char_width = string_width(current_item);
			var char_height = string_height(current_item);
			scribble("[fnt_Retro_typer]" + current_item).draw(x_pos,y_pos);
			if(type_grid[i][j] == type_grid[highlight_index_x][highlight_index_y]){
				/*draw_set_color(c_white);
				draw_set_alpha(.8);
				draw_rectangle(x_pos,
								y_pos,
								x_pos + char_width,
								y_pos + char_height,
								false);
				draw_set_alpha(1);
				*/
				core_draw_highlight(current_item,1,x_pos,y_pos,x_pos + char_width,y_pos + char_height);
			}
		}

	}
}
draw_flush();


