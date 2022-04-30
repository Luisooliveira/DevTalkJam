InputAdd("keyRight", [vk_right, ord("D")], [gp_padr, GP_AXIS.LRIGHT]);
InputAdd("keyUp", [vk_up, ord("W")], [gp_padu, GP_AXIS.LUP]);
InputAdd("keyLeft", [vk_left, ord("A")], [gp_padl, GP_AXIS.LLEFT]);
InputAdd("keyDown", [vk_down, ord("S")], [gp_padd, GP_AXIS.LDOWN]);
InputAdd("keyEnter", [vk_enter, ord("Z")], [gp_face1]);
InputAdd("keyJump", [vk_space, ord("X")], [gp_face1]);

global.debug = false;
global.debugToggleKey = vk_f1;

room_goto(ROOM_START);