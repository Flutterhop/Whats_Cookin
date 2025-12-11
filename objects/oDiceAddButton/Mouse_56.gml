/// @description Insert description here
// You can write your code in this editor

activeCam = camera_get_active();

vx = camera_get_view_width(activeCam) / 2;
vy = camera_get_view_height(activeCam) / 2;



if(position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)){
	
	if(array_length(oGameManager.numPickers) == 0){
	
		newPicker = instance_create_depth(vx,vy,-100,oDicePicker);
		array_insert(oGameManager.numPickers,0,newPicker);
	}
	image_index = 0;
	show_debug_message("Add Die.");
	//Get Length of Array
	var length = array_length(oDiceBag.diceList);
	show_debug_message("Dice array length: " + string(length));
	if(length == 0){
		xPos = oDiceBag.x;
	}else{
		xPos = oDiceBag.x + (length * 80);
	}	
	//Add Die
	var die = instance_create_layer(xPos,oDiceBag.y,"DiceUI",oD4WGeriatricUI);
	//We'll add a D6 to start.
	array_insert(oDiceBag.diceList,length,die);
	oDiceBag.setActiveDie(die);
	show_debug_message("Dice array: " + string(oDiceBag.diceList));
	
	
}
















