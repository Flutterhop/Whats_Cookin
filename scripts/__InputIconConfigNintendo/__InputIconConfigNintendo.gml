// Feather disable all

////////////////
//            //
//  Nintendo  //
//            //
////////////////

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_face1, tile_0005); //B
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_face2, tile_0004); //A
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_face3, tile_0007); //Y
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_face4, tile_0006); //X

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_shoulderl,  tile_0627); //L
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_shoulderr,  tile_0628); //R
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_shoulderlb, tile_0631); //ZL
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_shoulderrb, tile_0632); //ZR

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_select, tile_0684); //Minus
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_start,  tile_0685); //Plus

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_padl, tile_0038); //D-pad left
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_padr, tile_0036); //D-pad right
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_padu, tile_0035  ); //D-pad up
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_padd, tile_0037 ); //D-pad down

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, -gp_axislh, tile_0454);
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH,  gp_axislh, tile_0452);
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, -gp_axislv, tile_0451);
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH,  gp_axislv, tile_0453);
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH,  gp_stickl, "thumbstick l click");

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, -gp_axisrh, "thumbstick r left" );
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH,  gp_axisrh, "thumbstick r right");
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, -gp_axisrv, "thumbstick r up"   );
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH,  gp_axisrv, "thumbstick r down" );
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH,  gp_stickr, "thumbstick r click");

//Not available on the Switch console itself but available on other platforms
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_home,   "home");
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_extra1, "capture");

//Switch 2
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_extra2,  "C" ); //GameChat
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_paddlel, "GL"); //Grip Left
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_SWITCH, gp_paddler, "GR"); //Grip Right



///////////////////
//               //
//  Left JoyCon  //
//               //
///////////////////

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, gp_face1, "face south"); //Face South
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, gp_face2, "face east" ); //Face East
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, gp_face3, "face west" ); //Face West
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, gp_face4, "face north"); //Face North

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, gp_shoulderl, "SL"); //SL
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, gp_shoulderr, "SR"); //SR

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, gp_start, "minus"); //Minus

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, -gp_axislh, "thumbstick left" );
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT,  gp_axislh, "thumbstick right");
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, -gp_axislv, "thumbstick up"   );
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT,  gp_axislv, "thumbstick down" );
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT,  gp_stickl, "thumbstick click");

//Not available on the Switch console itself but available on other platforms
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT, gp_select, "capture"); //Capture



////////////////////
//                //
//  Right JoyCon  //
//                //
////////////////////

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, gp_face1, "face south"); //Face South
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, gp_face2, "face east" ); //Face East
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, gp_face3, "face west" ); //Face West
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, gp_face4, "face north"); //Face North

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, gp_shoulderl, "SL"); //SL
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, gp_shoulderr, "SR"); //SR

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, gp_start, "plus"); //Plus

InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, -gp_axislh, "thumbstick left" );
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT,  gp_axislh, "thumbstick right");
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, -gp_axislv, "thumbstick up"   );
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT,  gp_axislv, "thumbstick down" );
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT,  gp_stickl, "thumbstick click");

//Not available on the Switch console itself but available on other platforms
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, gp_select, "home"); //Home
InputIconDefineGamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, gp_extra2, "C"   ); //Switch 2 GameChat