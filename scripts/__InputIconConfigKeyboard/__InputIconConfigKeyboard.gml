// Feather disable all

////////////////
//            //
//  Keyboard  //
//            //
////////////////

InputIconDefineKeyboard("A", tile_0120);
InputIconDefineKeyboard("B", "B");
InputIconDefineKeyboard("C", "C");
InputIconDefineKeyboard("D", tile_0122);
InputIconDefineKeyboard("E", tile_0087);
InputIconDefineKeyboard("F", tile_0123);
InputIconDefineKeyboard("G", tile_0124);
InputIconDefineKeyboard("H", "H");
InputIconDefineKeyboard("I", "I");
InputIconDefineKeyboard("J", "J");
InputIconDefineKeyboard("K", "K");
InputIconDefineKeyboard("L", "L");
InputIconDefineKeyboard("M", "M");
InputIconDefineKeyboard("N", "N");
InputIconDefineKeyboard("O", tile_0093);
InputIconDefineKeyboard("P", tile_0094);
InputIconDefineKeyboard("Q", tile_0085);
InputIconDefineKeyboard("R", tile_0120);
InputIconDefineKeyboard("S", tile_0121);
InputIconDefineKeyboard("T", tile_0089);
InputIconDefineKeyboard("U", tile_0091);
InputIconDefineKeyboard("V", tile_0090);
InputIconDefineKeyboard("W", tile_0086);
InputIconDefineKeyboard("X", tile_0156);
InputIconDefineKeyboard("Y", "Y");
InputIconDefineKeyboard("Z", tile_0155);

InputIconDefineKeyboard("0", "0");
InputIconDefineKeyboard("1", "1");
InputIconDefineKeyboard("2", "2");
InputIconDefineKeyboard("3", "3");
InputIconDefineKeyboard("4", "4");
InputIconDefineKeyboard("5", "5");
InputIconDefineKeyboard("6", "6");
InputIconDefineKeyboard("7", "7");
InputIconDefineKeyboard("8", "8");
InputIconDefineKeyboard("9", "9");

InputIconDefineKeyboard(vk_backtick,   "`");
InputIconDefineKeyboard(vk_hyphen,     "-");
InputIconDefineKeyboard(vk_equals,     "=");
InputIconDefineKeyboard(vk_semicolon,  ";");
InputIconDefineKeyboard(vk_apostrophe, "'");
InputIconDefineKeyboard(vk_comma,      ",");
InputIconDefineKeyboard(vk_period,     ".");
InputIconDefineKeyboard(vk_rbracket,   "]");
InputIconDefineKeyboard(vk_lbracket,   "[");
InputIconDefineKeyboard(vk_fslash,     "/");
InputIconDefineKeyboard(vk_bslash,     "\\");

InputIconDefineKeyboard(vk_scrollock, "scroll lock");
InputIconDefineKeyboard(vk_capslock,  "caps lock");
InputIconDefineKeyboard(vk_numlock,   "num lock");
InputIconDefineKeyboard(vk_lmeta,     "left meta");
InputIconDefineKeyboard(vk_rmeta,     "right meta");
InputIconDefineKeyboard(vk_clear,     "clear");
InputIconDefineKeyboard(vk_menu,      "menu");

InputIconDefineKeyboard(vk_printscreen, "print screen");
InputIconDefineKeyboard(vk_pause,       "pause break");

InputIconDefineKeyboard(vk_escape,    tile_0017);
InputIconDefineKeyboard(vk_backspace, "backspace");
InputIconDefineKeyboard(vk_space,     tile_0153);
InputIconDefineKeyboard(vk_enter,     tile_0134);

InputIconDefineKeyboard(vk_up,    tile_0166);
InputIconDefineKeyboard(vk_down,  tile_0168);
InputIconDefineKeyboard(vk_left,  tile_0169);
InputIconDefineKeyboard(vk_right, tile_0167);

InputIconDefineKeyboard(vk_tab,      "tab");
InputIconDefineKeyboard(vk_ralt,     "right alt");
InputIconDefineKeyboard(vk_lalt,     "left alt");
InputIconDefineKeyboard(vk_alt,      "alt");
InputIconDefineKeyboard(vk_rshift,   "right shift");
InputIconDefineKeyboard(vk_lshift,   "left shift");
InputIconDefineKeyboard(vk_shift,    tile_0255);
InputIconDefineKeyboard(vk_rcontrol, "right ctrl");
InputIconDefineKeyboard(vk_lcontrol, "left ctrl");
InputIconDefineKeyboard(vk_control,  "ctrl");

InputIconDefineKeyboard(vk_f1,  "f1");
InputIconDefineKeyboard(vk_f2,  "f2");
InputIconDefineKeyboard(vk_f3,  "f3");
InputIconDefineKeyboard(vk_f4,  "f4");
InputIconDefineKeyboard(vk_f5,  "f5");
InputIconDefineKeyboard(vk_f6,  "f6");
InputIconDefineKeyboard(vk_f7,  "f7");
InputIconDefineKeyboard(vk_f8,  "f8");
InputIconDefineKeyboard(vk_f9,  "f9");
InputIconDefineKeyboard(vk_f10, "f10");
InputIconDefineKeyboard(vk_f11, "f11");
InputIconDefineKeyboard(vk_f12, "f12");

InputIconDefineKeyboard(vk_divide,   "numpad /");
InputIconDefineKeyboard(vk_multiply, "numpad *");
InputIconDefineKeyboard(vk_subtract, "numpad -");
InputIconDefineKeyboard(vk_add,      "numpad +");
InputIconDefineKeyboard(vk_decimal,  "numpad .");

InputIconDefineKeyboard(vk_numpad0, "numpad 0");
InputIconDefineKeyboard(vk_numpad1, "numpad 1");
InputIconDefineKeyboard(vk_numpad2, "numpad 2");
InputIconDefineKeyboard(vk_numpad3, "numpad 3");
InputIconDefineKeyboard(vk_numpad4, "numpad 4");
InputIconDefineKeyboard(vk_numpad5, "numpad 5");
InputIconDefineKeyboard(vk_numpad6, "numpad 6");
InputIconDefineKeyboard(vk_numpad7, "numpad 7");
InputIconDefineKeyboard(vk_numpad8, "numpad 8");
InputIconDefineKeyboard(vk_numpad9, "numpad 9");

InputIconDefineKeyboard(vk_delete,   "delete");
InputIconDefineKeyboard(vk_insert,   "insert");
InputIconDefineKeyboard(vk_home,     "home");
InputIconDefineKeyboard(vk_pageup,   "page up");
InputIconDefineKeyboard(vk_pagedown, "page down");
InputIconDefineKeyboard(vk_end,      "end");
   
//Name newline character after Enter
InputIconDefineKeyboard(10, "enter");

//Reset F11 and F12 keycodes on certain platforms
if (INPUT_ON_LINUX || INPUT_ON_MACOS)
{
    InputIconDefineKeyboard(128, "f11");
    InputIconDefineKeyboard(129, "f12");
}

//F13 to F32 on Windows and Web
if (INPUT_ON_WINDOWS || INPUT_ON_WEB)
{
    for(var _i = vk_f1 + 12; _i < vk_f1 + 32; _i++)
    {
        InputIconDefineKeyboard(_i, "f" + string(_i));
    }
}