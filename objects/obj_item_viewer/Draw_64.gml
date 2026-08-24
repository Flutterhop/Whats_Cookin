/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
draw_self();
if(not_null(active_item)){
	draw_sprite_ext(active_item.struct.item_sprite,0,x,y,1,2,0,c_white,1);
}
