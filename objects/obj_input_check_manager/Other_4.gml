/// @description Insert description here
// You can write your code in this editor
if(room == rm_Start_input_check){
	enable_all_input();
	InputPartySetJoin(true);
	InputPartySetParams(INPUT_VERB.ACCEPT,1,INPUT_MAX_PLAYERS,true,undefined,undefined,false);
}
