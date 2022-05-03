// Inherit the parent event
event_inherited();

life = 4;

tangible = false;

shadowType = SHADOW_TYPES.HUGE;

// Placeholder
xScale = 2;
yScale = 2;
maxXScale = 2;
maxYScale = 2;

fly = false;

walkSpeed = 0.5;
walkAccel = 0.15;
walkDeccel = 0.11;

walking = false;

image_blend = c_red;

Explode = function()
{
	var dir = random(360);
	var _speed = 3.0;
	
	var enemy1 = instance_create_depth(x, y, depth, oMiniEnemy3);
	enemy1.xSpeed = lengthdir_x(_speed, dir);
	enemy1.ySpeed = lengthdir_y(_speed, dir);
	
	dir = random_range(dir - 180 - 90, dir - 180 + 90);
	
	var enemy1 = instance_create_depth(x, y, depth, oMiniEnemy3);
	enemy1.xSpeed = lengthdir_x(_speed, dir);
	enemy1.ySpeed = lengthdir_y(_speed, dir);
}

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
