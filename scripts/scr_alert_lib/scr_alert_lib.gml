
////@description Takes input options as an array and matching callback functions in a separate array to create a pop-up window.
////@function Alert
////@param {string} Message to Display in pop-up window
////@param {array} Input_options options to display as buttons
////@param {ref} Source source of the creation of this alert
////@param {asset} ObjectType of alert. Default obj_pop_up will handle most yes/no inputs.
////@param {array} Callbacks callbacks for each text option to do something once an option is selected
////@param {array} Callback_args arguements for callback 
////@param {asset} Sprite to use for window.
function Alert(new_message, new_input_options,new_source,new_alert_type,new_input_callbacks = [],new_callback_args = [], new_window = "", new_button_sprite = "",new_pos_x = 0, new_pos_y = 0) constructor{
	alert_message	= new_message;
	input_options	= new_input_options;
	source			= new_source;
	alert_type		= new_alert_type;
	input_callbacks = new_input_callbacks;
	callback_args	= new_callback_args;
	window			= new_window;
	button_sprite	= new_button_sprite;
	pos_x			= new_pos_x;
	pos_y			= new_pos_y;
	
	alert_instance = "";
	
	if(window == ""){
		window = spr_default_window;
	}
	if(button_sprite == ""){
		button_sprite = spr_default_button;
	}
	
	static create_alert = function(_player){
		if(pos_x == 0 && pos_y == 0){
			pos_x = get_screen_center_x();
			pos_y = get_screen_center_y();
		
		}
		var struct = self;
		alert_instance = instance_create_layer(pos_x,pos_y,"System",alert_type,{message_struct : struct,
																				player : _player});
		alert_instance.has_priority = true
	}
	
	static end_alert = function(time_to_kill = 0){
		if(not_null(time_to_kill) && alert_instance.alarm[0] <= 0){
			alert_instance.alarm[0] = time_to_kill
		}else{
			alert_instance.alarm[0] = 1;
		}
	}
}