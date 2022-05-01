width = WIDTH;
height = HEIGHT;
wHalf = width * 0.5;
hHalf = height * 0.5;

if (instance_exists(target))
{
	xTo = target.x;
	yTo = target.y;
}

x += (xTo - x) / spd;
y += (yTo - y) / spd;

x = clamp(x, wHalf, room_width - wHalf);
y = clamp(y, hHalf, room_height - hHalf);

x += random_range(-shakeRemain, shakeRemain);
y += random_range(-shakeRemain, shakeRemain);
shakeRemain = max(0, shakeRemain - ((1.0 / shakeLength) * shakeMagnitude));

camera_set_view_pos(cam, x - wHalf, y - hHalf);
