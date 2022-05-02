//onGround = place_meeting(x, y + 1, pSolid);

keyRight = InputCheck("keyRight");
keyLeft = InputCheck("keyLeft");
keyDown = InputCheck("keyDown");
keyUp = InputCheck("keyUp");
//keyJumpPressed = InputCheckPressed("keyJump");
//keyJump = InputCheck("keyJump");

stMachine.Update();

// Changing weapon slot
var keyChange = (mouse_wheel_down() - mouse_wheel_up());

if (keyChange == 1)
{
	global.weaponSlot++;
	if (global.weaponSlot > 1)
	{
		global.weaponSlot = 0;
	}
	ChangeWeapon();
}
else if (keyChange == -1)
{
	global.weaponSlot--;
	if (global.weaponSlot < 0)
	{
		global.weaponSlot = 1;
	}
	ChangeWeapon();
}
