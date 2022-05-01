if (drawShadow)
{
	draw_sprite(sShadows, shadowType, x, y);
}
draw_sprite_ext(sprite_index, image_index, round(x), ceil(y) - z, xScale * facing, yScale, image_angle, image_blend, image_alpha);
