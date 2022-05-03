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
ectoplasmAttackCost = 1;

xScale = 1;
yScale = 1;

// Particle type
attackParticle = part_type_create();
part_type_sprite(attackParticle, sGunParticles, false, false, true);
part_type_life(attackParticle, 10, 20);
part_type_speed(attackParticle, 2, 4, 0.02, 0);
part_type_alpha3(attackParticle, 0.8, 0.6, 0.4);

AttackUpdate = function()
{
	attackWidth = lerp(attackWidth, attackMaxWidth, .15);
	
	// Create the particles
	if (alarm_get(0) == -1)
	{
		alarm[0] = 10;
	}
}

AttackRender = function()
{
	var dis = 64;
	var dir = image_angle;
	
	var xOffset = owner.gunXOffset;
	var yOffset = owner.gunYOffset;
	var ownerFacing = owner.facing;
	
	var _x0, _y0, _x1, _y1, _x2, _y2;
	var dir = image_angle;
	var dis1 = 3;
	var dis2 = 12;

	_x0 = owner.x + xOffset * ownerFacing;
	_y0 = owner.y + yOffset;
	
	_x1 = _x0 + lengthdir_x(dis1, dir + 90) * image_yscale;
	_y1 = _y0 + lengthdir_y(dis1, dir + 90) * image_yscale;
	
	_x2 = _x1 + lengthdir_x(dis2, dir);
	_y2 = _y1 + lengthdir_y(dis2, dir);
	
	var _x = _x2;
	var _y = _y2;
	
	var xTo = _x + lengthdir_x(dis, dir);
	var yTo = _y + lengthdir_y(dis, dir);
	
	attackXTo = xTo;
	attackYTo = yTo;
	
	//draw_line_width_color(_x, _y, xTo, yTo, attackWidth, attackColor, attackColor);
	x0 = _x + lengthdir_x( attackWidth, dir + 90);
	y0 = _y + lengthdir_y( attackWidth, dir + 90);
	x1 = _x + lengthdir_x(-attackWidth, dir + 90);
	y1 = _y + lengthdir_y(-attackWidth, dir + 90);
	
	x2 = xTo + lengthdir_x( attackWidth * 3.5, dir + 90);
	y2 = yTo + lengthdir_y( attackWidth * 3.5, dir + 90);
	x3 = xTo + lengthdir_x(-attackWidth * 3.5, dir + 90);
	y3 = yTo + lengthdir_y(-attackWidth * 3.5, dir + 90);
	
	var _attackColor = attackColor;
	var _x0, _y0, _x1, _y1, _x2, _y2, _x3, _y3;
	
	_x0 = x0;
	_y0 = y0;
	_x1 = x1;
	_y1 = y1;
	_x2 = x2;
	_y2 = y2;
	_x3 = x3;
	_y3 = y3;
	
	with (oDepthTop)
	{
		var _depth = depth;
		
		var attackVertexBuffer = vertex_create_buffer();
	
		vertex_begin(attackVertexBuffer, global.vFormat);
		
		vertex_position_3d(attackVertexBuffer, _x0, _y0, _depth);
		vertex_color(attackVertexBuffer, _attackColor, 0.75);
		vertex_position_3d(attackVertexBuffer, _x1, _y1, _depth);
		vertex_color(attackVertexBuffer, _attackColor, 0.75);
		vertex_position_3d(attackVertexBuffer, _x2, _y2, _depth);
		vertex_color(attackVertexBuffer, _attackColor, 0);
	
		vertex_position_3d(attackVertexBuffer, _x1, _y1, _depth);
		vertex_color(attackVertexBuffer, _attackColor, 0.75);
		vertex_position_3d(attackVertexBuffer, _x2, _y2, _depth);
		vertex_color(attackVertexBuffer, _attackColor, 0);
		vertex_position_3d(attackVertexBuffer, _x3, _y3, _depth);
		vertex_color(attackVertexBuffer, _attackColor, 0);
	
		vertex_end(attackVertexBuffer);

		draw_set_color(c_blue);
		draw_sprite_pos(sAttackEffect, 0, _x0, _y0, _x2, _y2, _x1, _y1, _x3, _y3, .5);
		draw_set_color(c_white);
		
		vertex_submit(attackVertexBuffer, pr_trianglelist, -1);
		vertex_delete_buffer(attackVertexBuffer);
	}
}

AttackEnd = function()
{
	
}

UpdatePosition = function(dir)
{
	image_angle = dir;
	x = round(owner.x + owner.gunXOffset * owner.facing);
	y = ceil(owner.y + owner.gunYOffset);
	depth = owner.gunDepth;
	image_yscale = image_angle > 90 && image_angle < 270 ? -1 : 1;
}
