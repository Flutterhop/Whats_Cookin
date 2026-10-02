event_user(0);
event_user(1);

prototype();

function prototype(){
	initialize_system_entities();
	initialize_item_stats();
	initialize_character_stats();
	initialize_environment_stats();
	initialize_environment_entities();
	initialize_structure_stats();
	initialize_structure_entities();
	initialize_character_entities();
	initialize_item_entities();
	
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
												0
												);
	player_entity.spawn_grid_entity(8,7,"Instances")
	var user = new User(0,"Player 0",false,player_entity,"")
	cam_follow(player_entity.instance);

	
	var catapult_01 = retrieve_entity("catapult",global.structure_entities)
	catapult_01.spawn_grid_entity(7,7,"Instances")
	var turret_01 = retrieve_entity("turret",global.structure_entities)
	turret_01.spawn_grid_entity(4,5,"Instances")
	//var hunter_02 = retrieve_entity("hunter",global.character_entities)
	//hunter_02.spawn_grid_entity(5,7,"Instances");
	//var hunter_03 = retrieve_entity("hunter",global.character_entities)
	//hunter_03.spawn_grid_entity(1,1,"Instances");
	//var hunter_04 = retrieve_entity("hunter",global.character_entities)
	//hunter_04.spawn_grid_entity(12,7,"Instances");
	//var hunter_05 = retrieve_entity("hunter",global.character_entities)
	//hunter_05.spawn_grid_entity(3,2,"Instances");
	
	//event_handler.create_event(ev_type.debug,"Hello world!",ev_priority.low);

	var apple_01 = retrieve_entity("apple",global.item_entities)
	apple_01.spawn_grid_entity(7,7,"Instances")
	
	var apple_02 = retrieve_entity("apple",global.item_entities)
	apple_02.spawn_grid_entity(6,6,"Instances")
	
	var chicken_01 = retrieve_entity("chicken",global.item_entities)
	chicken_01.spawn_grid_entity(5,5,"Instances")
	
	var plate_01 = retrieve_entity("plate",global.item_entities)
	plate_01.spawn_grid_entity(5,9,"Instances")
	
	var pan_1 = retrieve_entity("fryingpan",global.item_entities)
	pan_1.spawn_grid_entity(4,13,"Instances")
	
	var beef_1 = retrieve_entity("beef",global.item_entities)
	beef_1.spawn_grid_entity(5,8,"Instances")
	//var inspector_01 = retrieve_entity("inspector",global.character_entities)
	//inspector_01.spawn_grid_entity(15,10,"Instances")
	
	//var _sq = retrieve_entity("squeebie",global.character_entities)
	//_sq.single_direction = true;
	//_sq.spawn_grid_entity(5,20,"Instances");
	var soupling_1 = retrieve_entity("soupling",global.character_entities)
	soupling_1.spawn_grid_entity(2,1,"Instances")

	
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
	
	var builder_listener = retrieve_entity("builderlistener",global.system_entities);
	builder_listener.spawn_entity(0,0,"System");
	grid.init_mp_grid_data();

	
	
}
