function DrawSet(color, alpha, halign, valign, font)
{
	draw_set_color(color);
	draw_set_alpha(alpha);
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_font(font);
}

function DrawReset()
{
	DrawSet(c_white, 1, -1, -1, -1);
}

function DrawQuadrilateral(x0, y0, x1, y1, x2, y2, x3, y3, color)
{
	draw_set_color(color);
	draw_triangle(x0, y0, x1, y1, x2, y2, false);
	draw_triangle(x1, y1, x2, y2, x3, y3, false);
	draw_set_color(c_white);
}
