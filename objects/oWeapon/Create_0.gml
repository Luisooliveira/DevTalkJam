owner = noone;

side = 1;
scale = 1;

delayTime = 20;
delay = 0;

UpdatePosition = function()
{
	var distance = 8;
	
	image_angle = global.inputDirection;
	image_yscale = (image_angle > 90 && image_angle < 270 ? -1 : 1) * scale;
	
	x = owner.x + lengthdir_x(distance, image_angle);
	y = (owner.y + owner.gunYOffset) + lengthdir_y(distance, image_angle);
	depth = owner.gunDepth;
}
