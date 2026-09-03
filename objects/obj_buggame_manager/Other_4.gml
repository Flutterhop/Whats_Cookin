
if(room == rm_Arena_02){
	adventure_manager = instance_find(obj_adventure_manager,0);
}
if(room == rm_Arena){
	if(is_null(shop_listener)){
		
		shop_listener = create_if_none(obj_shop_listener,"Shop",0,0);
	}
}
