/// @description player death

instance_create_depth(x, y,-1000,obj_player_explosion);
visible = false;
player.input_allowed = true;
instance_destroy(id);
