function type_init_grid(){
	type_grid[0][0] = "A";
	type_grid[0][1] = "B";
	type_grid[0][2] = "C";
	type_grid[0][3] = "D";
	type_grid[0][4] = "E";
	type_grid[0][5] = "F";
	type_grid[0][6] = "G";
	type_grid[0][7] = "H";
	type_grid[0][8] = "I";
	type_grid[0][9] = "J";
	type_grid[1][0] = "K";
	type_grid[1][1] = "L";
	type_grid[1][2] = "M";
	type_grid[1][3] = "N";
	type_grid[1][4] = "O";
	type_grid[1][5] = "P";
	type_grid[1][6] = "Q";
	type_grid[1][7] = "R";
	type_grid[1][8] = "S";
	type_grid[1][9] = "T";
	type_grid[2][0] = "U";
	type_grid[2][1] = "V";
	type_grid[2][2] = "W";
	type_grid[2][3] = "X";
	type_grid[2][4] = "Y";
	type_grid[2][5] = "Z";

	type_grid[3][0] = "0";
	type_grid[3][1] = "1";
	type_grid[3][2] = "2";
	type_grid[3][3] = "3";
	type_grid[3][4] = "4";
	type_grid[3][5] = "5";
	type_grid[3][6] = "6";
	type_grid[3][7] = "7";
	type_grid[3][8] = "8";
	type_grid[3][9] = "9";
	
	type_grid[4][0] = "Space";
	type_grid[4][1] = "Backspace";
	type_grid[4][2] = "Submit";

}

function type_confirm(){
	var user = find_player_user(player);
	user.set_user_name(message_struct.source.input_string);
	message_struct.end_alert();
	
}

function type_deny(){
	var deny = 0;


}