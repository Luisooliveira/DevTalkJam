// Ectoplasm bar
//var maxEctoplasm = global.ectoplasm == global.maxEctoplasm;

//draw_set_color(barColor);
//draw_rectangle(barX - barWidth - barBorder, barY + 1 - 0.5 + barHeight * 0.5, barX - 2 - barBorder, barY - 0.5 + barHeight * 0.5 - ectoplasmValue + (maxEctoplasm ? 1 : 0), false);
//draw_set_color(c_white);

//draw_sprite(sEctoplasmBar, 0, barX - barBorder, barY);

//// Weapons slots
//draw_sprite(sSlot, 0, slot1X, slot1Y);
//draw_sprite_ext(sGun, 0, slot1X + weaponsXOffset * 2, slot1Y + sin(get_timer() * 0.000001) * 3, gunXScale, gunYScale, gunAngleApproach, c_white, 1);

//draw_sprite(sSlot, 0, slot2X, slot2Y);
//draw_sprite_ext(sWeapon, 0, slot2X + weaponsXOffset, slot2Y + sin((pi * 0.5) + get_timer() * 0.000001) * 3, weaponXScale, weaponYScale, weaponAngleApproach, c_white, 1);

// Slots
draw_sprite(sGunSlot, 0, slot1X, 124);
draw_sprite(sWeaponSlot, 0, slot2X, 155);

// Icons
draw_sprite_ext(sGun, 0, gunX, 127, gunXScale, gunYScale, gunAngle, c_white, 1);

// Hearts
var _x = heartsXPos;
var _y = heartsYPos;
repeat (global.playerLife)
{
	draw_sprite(sHeart, 0, _x, _y);
	_x += heartsSeparation;
}

// Contamined hearts
repeat (global.playerMaxLife - global.playerLife)
{
	draw_sprite(sHeart, 1, _x, _y);
	_x += heartsSeparation;
}
