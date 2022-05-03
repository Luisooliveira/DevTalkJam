event_inherited();

enum PLAYER_STATES
{
	FREE,
	TOTAL
}

xMove = 0;
yMove = 0;

moveMagnitude = 0;
moveDirection = 0;

xInput = 0;
yInput = 0;

runSpeed = 2.0;
runAcceleration = 0.4;

#region Jump variables (obsolete)

//maxYSpeed = 5.0;

//onGround = false;

//// Jump variables
//jumpGraceTime = 8;
//jumpGraceTimer = 0;

//varJumpTime = 12;
//varJumpTimer = 0;
//varJumpSpeed = 0;

//jumpSpeed = -3.0;
//jumpHBoost = 0.5;

//jumpRememberTime = 12;
//jumpRememberTimer = 0;

#endregion

// Player gun
gunXOffset = 4;
gunYOffset = -6;
gunDepth = depth;

weapon = instance_create_depth(x, y + gunYOffset, depth - 1, oGun);
weapon.owner = id;

dir = 0;

Hurt = function(by)
{
	PubsubPublish("Player hurt");
	var force = 1.5;
	var dir = point_direction(x, y, other.x, other.y) - 180;
	knockbackForceX = lengthdir_x(force, dir);
	knockbackForceY = lengthdir_y(force, dir);
}

ChangeWeapon = function()
{
	if (global.weaponSlot == 0)
	{
		instance_destroy(weapon);
		
		weapon = instance_create_depth(x, y + gunYOffset, depth - 1, oGun);
		weapon.owner = id;
	}
	else
	{
		instance_destroy(weapon);
		
		weapon = instance_create_depth(x, y + gunYOffset, depth - 1, oWeapon);
		weapon.owner = id;
	}
}

EndStep = function()
{
	var mouseIsDragging = MouseIsDragging();
	// Updating input
	UpdateInput(mouseIsDragging);
	// Animating the player
	Animation(mouseIsDragging);
	// Gun's position update
	weapon.UpdatePosition(dir);
}

#region Jump (obsolete)

//PlayerJump = function()
//{
//	jumpGraceTimer = 0;
//	jumpRememberTimer = 0;
//	varJumpTimer = varJumpTime;
//	xSpeed += jumpHBoost * xMove;
//	ySpeed = jumpSpeed;
//	varJumpSpeed = ySpeed;
	
//	xScale = 0.8;
//	yScale = 1.2;
//}

#endregion

UpdateInput = function(mouseIsDragging)
{
	if (!gamepad_is_connected(global.device))
	{
		global.inputMode = KEYBOARD;
	}
	else
	{
		global.inputMode = GAMEPAD;
		
		if (mouseIsDragging)
		{
			global.inputMode = KEYBOARD;
		}
	}
	
	if (global.inputMode == KEYBOARD)
	{
		global.inputDirection = point_direction(x + gunXOffset * facing, y + gunYOffset, mouse_x, mouse_y);
	}
	else
	{
		var axisHValue = gamepad_axis_value(global.device, gp_axisrh);
		var axisVValue = gamepad_axis_value(global.device, gp_axisrv);
		if (abs(axisHValue) > GAMEPAD_DEADZONE || abs(axisVValue) > GAMEPAD_DEADZONE)
		{
			global.inputDirection = point_direction(0, 0, axisHValue, axisVValue);
		}
	}
}

Animation = function(mouseIsDragging)
{
	if (xSpeed != 0 || ySpeed != 0)
	{
		sprite_index = sPlayerRun;
	}
	else
	{
		sprite_index = sPlayerIdle;
	}
	
	dir = point_direction(x, y, mouse_x, mouse_y);
	facing = dir > 90 && dir < 270 ? -1 : 1;
	
	gunDepth = global.inputDirection <= 135 && global.inputDirection >= 45 ? depth + 1 : depth - 1;
}

FreeUpdate = function()
{
	xInput = (keyRight - keyLeft);
	yInput = (keyDown - keyUp);
	
	moveMagnitude = (xInput != 0 || yInput != 0);
	moveDirection = point_direction(0, 0, xInput, yInput);
	
	if (xInput != 0)
	{
		facing = xInput;
	}
	
	xMove = lengthdir_x(moveMagnitude * runSpeed, moveDirection);
	yMove = lengthdir_y(moveMagnitude * runSpeed, moveDirection);
	
	var absSpeed;
	absSpeed = abs(xSpeed);
	if (absSpeed > runSpeed && absSpeed == xInput)
	{
		xSpeed = Approach(xSpeed, xMove, runAcceleration * 0.75);
	}
	else
	{
		xSpeed = Approach(xSpeed, xMove, runAcceleration);
	}
	
	absSpeed = abs(ySpeed);
	if (absSpeed > runSpeed && absSpeed == yInput)
	{
		ySpeed = Approach(ySpeed, yMove, runAcceleration * 0.75);
	}
	else
	{
		ySpeed = Approach(ySpeed, yMove, runAcceleration);
	}
	
	#region Jump and gravity stuff (obsolete)
	
	//if (varJumpTimer > 0)
	//{
	//	varJumpTimer--;
	//}
	
	//if (onGround)
	//{
	//	jumpGraceTimer = jumpGraceTime;
	//}
	//else if (jumpGraceTimer > 0)
	//{
	//	jumpGraceTimer--;
	//}
	
	//if (jumpRememberTimer > 0)
	//{
	//	jumpRememberTimer--;
	//}
	
	////Jump
	//{
	//	if (keyJumpPressed)
	//	{
	//		jumpRememberTimer = jumpRememberTime;
	//	}
		
	//	if (jumpRememberTimer > 0 && jumpGraceTimer > 0)
	//	{
	//		PlayerJump();
	//	}
	//}
	
	//if (!onGround)
    //{
	//	if (varJumpTimer > 0)
	//	{
	//		if (keyJump)
	//		{
	//		    ySpeed = min(ySpeed, varJumpSpeed);
	//		}
	//		else
	//		{
	//		    varJumpTimer = 0;
	//		}
	//	}
		
	//	var mult = (abs(ySpeed) < .2 && keyJump ? 0.5 : 1.0);

	//	ySpeed = Approach(ySpeed, maxYSpeed, .375 * mult);
	//}
	
	#endregion
}

stMachine = new StateMachine(PLAYER_STATES.TOTAL, PLAYER_STATES.FREE);
stMachine.AddState(PLAYER_STATES.FREE, FreeUpdate);
