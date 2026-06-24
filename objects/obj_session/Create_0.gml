event_handler = new Event_Handler();
grid = new Map_Grid("Proto_Grid",room_width / 16,room_height / 16,16,16);
prototype();

function prototype(){
	////INIT TILE PATHING DATA BASED ON EXISTING TILEMAP DATA
	////This can be used later
	var tiles = layer_tilemap_get_id("rocks");
	var cell_size = 16; // Set this to size of each tile cell
	var _w = room_width / cell_size;
	var _h = room_height / cell_size;
	for (var i = 0; i < _w; i++;){
		for (var j = 0; j < _h; j++;){
			var tile_x_pos = (i * cell_size) + (cell_size / 2);
			var tile_y_pos = (j * cell_size) + (cell_size / 2);
			var tile = tilemap_get_at_pixel(tiles,tile_x_pos ,tile_y_pos )
			var result = (tile != -1) && (tile != 0);
	        if(result){ // Gets the center position of the tile cell
				mp_grid_add_cell(grid.mp_grid_data, i, j);
			}
		}
    }
	initialize_character_entities();
	var npc1 = new Enemy_Entity(enemy_type.generic,[enemy_trait.Standard],npc_size.medium,grid,5,"Bee",Character_Type.CH_ENEMY_NPC,1,false,obj_npc_bee);
	npc1.spawn_npc(get_screen_center_x() / 2, get_screen_center_y() / 2,"Instances");
	var turret1 = new Defense_Structure("Turret_1",structure_type.Defense,5,false,obj_turret_defense)
	turret1.spawn_entity(400,120,"Instances")
	var player_entity = new Player_Entity(0,5,"Player 0",entity_type.EN_Character,5,false,obj_player);
	player_entity.spawn_entity(get_screen_center_x(), get_screen_center_y(),"Instances")
	var user = new User(0,"Player 0",false,player_entity.instance,"")
	
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
	var apple_inst = instance_create_layer(get_screen_center_x() - 20,get_screen_center_y(),"Instances",obj_apple)
	var apple_01 = new Item_Food(10,
								["Sweet"],
								item_entity_type.Food,
								"Apple",
								entity_type.EN_Item,
								apple_inst)
	apple_inst.item_struct = apple_01;
	
}
