var xx = x - lengthdir_x(currentRecoil, global.inputDirection);
var yy = y - lengthdir_y(currentRecoil, global.inputDirection);
draw_sprite_ext(sprite_index, image_index, xx, yy, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

AttackRender();
