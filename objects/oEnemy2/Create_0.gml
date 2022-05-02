event_inherited();

tangible = false;

bulletYOffset = -10;

bubbleIsBlocking = false;

bubbleMaxRadius = 16;
bubbleRadius = bubbleMaxRadius;

bubbleAlpha = 0.5;

teleportTimer = room_speed * random_range(8, 10);

image_blend = c_blue;

Stun = function()
{
	stunTimer = stunTime;
}

OnAreaOverlap = function()
{
	if (alarm_get(0) == -1)
	{
		alarm[0] = room_speed * 1.5;
	}
}

Teleport = function()
{
	var newX, newY, minX, minY, maxX, maxY;
	
	minX = oCamera.x - oCamera.wHalf;
	minY = oCamera.y - oCamera.hHalf;
	
	maxX = minX + WIDTH;
	maxY = minY + HEIGHT;
	
	do
	{
		newX = random_range(minX, maxX);
		newY = random_range(minY, maxY);
	}
	until (collision_rectangle(newX - sprite_xoffset, newY - sprite_yoffset, newX + sprite_xoffset, newY, all, false, true) == noone &&
		collision_line(newX, newY, oPlayer.x, oPlayer.y, pSolid, false, true) == noone &&
		point_distance(newX, newY, oPlayer.x, oPlayer.y) > 64)
	
	x = newX;
	y = newY;
	
	show_debug_message(string(newX) + "  " + string(newY));
}
