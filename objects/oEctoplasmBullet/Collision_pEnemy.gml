if (other.invincible)
{
	exit;
}

var dir = point_direction(x, y, other.x, other.y);
var _knockbackForce = knockbackForce;

with (other)
{
	knockbackForceX = lengthdir_x(_knockbackForce, dir);
	knockbackForceY = lengthdir_y(_knockbackForce, dir);
	
	if (object_index == oEnemy3)
	{
		life--;
	}
	
	flash = 3;
	invincibleTimer = invincibleTime;
	
	stunTimer = stunTime;
}
instance_destroy();
