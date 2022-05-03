surface_resize(application_surface, SURFACE_WIDTH, SURFACE_HEIGHT);
display_set_gui_size(DISPLAY_WIDTH, DISPLAY_HEIGHT);
audio_group_load(agSFX);

// Input keys
InputAdd("keyRight", [vk_right, ord("D")], [gp_padr, GP_AXIS.LRIGHT]);
InputAdd("keyUp", [vk_up, ord("W")], [gp_padu, GP_AXIS.LUP]);
InputAdd("keyLeft", [vk_left, ord("A")], [gp_padl, GP_AXIS.LLEFT]);
InputAdd("keyDown", [vk_down, ord("S")], [gp_padd, GP_AXIS.LDOWN]);
InputAdd("keyEnter", [vk_enter, ord("Z")], [gp_face1]);
InputAdd("keyJump", [vk_space, ord("X")], [gp_face1]);

// Pubsub events
PubsubSubscribe("Player hurt", function()
{
	if (global.playerInvincible)
	{
		return;
	}
	
	if (global.playerLife > 0) // Hurt
	{
		global.playerLife--;
		global.playerInvincibleTimer = global.playerInvincibleTime;
		ScreenShake(5, 20);
	}
	else // Die
	{
		PubsubPublish("Player die");
	}
});

PubsubSubscribe("Player die", function()
{
	
})

// Vertex format for gun attack
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
global.vFormat = vertex_format_end();

// Particle system
global.particleSystem = part_system_create();

musicGain = 1;
musicVolume = 1;

global.debug = false;
global.debugToggleKey = vk_f1;

global.inputMode = KEYBOARD;
global.inputDirection = 0;

global.lastMouseX = mouse_x;
global.lastMouseY = mouse_y;

global.maxEctoplasm = 10;
global.ectoplasm = 0;
global.purifiedEnemy = noone;

global.playerMaxLife = 3;
global.playerLife = global.playerMaxLife;
global.playerInvincible = false;
global.playerInvincibleTime = room_speed * 0.5;
global.playerInvincibleTimer = 0;

global.weaponSlot = 0;

global.purifyTime = room_speed * 1.5;

global.saveData =
{
	masterVolume: 1,
	musicVolume: 1,
	sfxVolume: 1,
	fullscreen: true,
	rumble: true,
}

room_goto(ROOM_START);