// Inherit the parent event
event_inherited();

runSpeed = 1.5;
escapeSpeed = 0.5;
runAcceleration = 0.2;

attacking = false;
attackRadius = 28;
attackWaitTime = room_speed * 1.0;
attackWaitTimer = 0;
attackSpeed = 3.0;
attackDistance = 48;
attackDirection = 0;

afterAttackWaitTime = room_speed * 2.0;
afterAttackWaitTimer = 0;

areaRadius = 96;


OnAreaOverlap = function()
{
	var dir = point_direction(x, y, oPlayer.x, oPlayer.y);
	
	xSpeed = Approach(xSpeed, lengthdir_x(runSpeed, dir), runAcceleration);
	ySpeed = Approach(ySpeed, lengthdir_y(runSpeed, dir), runAcceleration);
}

OnAreaNotOverlap = function()
{
	xSpeed = Approach(xSpeed, 0, runAcceleration);
	ySpeed = Approach(ySpeed, 0, runAcceleration);
}
