direction = InputDirection(direction,INPUT_CLUSTER.NAVIGATION);
face = direction / 45
motion_set(direction,InputDistance(INPUT_CLUSTER.NAVIGATION,0) * move_speed);
move_wrap(true,true,sprite_width);
if(speed == 0){image_index = 0;}else if(speed > 0 && speed < 1){image_index++}else{image_speed = speed;}

interpret_controls();

determine_sprite();

