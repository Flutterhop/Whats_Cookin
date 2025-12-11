/// @description Button Tap

var _gui_mouse_x, _gui_mouse_y;
_gui_mouse_x = event_data[? "guiposX"];
_gui_mouse_y = event_data[? "guiposY"];

if(position_meeting(_gui_mouse_x, _gui_mouse_y, id)){
	interact();	
}

