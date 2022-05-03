//onGround = place_meeting(x, y + 1, pSolid);

keyRight = InputCheck("keyRight");
keyLeft = InputCheck("keyLeft");
keyDown = InputCheck("keyDown");
keyUp = InputCheck("keyUp");
//keyJumpPressed = InputCheckPressed("keyJump");
//keyJump = InputCheck("keyJump");

stMachine.Update();

// Changing weapon slot
var keyChangeLeft = keyboard_check_pressed(ord("Q")) || mouse_wheel_up();
var keyChangeRight = keyboard_check_pressed(ord("E")) || mouse_wheel_down();

if (keyChangeLeft)
{
	global.weaponSlot++;
	if (global.weaponSlot > 1)
	{
		global.weaponSlot = 0;
	}
	ChangeWeapon();
}
else if (keyChangeRight)
{
	global.weaponSlot--;
	if (global.weaponSlot < 0)
	{
		global.weaponSlot = 1;
	}
	ChangeWeapon();
}
