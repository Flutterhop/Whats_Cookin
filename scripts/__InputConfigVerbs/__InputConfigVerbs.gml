function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
        ACTION_1,
        ACTION_2,
        ACTION_3,
        ACTION_4,
        PAUSE,
		DEBUG,
		DEBUG_F1,
		DEBUG_F2,
		DEBUG_F3,
		DEBUG_F4,
		DEBUG_F5,
		DEBUG_F6,
		DEBUG_F7,
		DEBUG_F8,
		DEBUG_F9	
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION
    }
    InputDefineVerb(INPUT_VERB.DEBUG,			"debug",		[vk_home,vk_pageup],undefined)
	InputDefineVerb(INPUT_VERB.DEBUG_F1,		"debug_f1",		[vk_f1],undefined)
	InputDefineVerb(INPUT_VERB.DEBUG_F2,		"debug_f2",		[vk_f2],undefined)
	InputDefineVerb(INPUT_VERB.DEBUG_F3,		"debug_f3",		[vk_f3],undefined)
	InputDefineVerb(INPUT_VERB.DEBUG_F4,		"debug_f4",		[vk_f4],undefined)
	InputDefineVerb(INPUT_VERB.DEBUG_F5,		"debug_f5",		[vk_f5],undefined)
	InputDefineVerb(INPUT_VERB.DEBUG_F6,		"debug_f6",		[vk_f6],undefined)
	InputDefineVerb(INPUT_VERB.DEBUG_F7,		"debug_f7",		[vk_f7],undefined)
	InputDefineVerb(INPUT_VERB.DEBUG_F8,		"debug_f8",		[vk_f8],undefined)
	InputDefineVerb(INPUT_VERB.DEBUG_F9,		"debug_f9",		[vk_f9],undefined)
	
    if (not INPUT_ON_SWITCH)
    {
        InputDefineVerb(INPUT_VERB.UP,			"up",			[vk_up],				[-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,		"down",			[vk_down],			[ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,		"left",			[vk_left],			[-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,   	"right",		[vk_right],			[ gp_axislh, gp_padr]);
        InputDefineVerb(INPUT_VERB.ACTION_1,	"action_1",		vk_space,            gp_face1);
        InputDefineVerb(INPUT_VERB.ACTION_2,	"action_2",     ["E"],				gp_face2);
        InputDefineVerb(INPUT_VERB.ACTION_3,	"action_3",		vk_enter,            gp_face3);
        InputDefineVerb(INPUT_VERB.ACTION_4,	"action_4",     vk_shift,            gp_face4);
        InputDefineVerb(INPUT_VERB.PAUSE,		"pause",		vk_escape,           gp_start);
    }
    else //Flip A/B over on Switch
    {
        InputDefineVerb(INPUT_VERB.UP,			"up",         	[vk_up],				[-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,		"down",       	[vk_down],			[ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,    	"left",			[vk_left],			[-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,		"right",		[vk_right],			[ gp_axislh, gp_padr]);
        InputDefineVerb(INPUT_VERB.ACTION_1,	"action_1",     ["E"],				gp_face1);
        InputDefineVerb(INPUT_VERB.ACTION_2,	"action_2",     vk_space,			gp_face2);
        InputDefineVerb(INPUT_VERB.ACTION_3,	"action_3",     vk_enter,			gp_face3);
        InputDefineVerb(INPUT_VERB.ACTION_4,	"action_4",		vk_shift,			gp_face4);
        InputDefineVerb(INPUT_VERB.PAUSE,		"pause",		vk_escape,			gp_start);
    }
	
	
  
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}
