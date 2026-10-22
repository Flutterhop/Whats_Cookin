if(not_null(struct)){
	if(struct.balance_offset != struct.current_balance){
		if(struct.balance_offset < struct.current_balance){
			display_value = struct.balance_offset + rate_of_offset;
			struct.balance_offset += rate_of_offset;
			draw_pos_x = ((get_screen_center_x() * 1.2) - string_width_scribble_ext(string(display_value),100));
			draw_pos_y = ((get_screen_center_y() * 1.2) - string_height_scribble_ext(string(display_value),100));
			//show_debug_message(string_concat("Offset is now: ",struct.balance_offset))
			return;
		}
		if(struct.balance_offset > struct.current_balance){
			display_value = struct.balance_offset - rate_of_offset;
			struct.balance_offset -= rate_of_offset;
			draw_pos_x = ((get_screen_center_x() * 1.2) - string_width_scribble_ext(string(display_value),100));
			draw_pos_y = ((get_screen_center_y() * 1.2) - string_height_scribble_ext(string(display_value),100));
			//show_debug_message(string_concat("Offset is now: ",struct.balance_offset))
			return;
		}
	}
}