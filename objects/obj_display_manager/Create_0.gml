event_inherited();
randomize();

/// @description Display Properties
ideal_width=480;
ideal_height=270;
zoom=1;
current_zoom = zoom;
max_zoom=1;
display_width=display_get_width();
display_height=display_get_height();

aspect_ratio=display_width/display_height;

shake = false;
shake_time = 0;
shake_magnitude = 0;
shake_fade = 0.25;

//Check for odd numbers
if(ideal_width & 1)
  ideal_width++;
if(ideal_height & 1)
  ideal_height++;
    
//Calculate Max Zoom
max_zoom=floor(display_width/ideal_width);  
  
for(var i=1; i<=room_last; i++)
{
  if(room_exists(i))
  {
    room_set_view(i,0,true,0,0,ideal_width,ideal_height,0,0,ideal_width,ideal_height,0,0,0,0,-1);
    room_set_view_enabled(i,true);
  }
}
scribble_font_bake_outline_and_shadow("fnt_Retro","main",1,1,SCRIBBLE_OUTLINE.NO_OUTLINE,1,false);

scribble_font_bake_outline_and_shadow("fnt_Retro_small","main_sm",1,1,SCRIBBLE_OUTLINE.NO_OUTLINE,1,false);


window_set_size(ideal_width,ideal_height);
display_set_gui_size(ideal_width,ideal_height);
surface_resize(application_surface,ideal_width*zoom,ideal_height*zoom);
pal_swap_init_system(shd_pal_swapper);///this needs to run or palette swapper will not work.
alarm[0]=1; //Sorry.  This line got left out of the tutorial vid.  This will center the window after the initial resizing.
room_goto(room_next(room));

function screenshake(_time, _magnitude, _fade){
	shake = true;
	shake_time = _time;
	shake_magnitude = _magnitude;
	shake_fade = _fade;
}

