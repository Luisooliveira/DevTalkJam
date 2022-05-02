if (keyboard_check_pressed(global.debugToggleKey))
{
	global.debug = !global.debug;
}

// Player invincibility
if (global.playerInvincibleTimer > 0)
{
	global.playerInvincible = true;
	global.playerInvincibleTimer--;
}
else
{
	global.playerInvincible = false;
}

// Audio stuff
musicVolume = Approach(musicVolume, musicGain, 0.02);
audio_group_set_gain(audiogroup_default, (SAVE_DATA.musicVolume * musicGain) * SAVE_DATA.masterVolume, 0);
audio_group_set_gain(agSFX, SAVE_DATA.sfxVolume * SAVE_DATA.masterVolume, 0);

// Fullscreen
if (keyboard_check_pressed(vk_f4))
{
	window_set_fullscreen(!window_get_fullscreen());
}

SAVE_DATA.fullscreen = window_get_fullscreen();
