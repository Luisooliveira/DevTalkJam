var finalXSpeed = xSpeed + knockbackForceX;
var finalYSpeed = ySpeed + knockbackForceY;

// Object collision
if (place_meeting(x + finalXSpeed, y, pSolid))
{
	var onePixel = sign(finalXSpeed);
	while (!place_meeting(x + onePixel, y, pSolid))
	{
		x += onePixel;
	}
	finalXSpeed = 0;
}

x += finalXSpeed;

// Object collision
if (place_meeting(x, y + finalYSpeed, pSolid))
{
	var onePixel = sign(finalYSpeed);
	while (!place_meeting(x, y + onePixel, pSolid))
	{
		y += onePixel;
	}
	finalYSpeed = 0;
}

y += finalYSpeed;

if (lerpScale)
{
	xScale = lerp(xScale, maxXScale, scaleLerpAmount);
	yScale = lerp(yScale, maxYScale, scaleLerpAmount);
}

depth = -bbox_bottom;

var force = 0.15;
knockbackForceX = Approach(knockbackForceX, 0, force);
knockbackForceY = Approach(knockbackForceY, 0, force);
	
EndStep();
