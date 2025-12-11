event_inherited();
part_map = ds_map_create();
//Acid
part_acid = part_type_create();
part_type_sprite(part_acid, spr_acid_attack_idle, false, true, false)
part_type_size(part_acid, 1, 1, 0, 0);
part_type_scale(part_acid, 0.5, 0.5);
part_type_speed(part_acid, 2, 10, 0, 0);
part_type_direction(part_acid, 50, 140, 0, 0);
part_type_gravity(part_acid, 0.3, 270);
part_type_orientation(part_acid, 0, 0, 0, 0, false);
part_type_colour3(part_acid, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(part_acid, 1, 1, 1);
part_type_blend(part_acid, false);
part_type_life(part_acid, 10, 15);
ds_map_add(part_map,"acid",part_acid);
//Heart
part_heart = part_type_create();
part_type_sprite(part_heart, spr_part_heart, false, true, false)
part_type_size(part_heart, 1, 2, 0, 0.2);
part_type_scale(part_heart, 1, 1);
part_type_speed(part_heart, 0.5, 1, 0, 0);
part_type_direction(part_heart, 80, 100, 0, 1);
part_type_gravity(part_heart, 0.1, 90);
part_type_orientation(part_heart, 0, 0, 0, 0, false);
part_type_colour3(part_heart, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(part_heart, 1, 1, 1);
part_type_blend(part_heart, false);
part_type_life(part_heart, 15, 25);
ds_map_add(part_map,"heart",part_heart);

//bullet_impact
part_bullet_impact = part_type_create();
part_type_sprite(part_bullet_impact, spr_part_bullet_impact, true, true, false);
part_type_size(part_bullet_impact, 1, 1, 0, 0);
part_type_scale(part_bullet_impact, 1, 1);
part_type_speed(part_bullet_impact, 0, 0, 0, 0);
part_type_direction(part_bullet_impact, 0, 0, 0, 0);
part_type_gravity(part_bullet_impact, 0, 270);
part_type_orientation(part_bullet_impact, 0, 0, 0, 0, false);
part_type_colour3(part_bullet_impact, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(part_bullet_impact, 1, 1, 1);
part_type_blend(part_bullet_impact, false);
part_type_life(part_bullet_impact, 10, 20);
ds_map_add(part_map,"bullet_impact",part_bullet_impact);

part_dust = part_type_create();
part_type_shape(part_dust, pt_shape_pixel);       // tiny specks
part_type_size(part_dust, 0.5, 1, 0, 0);          // random small sizes
part_type_color2(part_dust, make_color_rgb(140,90,50), make_color_rgb(200,150,100));
part_type_alpha2(part_dust, 0.8, 0);             // fade out
part_type_speed(part_dust, 0.2, 1, 0, 0);        // gentle drift
part_type_direction(part_dust, 0, 360, 0, 10);   // random directions
part_type_gravity(part_dust, 0.05, 270);         // slight downward settle
part_type_life(part_dust, 30, 60);              // frames of life
ds_map_add(part_map,"dust",part_dust);

//shield_bramble
part_shield_bramble = part_type_create();
part_type_sprite(part_shield_bramble, spr_part_shield_bramble, true, true, false);
part_type_size(part_shield_bramble, 1, 1, 0, 0);
part_type_scale(part_shield_bramble, 1, 1);
part_type_speed(part_shield_bramble, 0, 0, 0, 0);
part_type_direction(part_shield_bramble, 80, 100, 0, 0);
part_type_gravity(part_shield_bramble, 0, 270);
part_type_orientation(part_shield_bramble, 0, 0, 0, 0, false);
part_type_colour3(part_shield_bramble, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(part_shield_bramble, 1, 1, 1);
part_type_blend(part_shield_bramble, false);
part_type_life(part_shield_bramble, 40, 40);
ds_map_add(part_map,"shield_bramble",part_shield_bramble);


