/// @description Insert description here
// You can write your code in this editor

menuElements = ds_list_create();
highlighted = 0;
highlightArrow = obj_arrow;
active_element = "";
num_elements = 0;
maxElements = 0;

game_manager = instance_find(obj_game_manager,0);