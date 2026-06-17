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
	var npc1 = new NPC(obj_npc,"Test_Guy",1,,5,npc_size.medium,grid,1);
	var npc2 = new NPC(obj_npc,"Test_Guy",1,,5,npc_size.medium,grid,1);
	var npc3 = new NPC(obj_npc,"Test_Guy",1,,5,npc_size.medium,grid,1);
	var npc4 = new NPC(obj_npc,"Test_Guy",1,,5,npc_size.medium,grid,1);

	npc1.spawn_npc(get_screen_center_x() - 20,get_screen_center_y(),"Instances");
	npc2.spawn_npc(get_screen_center_x() - 40,get_screen_center_y(),"Instances");
	npc3.spawn_npc(get_screen_center_x() - 60,get_screen_center_y(),"Instances");
	npc4.spawn_npc(get_screen_center_x() - 80,get_screen_center_y(),"Instances");

	var user_01 = new User(0,"Default",false,new Player(0,0,0,instance_create_layer(get_screen_center_x(),get_screen_center_y(),"Instances",obj_player)),"");
	
	
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
	
}
