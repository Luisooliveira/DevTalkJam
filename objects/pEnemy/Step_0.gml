if (purifyTimer < 0)
{
	purified = true;
}

if (invincibleTimer > 0)
{
	invincible = true;
	invincibleTimer--;
}
else
{
	invincible = false;
}

if (!purified)
{
	if (point_distance(x, y, oPlayer.x, oPlayer.y) < areaRadius)
	{
		areaOverlapping = true;
		OnAreaOverlap();
	}
	else
	{
		areaOverlapping = false;
		OnAreaNotOverlap();
	}
	
	if (fly)
	{
		z = 6 + (sin(siner * 0.03) * 2);
		siner++;
		siner %= 360;
	}
	
	// Checking for collision with the gun
	if (tangible)
	{
		if (global.purifiedEnemy == noone)
		{
			var bboxLeft = bbox_left;
			var bboxTop = bbox_top;
			var bboxRight = bbox_right;
			var bboxBottom = bbox_bottom;
			with (oGun)
			{
				if (attacking)
				{
					if (rectangle_in_triangle(bboxLeft, bboxTop, bboxRight, bboxBottom, x0, y0, x1, y1, x2, y2, ) != 0 ||
						rectangle_in_triangle(bboxLeft, bboxTop, bboxRight, bboxBottom, x1, y1, x2, y2, x3, y3, ) != 0)
						{
							global.purifiedEnemy = other.id;
						}
				}
			}
		}
		else if (global.purifiedEnemy == id)
		{
			var bboxLeft = bbox_left;
			var bboxTop = bbox_top;
			var bboxRight = bbox_right;
			var bboxBottom = bbox_bottom;
			with (oGun)
			{
				if (attacking)
				{
					if (rectangle_in_triangle(bboxLeft, bboxTop, bboxRight, bboxBottom, x0, y0, x1, y1, x2, y2, ) == 0 &&
						rectangle_in_triangle(bboxLeft, bboxTop, bboxRight, bboxBottom, x1, y1, x2, y2, x3, y3, ) == 0)
						{
							global.purifiedEnemy = noone;
						}
				}
			}
		}
	}

	if (global.purifiedEnemy == id)
	{
		purifyTimer--;
		tryingToEscape = true;
		Onpurified();
	
		// Try to escape
		var dir = point_direction(x, y, oPlayer.x, oPlayer.y);
		xSpeed = lengthdir_x(escapeSpeed * random(1), dir - 180);
		ySpeed = lengthdir_y(escapeSpeed * random(1), dir - 180);
	
		var rand = random_range(0.5, 1.0);
		xSpeed += lengthdir_x(rand, dir);
		ySpeed += lengthdir_y(rand, dir);
	}
	else
	{
		purifyTimer = min(purifyTimer + 2, global.purifyTime);
		tryingToEscape = false;
		xSpeed = Approach(xSpeed, 0, .1);
		ySpeed = Approach(ySpeed, 0, .1);
	}
}
else
{
	xSpeed = 0;
	ySpeed = 0;
	
	lerpScale = false;
	xScale = lerp(xScale, 1.4, .15);
	yScale = lerp(yScale, 0, .2);
	
	if (yScale == 0.001)
	{
		if (global.purifiedEnemy == id)
		{
			global.purifiedEnemy = noone;
		}
		instance_destroy();
	}
}

var face = sign(oPlayer.x - x);
if (face != 0)
{
	facing = -face;
}
