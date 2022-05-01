event_inherited();

if (global.debug)
{
	var color = areaOverlapping ? c_green : c_red;
	draw_set_color(color);
	draw_circle(x, y, areaRadius, true);
	draw_set_color(c_white);
}
