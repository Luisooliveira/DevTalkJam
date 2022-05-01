if (point_distance(x, y, oPlayer.x, oPlayer.y) < areaRadius)
{
	areaOverlapping = true;
	OnAreaOverlap();
}
else
{
	areaOverlapping = false;
}

z = 6 + (sin(get_timer() * 0.000001) * 4);

// Checking for collision with the gun
if (global.capturedEnemy == noone)
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
					global.capturedEnemy = other.id;
				}
		}
	}
}
else if (global.capturedEnemy == id)
{
	var bboxLeft = bbox_left;
	var bboxTop = bbox_top;
	var bboxRight = bbox_right;
	var bboxBottom = bbox_bottom;
	with (oGun)
	{
		if (attacking)
		{
			if (rectangle_in_triangle(bboxLeft, bboxTop, bboxRight, bboxBottom, x0, y0, x1, y1, x2, y2, ) == 0 ||
				rectangle_in_triangle(bboxLeft, bboxTop, bboxRight, bboxBottom, x1, y1, x2, y2, x3, y3, ) == 0)
				{
					global.capturedEnemy = noone;
				}
		}
	}
}

if (global.capturedEnemy == id)
{
	var dir = point_direction(x, y, oPlayer.x, oPlayer.y);
	xSpeed = lengthdir_x(1.5, dir);
	ySpeed = lengthdir_y(1.5, dir);
}
else
{
	xSpeed = Approach(xSpeed, 0, .1);
	ySpeed = Approach(ySpeed, 0, .1);
}
