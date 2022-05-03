var ix = round(x);
var iy = ceil(y);

if (drawShadow)
{
	draw_sprite(sShadows, shadowType, ix, iy);
}

draw_sprite_ext(sprite_index, image_index, ix, iy - z, xScale * facing, maxYScale, image_angle, image_blend, image_alpha);

if (flash > 0)
{
	gpu_set_fog(true, c_white, 1, 0);
	draw_sprite_ext(sprite_index, image_index, ix, iy - z, xScale * facing, yScale, image_angle, image_blend, image_alpha);
	gpu_set_fog(false, c_black, 0, 0);
	flash--;
}
