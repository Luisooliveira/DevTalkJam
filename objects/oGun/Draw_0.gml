AttackRender();
var xx = x - lengthdir_x(currentRecoil, global.inputDirection);
var yy = y - lengthdir_y(currentRecoil, global.inputDirection);
draw_sprite_ext(sprite_index, image_index, xx, yy, image_xscale * xScale, image_yscale * yScale, image_angle, image_blend, image_alpha);

var x0, y0, x1, y1, x2, y2;
var dir = image_angle;
var dis1 = 3;
var dis2 = 12;

x0 = owner.x + owner.gunXOffset * owner.facing;
y0 = owner.y + owner.gunYOffset;

x1 = x0 + lengthdir_x(dis1, dir + 90) * image_yscale;
y1 = y0 + lengthdir_y(dis1, dir + 90) * image_yscale;

x2 = x1 + lengthdir_x(dis2, dir);
y2 = y1 + lengthdir_y(dis2, dir);

draw_line(x0, y0, x1, y1);
draw_line(x1, y1, x2, y2);
