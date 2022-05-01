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

EndStep();

xScale = lerp(xScale, 1, .15);
yScale = lerp(yScale, 1, .15);
