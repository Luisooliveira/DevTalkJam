if (string_pos("rLevel", room_get_name(room)) == 1)
{
	hudAlpha = Approach(hudAlpha, 1, .02);
}
else
{
	hudAlpha = Approach(hudAlpha, 0, .02);
}

ectoplasmValue = lerp(ectoplasmValue, global.ectoplasm * ectoplasmPixelsHeight, 0.15);

if (global.weaponSlot == 1)
{
	slot1X = lerp(slot1X, slotsXStart + slotsXOffset, .15);
	slot2X = lerp(slot2X, slotsXStart, .15);
	gunX = lerp(gunX, gunXStart + slotsXOffset, .15);
}
else
{
	slot2X = lerp(slot2X, slotsXStart + slotsXOffset, .15);
	slot1X = lerp(slot1X, slotsXStart, .15);
	gunX = lerp(gunX, gunXStart, .15);
}

gunXScale = lerp(gunXScale, -2.0, .15);
gunYScale = lerp(gunYScale, 2.0, .15);
gunAngleApproach = lerp(gunAngleApproach, gunAngleStart, .15);

weaponXScale = lerp(weaponXScale, 2, .15);
weaponYScale = lerp(weaponYScale, 2, .15);
weaponAngleApproach = lerp(weaponAngleApproach, weaponAngleStart, .15);
