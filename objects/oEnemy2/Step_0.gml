if (stunTimer > 0)
{
	bubbleRadius = lerp(bubbleRadius, 0, .15);
	stunned = true;
	stunTimer--;
}
else
{
	bubbleRadius = lerp(bubbleRadius, bubbleMaxRadius, .15);
	stunned = false;
}

if (purifyTimer < 0)
{
	purified = true;
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

	// Checking for collision with the gun
	if (stunned)
	{
		if (alarm_get(1) == -1)
		{
			// Alarm to make the shake effect
			alarm[1] = 3;
		}
		
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
		maxXScale = 1;
		scaleLerpAmount = 0.15;
	}
	else
	{
		if (teleportTimer > 0)
		{
			maxXScale = 1;
			scaleLerpAmount = 0.25;
			teleportTimer--;
		}
		else
		{
			maxXScale = 0;
			scaleLerpAmount = 0.25;
			
			if (xScale <= 0.01)
			{
				Teleport();
				teleportTimer = room_speed * random_range(10, 14);
			}
		}
		
		z = 6 + (sin(siner * 0.03) * 2);
		siner++;
		siner %= 360;
		
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
							other.bubbleIsBlocking = true;
						}
						else
						{
							other.bubbleIsBlocking = false;
						}
				}
				else
				{
					other.bubbleIsBlocking = false;
				}
			}
		}
		else
		{
			other.bubbleIsBlocking = false;
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
	
		var rand = random_range(0.25, 0.5);
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
		instance_destroy();
	}
}

if (!tangible)
{
	if (!bubbleIsBlocking)
	{
		bubbleAlpha = Approach(bubbleAlpha, 0.5, 0.1);
	}
	else
	{
		bubbleAlpha = Approach(bubbleAlpha, 0.75, 0.1);
	}
}
else
{
	bubbleAlpha = Approach(bubbleAlpha, 0.5, 0.1);
}

var face = sign(oPlayer.x - x);
if (face != 0)
{
	facing = -face;
}
