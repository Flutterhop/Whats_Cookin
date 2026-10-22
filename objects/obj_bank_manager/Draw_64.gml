
//balance_scribble.starting_format("main",c_white)
//balance_scribble.draw(draw_pos_x,draw_pos_y);
scribble(display_value).starting_format("main_sm").draw(draw_pos_x,draw_pos_y);
if(not_null(struct)){
	var num_transactions = array_length(struct.pending_transactions);
	if(num_transactions > 0){
		for(var i = 0;i < num_transactions;i++){
			var current_transaction = struct.pending_transactions[i];
			var draw_y = (draw_pos_y + 10 + (10 * i)) - current_transaction[2];
			current_transaction[2] += .2;
			if(current_transaction[2] > 10){
				current_transaction[3] -= .01;
			}
			scribble(string_concat(current_transaction[0]," ",current_transaction[1])).starting_format("pixel_op_sm").blend(c_white,current_transaction[3]).draw(draw_pos_x,draw_y);
			
		}
	}
}
//scribble(string_concat(string(cell.cell_content,"occupied"))).starting_format("main_sm").draw(cell.x_pos - 10,cell.y_pos - 20)