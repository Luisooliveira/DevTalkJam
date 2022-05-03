// Inherit the parent event
event_inherited();

// Inherit the parent event
event_inherited();

shadowType = SHADOW_TYPES.NORMAL;

// Placeholder
xScale = 1;
yScale = 1;
maxXScale = 1;
maxYScale = 1;

fly = false;

walkSpeed = 0.5;
walkAccel = 0.15;
walkDeccel = 0.11;

walking = false;

image_blend = c_red;

OnAreaOverlap = function()
{
	walking = true;
	
	var dir = point_direction(x, y, oPlayer.x, oPlayer.y);
	xSpeed = Approach(xSpeed, lengthdir_x(walkSpeed, dir), walkAccel);
	ySpeed = Approach(ySpeed, lengthdir_y(walkSpeed, dir), walkAccel);
}

OnAreaNotOverlap = function()
{
	walking = false;
	
	xSpeed = Approach(xSpeed, 0, walkDeccel);
	ySpeed = Approach(ySpeed, 0, walkDeccel);
}
