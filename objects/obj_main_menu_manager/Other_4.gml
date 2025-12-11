/// @description Insert description here
// You can write your code in this editor

load_settings();
set_default_settings();

if(is_null(game_manager)){
	game_manager = create_if_none(obj_game_manager,"System",x,y);
}
if !audio_is_playing(main_menu_music){
	obj_audio_manager.play_music(main_menu_music, true)
}
num_elements = instance_number(obj_menu_button);

for(var i = 0;i<num_elements;i++){
	var item = instance_find(obj_menu_button,i)
	if (item != 0){
		ds_list_insert(menuElements,i,item);
	}
}
for(var i = 0;i<ds_list_size(menuElements);i++){
	var item = ds_list_find_value(menuElements,i);
	var other_item = 0;
	if(item.index == i){
		//matches position,skip
	}else{
		other_item = ds_list_find_value(menuElements,item.index);
		ds_list_set(menuElements,item.index,item);
		ds_list_set(menuElements,i,other_item);
	}
}
maxElements = ds_list_size(menuElements);

