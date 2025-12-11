/// @description Insert description here
// You can write your code in this editor


if(instance_exists(obj_pause_menu)){
	interpret_controls();
}

try{

	read_all_input();
	listen_for_input();

}catch(_exception){
	show_debug_message(_exception.message);
	show_debug_message(_exception.longMessage);
	show_debug_message(_exception.script);
	show_debug_message(_exception.stacktrace);
}