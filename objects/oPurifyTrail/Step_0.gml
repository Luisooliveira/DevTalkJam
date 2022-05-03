if (global.purifiedEnemy != owner)
{
	image_alpha = Approach(image_alpha, 0, 0.05);
}
else
{
	image_xscale = Approach(image_xscale, 0, 0.02);
	image_yscale = Approach(image_yscale, 0, 0.02);
	if (image_xscale < 0.75)
	{
		image_alpha = Approach(image_alpha, 0, 0.05);
	}
	
	if (image_alpha == 0)
	{
		instance_destroy();
	}
}

if (instance_exists(owner))
{
	depth = owner.depth + 1;
}

color = make_color_hsv(color_get_hue(color), color_get_saturation(color) + 6, color_get_value(color));
