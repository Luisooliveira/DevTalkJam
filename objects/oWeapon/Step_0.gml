var keyShoot = mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right);

if (delay > 0)
{
	delay--;
}
else
{
	if (keyShoot)
	{
		var hitbox = instance_create_depth(x, y, depth + 1, oWeaponHitbox);
		hitbox.image_angle = image_angle;
		hitbox.owner = id;
	
		// Reverse the side of the gun
		if (side == 1)
		{
			side = -1;
		}
		else
		{
			side = 1;
		}
		delay = delayTime;
	}
}

scale = Approach(scale, side, 0.5);
