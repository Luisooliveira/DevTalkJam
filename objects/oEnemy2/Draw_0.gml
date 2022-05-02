// Inherit the parent event
event_inherited();

if (!tangible)
{
	draw_set_alpha(bubbleAlpha);
	draw_circle_color(x, y - z - (sprite_height * 0.5), bubbleRadius, c_white, c_gray, false);
	draw_set_alpha(1);
}
