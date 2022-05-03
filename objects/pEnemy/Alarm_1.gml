with (instance_create_depth(x, spriteY, depth + 1, oPurifyTrail))
{
	var dir = point_direction(x, y, oPlayer.x, oPlayer.y);
	owner = other.id;
	direction = dir;
	speed = 1.0;
	sprite_index = other.sprite_index;
}
