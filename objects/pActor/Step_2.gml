var bboxSide;

if (xSpeed >= 0)
{
	bboxSide = bbox_right;
}
else
{
	bboxSide = bbox_left;
}

// Object collision
if (place_meeting(x + xSpeed, y, pSolid))
{
	var onePixel = sign(xSpeed);
	while (!place_meeting(x + onePixel, y, pSolid))
	{
		x += onePixel;
	}
	xSpeed = 0;
}

x += xSpeed;

if (ySpeed >= 0)
{
	bboxSide = bbox_bottom;
}
else
{
	bboxSide = bbox_top;
}

// Object collision
if (place_meeting(x, y + ySpeed, pSolid))
{
	var onePixel = sign(ySpeed);
	while (!place_meeting(x, y + onePixel, pSolid))
	{
		y += onePixel;
	}
	ySpeed = 0;
}

y += ySpeed;

CollisionEnd();

xScale = lerp(xScale, 1, .15);
yScale = lerp(yScale, 1, .15);
