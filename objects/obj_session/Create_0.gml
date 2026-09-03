event_user(0);
event_user(1);

prototype();

function prototype(){
	initialize_item_stats();
	initialize_system_entities();
	initialize_character_stats();
	initialize_structure_stats();
	initialize_structure_entities();
	initialize_character_entities();
	initialize_item_entities();
	
	var character_builder = instance_create_layer(0,0,"System",obj_character_manager);
	var counter_01 = retrieve_entity("counter",global.structure_entities)
	counter_01.spawn_grid_entity(3,3,"Instances")
	
	//var npc1 = retrieve_entity("bee",global.character_entities)
	//npc1.spawn_entity(10,10,"Instances");

	//var turret1 = new Defense_Structure("Turret_1",structure_type.Defense,5,false,obj_str_turret,grid)
	//turret1.spawn_entity(10,7,"Instances")
	

	
	var player_entity = new Player_Character("Player 0",
												obj_player,
												grid,
												true,
												false,
												retrieve_stats("player",global.character_stats),
												"dev",
												0);
	player_entity.spawn_grid_entity(8,7,"Instances")
	var user = new User(0,"Player 0",false,player_entity,"")
	cam_follow(player_entity.instance);
	
	var left_char_sprite 	= new Character_Sprite(character_builder,player_entity,"idle","left")
	var down_char_sprite 	= new Character_Sprite(character_builder,player_entity,"idle","down")
	var up_char_sprite 		= new Character_Sprite(character_builder,player_entity,"idle","up")
	player_entity.instance.character_sprite = left_char_sprite;
	player_entity.instance.down_character_sprite = down_char_sprite;
	player_entity.instance.up_character_sprite = up_char_sprite;
	player_entity.instance.left_character_sprite = left_char_sprite;

	
	
	/*
	event_handler.create_event(ev_type.debug,"Hello world!",ev_priority.low);

	var apple_01 = retrieve_entity("apple",global.item_entities)
	apple_01.spawn_grid_entity(7,7,"Instances")
	
	var apple_02 = retrieve_entity("apple",global.item_entities)
	apple_02.spawn_grid_entity(6,6,"Instances")
	
	var chicken_01 = retrieve_entity("chicken",global.item_entities)
	chicken_01.spawn_grid_entity(5,5,"Instances")
	
	var plate_01 = retrieve_entity("plate",global.item_entities)
	plate_01.spawn_grid_entity(10,12,"Instances")
	
	//var inspector_01 = retrieve_entity("inspector",global.character_entities)
	//inspector_01.spawn_grid_entity(15,10,"Instances")
	
	//var _sq = retrieve_entity("squeebie",global.character_entities)
	//_sq.single_direction = true;
	//_sq.spawn_grid_entity(5,20,"Instances");
	
	//var hunter_01 = retrieve_entity("hunter",global.character_entities)
	//hunter_01.spawn_grid_entity(5,7,"Instances");
	
	var counter = retrieve_entity("counter",global.structure_entities)
	counter.grid_x = 10
	counter.grid_y = 5
	counter.spawn_grid_entity(0,0,"Instances")
	var counter2 = retrieve_entity("counter",global.structure_entities)
	counter2.grid_x = 11
	counter2.grid_y = 6
	counter2.spawn_grid_entity(0,0,"Instances")
	var cuttingboard = retrieve_entity("cuttingboard",global.structure_entities)
	cuttingboard.grid_x = 11
	cuttingboard.grid_y = 5
	cuttingboard.spawn_grid_entity(0,0,"Instances")
	var storage = retrieve_entity("storage",global.structure_entities)
	storage.grid_x = 5
	storage.grid_y = 5
	storage.spawn_grid_entity(0,0,"Instances")
	var turret_01 = retrieve_entity("turret",global.structure_entities)
	turret_01.grid_x = 6
	turret_01.grid_y = 4
	turret_01.spawn_grid_entity(0,0,"Instances")
	
	 * */
	grid.init_mp_grid_data();

	
	
}
