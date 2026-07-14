event_user(0);
event_user(1);

prototype();

function prototype(){
	initialize_structure_entities();
	initialize_character_entities();
	initialize_item_entities();
	var counter_01 = new Kitchen_Structure("counter_01",entity_type.EN_Structure,1,true,obj_str_counter,3,3,"");
	grid.insert_item_at(counter_01.grid_x,counter_01.grid_y,counter_01)
	

	var npc1 = new Enemy_Entity("Bee",Character_Type.CH_ENEMY_NPC,5,false,obj_npc_bee,0.5,npc_size.medium,grid,enemy_type.generic,[enemy_trait.Standard]);

	npc1.spawn_npc(get_screen_center_x() / 2, get_screen_center_y() / 2,"Instances");
	var turret1 = new Defense_Structure("Turret_1",structure_type.Defense,5,false,obj_str_turret)
	turret1.spawn_entity(400,120,"Instances")
	var player_entity = new Player_Entity("Player 0",entity_type.EN_Character,5,false,obj_player,2,0);
	player_entity.spawn_entity(get_screen_center_x(), get_screen_center_y(),"Instances")
	var user = new User(0,"Player 0",false,player_entity,"")
	cam_follow(player_entity.instance);
	
	event_handler.create_event(ev_type.debug,"Hello world!",ev_priority.low);
	event_handler.create_event(ev_type.combat,"Here is another event!",ev_priority.standard);
	event_handler.create_event(ev_type.gather,"Here is yet another event!",ev_priority.high);
	event_handler.create_event(ev_type.combat,"Somebody got hit for 50 health!",ev_priority.standard);
	event_handler.create_event(ev_type.gather,"Loaded audio files...",ev_priority.high);
	
	event_handler.create_event(ev_type.gather,"Hey look a banana",ev_priority.standard);
	event_handler.create_event(ev_type.craft,"Meal 'tomato soup' has been crafted! ",ev_priority.high);
	event_handler.create_event(ev_type.gather,"tower_02 took 3 damage",ev_priority.low);
	event_handler.create_event(ev_type.combat,"Player 'sandy' hit by 'rat' for 5 hitpoints",ev_priority.standard);
	event_handler.create_event(ev_type.debug,"Loading next level...",ev_priority.low);
	
	event_handler.create_event(ev_type.gather,"Hey look a banana",ev_priority.standard);
	event_handler.create_event(ev_type.craft,"Meal 'tomato soup' has been crafted! ",ev_priority.high);
	event_handler.create_event(ev_type.gather,"tower_02 took 3 damage",ev_priority.low);
	event_handler.create_event(ev_type.combat,"Player 'sandy' hit by 'rat' for 5 hitpoints",ev_priority.standard);
	event_handler.create_event(ev_type.debug,"Loading next level...",ev_priority.low);
	var apple_01 = new Food_Ingredient("Apple",
								entity_type.EN_Item,
								3,
								false,
								obj_apple,
								item_entity_type.Food,
								spr_item_apple,
								spr_item_apple,
								10,
								["Sweet"],
								false,
								2
								)
	apple_01.spawn_entity(get_screen_center_x() - 20,get_screen_center_y(),"Instances")
	grid.init_mp_grid_data();

	
	
}
