// Inherit the parent event
event_inherited();

if (global.purifiedEnemy != id)
{
	if (!attacking)
	{
		var collision = collision_circle(x, y, attackRadius, oPlayer, false, false);
	
		if (collision != noone)
		{
			xstart = x;
			ystart = y;
			attacking = true;
			attackWaitTimer = attackWaitTime;
		}
	}
	else
	{
		if (attackWaitTimer > 0)
		{
			ySpeed = 0;
			xSpeed = 0;
			attackWaitTimer--;
			attackDirection = point_direction(x, y, oPlayer.x, oPlayer.y);
			
			if (alarm_get(0) == -1)
			{
				alarm[0] = 2;
			}
		}
		else if (point_distance(xstart, ystart, x, y) <= attackDistance)
		{
			var accel = 0.5;
			xSpeed = Approach(xSpeed, lengthdir_x(attackSpeed, attackDirection), accel);
			ySpeed = Approach(ySpeed, lengthdir_y(attackSpeed, attackDirection), accel);
			
			if (point_distance(xstart, ystart, x, y) <= attackSpeed)
			{
				afterAttackWaitTimer = afterAttackWaitTime;
			}
		}
		else if (afterAttackWaitTimer > 0)
		{
			var deccel = 0.2;
			xSpeed = Approach(xSpeed, 0, deccel);
			ySpeed = Approach(ySpeed, 0, deccel);
			afterAttackWaitTimer--;
		}
		else
		{
			attacking = false;
		}
	}
}	
else
{
	attacking = false;
}
