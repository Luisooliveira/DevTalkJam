event_inherited();

enum PLAYER_STATES
{
	FREE,
	TOTAL
}

xMove = 0;
yMove = 0;

xInput = 0;
yInput = 0;

runSpeed = 2.0;
runAcceleration = 0.4;

maxYSpeed = 5.0;

onGround = false;

// Jump variables
jumpGraceTime = 8;
jumpGraceTimer = 0;

varJumpTime = 12;
varJumpTimer = 0;
varJumpSpeed = 0;

jumpSpeed = -3.0;
jumpHBoost = 0.5;

jumpRememberTime = 12;
jumpRememberTimer = 0;

PlayerJump = function()
{
	var finalSpeed = jumpSpeed;

	jumpGraceTimer = 0;
	jumpRememberTimer = 0;
	varJumpTimer = varJumpTime;
	xSpeed += jumpHBoost * xMove;
	ySpeed = finalSpeed;
	varJumpSpeed = ySpeed;
	
	xScale = 0.8;
	yScale = 1.2;
}

FreeUpdate = function()
{
	xInput = (keyRight - keyLeft);
	
	if (xInput != 0)
	{
		facing = -xInput;
	}
	
	xMove = xInput * runSpeed;
	
	var absXSpeed = abs(xSpeed);
	if (absXSpeed > runSpeed && absXSpeed == xInput)
	{
		xSpeed = Approach(xSpeed, xMove, runAcceleration * 0.75);
	}
	else
	{
		xSpeed = Approach(xSpeed, xMove, runAcceleration);
	}
	
	if (varJumpTimer > 0)
	{
		varJumpTimer--;
	}
	
	if (onGround)
	{
		jumpGraceTimer = jumpGraceTime;
	}
	else if (jumpGraceTimer > 0)
	{
		jumpGraceTimer--;
	}
	
	if (jumpRememberTimer > 0)
	{
		jumpRememberTimer--;
	}
	
	//Jump
	{
		if (keyJumpPressed)
		{
			jumpRememberTimer = jumpRememberTime;
		}
		
		if (jumpRememberTimer > 0 && jumpGraceTimer > 0)
		{
			PlayerJump();
		}
	}
	
	if (!onGround)
    {
		if (varJumpTimer > 0)
		{
			if (keyJump)
			{
			    ySpeed = min(ySpeed, varJumpSpeed);
			}
			else
			{
			    varJumpTimer = 0;
			}
		}
		
		var mult = (abs(ySpeed) < .2 && keyJump ? 0.5 : 1.0);

		ySpeed = Approach(ySpeed, maxYSpeed, .375 * mult);
	}
}

stMachine = new StateMachine(PLAYER_STATES.TOTAL, PLAYER_STATES.FREE);
stMachine.AddState(PLAYER_STATES.FREE, FreeUpdate);
