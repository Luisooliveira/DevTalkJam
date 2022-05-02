owner = noone;

knockback = 3;

cooldown = 10;
currentCooldown = 0;
currentDelay = -1;
currentRecoil = 0;

recoil = 4;

// Attacking
attacking = false;
attackWidth = 0;
attackMaxWidth = 3;
attackXTo = -1;
attackYTo = -1;

// Attack visual
attackColor = c_aqua;

// Capture area coordinates
x0 = 0;
y0 = 0;

x1 = 0;
y1 = 0;

x2 = 0;
y2 = 0;

x3 = 0;
y3 = 0;

// Ectoplasm attack
ectoplasmAttackCost = 10;

// Particle type
attackParticle = part_type_create();
part_type_shape(attackParticle, pt_shape_pixel);
part_type_color1(attackParticle, attackParticle);
part_type_life(attackParticle, 40, 60);
part_type_speed(attackParticle, 2, 4, 0.02, 0);
part_type_color1(attackParticle, c_blue);
part_type_alpha3(attackParticle, 0.8, 0.6, 0.4);

AttackUpdate = function()
{
	attackWidth = lerp(attackWidth, attackMaxWidth, .15);
	
	// Create the particles
	if (alarm_get(0) == -1)
	{
		alarm[0] = 5;
	}
}

AttackRender = function()
{
	var dis = 64;
	var dir = image_angle;
	
	var _x = owner.x + lengthdir_x(12, dir);
	var _y = (owner.y + owner.gunYOffset) + lengthdir_y(12, dir);
	
	var xTo = _x + lengthdir_x(dis, dir);
	var yTo = _y + lengthdir_y(dis, dir);
	
	attackXTo = xTo;
	attackYTo = yTo;
	
	var attackVertexBuffer = vertex_create_buffer();
	
	vertex_begin(attackVertexBuffer, global.vFormat);
	
	var _depth = -9999;
	//draw_line_width_color(_x, _y, xTo, yTo, attackWidth, attackColor, attackColor);
	x0 = _x + lengthdir_x( attackWidth, dir + 90);
	y0 = _y + lengthdir_y( attackWidth, dir + 90);
	x1 = _x + lengthdir_x(-attackWidth, dir + 90);
	y1 = _y + lengthdir_y(-attackWidth, dir + 90);
	
	x2 = xTo + lengthdir_x( attackWidth * 3.5, dir + 90);
	y2 = yTo + lengthdir_y( attackWidth * 3.5, dir + 90);
	x3 = xTo + lengthdir_x(-attackWidth * 3.5, dir + 90);
	y3 = yTo + lengthdir_y(-attackWidth * 3.5, dir + 90);
	
	vertex_position_3d(attackVertexBuffer, x0, y0, _depth);
	vertex_color(attackVertexBuffer, attackColor, 0.75);
	vertex_position_3d(attackVertexBuffer, x1, y1, _depth);
	vertex_color(attackVertexBuffer, attackColor, 0.75);
	vertex_position_3d(attackVertexBuffer, x2, y2, _depth);
	vertex_color(attackVertexBuffer, attackColor, 0);
	
	vertex_position_3d(attackVertexBuffer, x1, y1, _depth);
	vertex_color(attackVertexBuffer, attackColor, 0.75);
	vertex_position_3d(attackVertexBuffer, x2, y2, _depth);
	vertex_color(attackVertexBuffer, attackColor, 0);
	vertex_position_3d(attackVertexBuffer, x3, y3, _depth);
	vertex_color(attackVertexBuffer, attackColor, 0);
	
	vertex_end(attackVertexBuffer);
	
	vertex_submit(attackVertexBuffer, pr_trianglelist, -1);
	vertex_delete_buffer(attackVertexBuffer);
	
	draw_set_color(c_blue);
	draw_sprite_pos(sAttackEffect, 0, x0, y0, x2, y2, x1, y1, x3, y3, .5);
	draw_set_color(c_white);
}

AttackEnd = function()
{
	
}

UpdatePosition = function()
{
	image_angle = global.inputDirection;
	x = owner.x;
	y = owner.y + owner.gunYOffset;
	depth = owner.gunDepth;
}
