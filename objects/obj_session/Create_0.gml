event_user(0);
event_user(1);

prototype();

function prototype(){
	initialize_structure_entities();
	initialize_character_entities();
	initialize_item_entities();
	var counter_01 = new Kitchen_Structure("counter_01",entity_type.EN_Structure,1,true,obj_str_counter,grid,3,3,"");
	counter_01.spawn_entity(3,3,"Instances")
	
	//var npc1 = retrieve_entity("bee",global.character_entities)
	//npc1.spawn_entity(10,10,"Instances");

	
	var turret1 = new Defense_Structure("Turret_1",structure_type.Defense,5,false,obj_str_turret,grid)
	turret1.spawn_entity(10,7,"Instances")
	
	var player_entity = new Player_Character("Player 0",entity_type.EN_Character,5,false,obj_player,grid,2,"dev",0);
	player_entity.spawn_entity(8,7,"Instances")
	var user = new User(0,"Player 0",false,player_entity,"")
	cam_follow(player_entity.instance);
	
	event_handler.create_event(ev_type.debug,"Hello world!",ev_priority.low);

	var apple_01 = retrieve_entity("apple",global.item_entities)	
	apple_01.spawn_entity(7,7,"Instances")
	
	var apple_02 = retrieve_entity("apple",global.item_entities)
	apple_02.spawn_entity(6,6,"Instances")
	
	var inspector_01 = retrieve_entity("inspector",global.character_entities)
	inspector_01.spawn_entity(15,10,"Instances")
	
	var _sq = retrieve_entity("squeebie",global.character_entities)
	_sq.single_direction = true;
	_sq.spawn_entity(5,20,"Instances");
	
	var hunter_01 = retrieve_entity("hunter",global.character_entities)
	hunter_01.spawn_entity(5,7,"Instances");
	
	var counter = retrieve_entity("counter",global.structure_entities)
	counter.grid_x = 10
	counter.grid_y = 5
	counter.spawn_entity(0,0,"Instances")
	var storage = retrieve_entity("storage",global.structure_entities)
	storage.grid_x = 5
	storage.grid_y = 5
	storage.spawn_entity(0,0,"Instances")
	
	grid.init_mp_grid_data();

	
	
}
