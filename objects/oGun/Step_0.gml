var keyShoot = mouse_check_button(mb_left) || gamepad_button_check(global.device, gp_face1);
if (keyShoot)
{
	if (!attacking)
	{
		attacking = true;
		var _knockback = knockback;
	
		// Knockback
		//with (owner)
		//{
		//	xSpeed -= lengthdir_x(_knockback, global.inputDirection);
		//	ySpeed -= lengthdir_y(_knockback, global.inputDirection);
		//}
		currentRecoil = recoil;
	}
	AttackUpdate();
	sprite_index = sGunPurifing;
	with (oHUD)
	{
		gunXScale = lerp(gunXScale, -2.5, .15);
		gunYScale = lerp(gunYScale, 2.5, .15);
	}
}
else
{
	sprite_index = sGun;
	attacking = false;
	global.purifiedEnemy = noone;
}

if (!attacking)
{
	attackWidth = lerp(attackWidth, 0, .3);
}

// Ectoplasm attack
if (global.ectoplasm >= ectoplasmAttackCost)
{
	if (currentCooldown == 0)
	{
		var keyShoot2 = mouse_check_button_pressed(mb_right) || gamepad_button_check_pressed(global.device, gp_face2);
	
		if (keyShoot2)
		{
			global.ectoplasm -= ectoplasmAttackCost;
			currentRecoil = recoil;
		
			var dir = global.inputDirection;
			with (instance_create_depth(x + lengthdir_x(12, dir), y + lengthdir_y(12, dir), depth + 1, oEctoplasmBullet))
			{
				speed = 4.0;
				direction = dir;
				image_angle = dir;
				image_xscale = 2.5;
				image_yscale = 2.5;
			}
			currentCooldown = cooldown;
			xScale = 1.5;
			yScale = 1.5;
			
			with (oHUD)
			{
				gunXScale = -2;
				gunYScale = 2;
			}
		}
	}
}

currentDelay = max(currentDelay - 1, -1);

if (currentDelay == -1) currentCooldown = max(currentCooldown - 1, 0);
currentRecoil = max(floor(currentRecoil * .8), 0);

xScale = lerp(xScale, 1, .15);
yScale = lerp(yScale, 1, .15);
