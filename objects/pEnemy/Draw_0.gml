if (drawShadow)
{
	draw_sprite(sShadows, shadowType, x, y);
}

if (!purified)
{
	draw_sprite_ext(sprite_index, image_index, round(x) + xBuff, ceil(y) - z, xScale * facing, yScale, image_angle, image_blend, image_alpha);
}
else
{
	var sine = sin(get_timer() * 0.00005) * 2;
	var dir = point_direction(x, y, oPlayer.x, oPlayer.y) - 180;
	draw_sprite_ext(sprite_index, image_index, round(x) + lengthdir_x(sine, dir), ceil(y) - z + lengthdir_y(sine, dir), xScale * facing, yScale, image_angle, image_blend, image_alpha);
}

if (global.debug)
{
	var color = areaOverlapping ? c_green : c_red;
	draw_set_color(color);
	draw_circle(x, y, areaRadius, true);
	draw_set_color(c_white);
}

if (flash > 0)
{
	gpu_set_fog(true, c_white, 1, 0);
	draw_sprite_ext(sprite_index, image_index, round(x), ceil(y) - z, xScale * facing, yScale, image_angle, image_blend, image_alpha);
	gpu_set_fog(false, c_black, 0, 0);
	flash--;
}
