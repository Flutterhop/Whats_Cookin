event_inherited();

display_value = 0;
draw_pos_x = (get_screen_center_x() * 1.5);
draw_pos_y = (get_screen_center_y() / 1.5);
typist = scribble_typist();
balance_scribble = scribble(display_value);
rate_of_offset = 1;
transaction_display_time = 2; // in seconds
remove_transaction = function(){
	var transactions = struct.pending_transactions;
	if(array_length(transactions) > 0){
		array_delete(transactions,0,1);
	}
}