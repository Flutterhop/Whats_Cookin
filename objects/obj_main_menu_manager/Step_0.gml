/// @description Insert description here
// You can write your code in this editor

event_inherited();
if(highlighted >= maxElements){
	highlighted = 0;
}else if(highlighted < 0){
	highlighted = maxElements - 1;
}
active_element = ds_list_find_value(menuElements,highlighted);

highlightArrow.x = active_element.x - (active_element.sprite_width / 1.5);
highlightArrow.y = active_element.y;

if(keyboard_check_pressed(ord("G"))){
	obj_audio_manager.play_sfx(grub_bite)
}