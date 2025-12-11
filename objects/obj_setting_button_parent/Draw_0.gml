/// @description Insert description here
// You can write your code in this editor

draw_flush();
draw_self();
draw_set_font(fnt_arcade);
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
text_w = string_width(button_text);
text_h = string_height(button_text);
text_w = text_w * text_size_mod;
text_h = text_h * text_size_mod;
if(active){
	draw_set_alpha(alpha_value);
	draw_rectangle_color(x - 105,y - text_h /1.8,x + 100,(y + 5) + text_h / 1.8,c_white,c_white,c_white,c_white,false);	
	draw_set_alpha(alpha_max);
}

draw_text_ext_transformed_color(x - 100,y,button_text,10,500,text_size_mod,text_size_mod,0,c_white,c_white,c_white,c_white,1);
draw_text_ext_transformed_color(x + 75,y,setting,10,500,text_size_mod,text_size_mod,0,c_white,c_white,c_white,c_white,1);


