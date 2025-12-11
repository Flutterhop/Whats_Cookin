/// @description Insert description here
// You can write your code in this editor
if(room == rm_Arena){
	event_user(0);
	if(alarm[0] > 0){
		alarm[0] = -1;
	}
	try{
		if(instance_exists(obj_medkit)){
			var medkit = instance_find(obj_medkit,1);
			instance_destroy(medkit)
		}
	}
	catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
	}
	
}