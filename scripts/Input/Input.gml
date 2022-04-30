#macro KEYBOARD 0
#macro GAMEPAD 1
#macro GAMEPAD_DEADZONE 0.2
#macro INPUT global.input

global.device = 0;
global.input = new Input();

enum GP_AXIS
{
	LRIGHT,
	LUP,
	LLEFT,
	LDOWN,
	RRIGHT,
	RUP,
	RLEFT,
	RDOWN,
	TOTAL
}

function Input() constructor
{
	static Add = function(name, keyboard, gamepad)
	{
		if (KeyExists(name))
		{
			return false;
		}
		self[$ name] = new Key(keyboard, gamepad);
		return true;
	}
	
	static Push = function(name, keyboard = undefined, gamepad = undefined)
	{
		if (!KeyExists(name))
		{
			return false;
		}
		
		var i = 0;
		if (keyboard != undefined)
		{
			repeat (array_length(self[$ name].array[KEYBOARD]))
			{
				if (self[$ name].array[KEYBOARD][i++] == keyboard)
				{
					return false;
				}
			}
			array_push(self[$ name].array[KEYBOARD], keyboard);
		}
		
		if (gamepad != undefined)
		{
			repeat (array_length(self[$ name][KEYBOARD].array))
			{
				if (self[$ name].array[GAMEPAD][i++] == gamepad)
				{
					return false;
				}
			}
			array_push(self[$ name].array[GAMEPAD], gamepad);
		}
		
		return true;
	}
	
	static Rebind = function(name, keyboard, gamepad)
	{
		if (!Remove())
		{
			return false;
		}
		self[$ name] = new Key(keyboard, gamepad);
		return true;
	}
	
	static Remove = function()
	{
		if (!KeyExists(name))
		{
			return false;
		}
		variable_struct_remove(self, name);
		return true;
	}
	
	static KeyExists = function(name)
	{
		return variable_struct_exists(self, name);
	}
}

function Key(keyboard, gamepad) constructor
{
	static checks = [array_create(GP_AXIS.TOTAL, false), array_create(GP_AXIS.TOTAL, false)]; //Array for each gamepad axis info [axis pressed, axis released]
	array = [keyboard, gamepad];
	
	static GetPressed = function()
	{
		var i = 0;
		repeat (array_length(array[KEYBOARD]))
		{
			if (keyboard_check_pressed(array[KEYBOARD][i++]))
			{
				return true;
			}
		}
		
		i = 0;
		
		if (gamepad_is_connected(global.device))
		{
			repeat (array_length(array[GAMEPAD]))
			{
				var value = array[GAMEPAD][i];
				var deadzone = GAMEPAD_DEADZONE;
				var device = global.device;
				var check = min(value, GP_AXIS.TOTAL - 1);
				var index = 0;
				switch (value)
				{
					case GP_AXIS.LDOWN:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axislv) > deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axislv)) < deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.LLEFT:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axislh) < -deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axislh)) < deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.LRIGHT:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axislh) > deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axislh)) < deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.LUP:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axislv) < -deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axislv)) < deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.RDOWN:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axisrv) > deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axisrv)) < deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.RLEFT:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axisrh) < -deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axisrh)) < deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.RRIGHT:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axisrh) > deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axisrh)) < deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.RUP:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axisrv) < -deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axisrv)) < deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					default:
					{
						if (gamepad_button_check_pressed(device, array[GAMEPAD][i]))
						{
							return true;
						}
					}
					break;
				}
			
				i++;
			}
		}
		
		return false;
	}
	
	static GetDown = function()
	{
		var i = 0;
		repeat (array_length(array[KEYBOARD]))
		{
			if (keyboard_check(array[KEYBOARD][i++]))
			{
				return true;
			}
		}
		
		i = 0;
		
		if (gamepad_is_connected(global.device))
		{
			repeat (array_length(array[GAMEPAD]))
			{
				var value = array[GAMEPAD][i];
				var deadzone = GAMEPAD_DEADZONE;
				var device = global.device;
				switch (value)
				{
					case GP_AXIS.LDOWN:
					{
						if (gamepad_axis_value(device, gp_axislv) > deadzone)
						{
							return true;
						}
					}
					break;
				
					case GP_AXIS.LLEFT:
					{
						if (gamepad_axis_value(device, gp_axislh) < -deadzone)
						{
							return true;
						}
					}
					break;
				
					case GP_AXIS.LRIGHT:
					{
						if (gamepad_axis_value(device, gp_axislh) > deadzone)
						{
							return true;
						}
					}
					break;
				
					case GP_AXIS.LUP:
					{
						if (gamepad_axis_value(device, gp_axislv) < -deadzone)
						{
							return true;
						}
					}
					break;
				
					case GP_AXIS.RDOWN:
					{
						if (gamepad_axis_value(device, gp_axisrv) > deadzone)
						{
							return true;
						}
					}
					break;
				
					case GP_AXIS.RLEFT:
					{
						if (gamepad_axis_value(device, gp_axisrh) < -deadzone)
						{
							return true;
						}
					}
					break;
				
					case GP_AXIS.RRIGHT:
					{
						if (gamepad_axis_value(device, gp_axisrh) > deadzone)
						{
							return true;
						}
					}
					break;
				
					case GP_AXIS.RUP:
					{
						if (gamepad_axis_value(device, gp_axisrv) < -deadzone)
						{
							return true;
						}
					}
					break;
				
					default:
					{
						if (gamepad_button_check(device, array[GAMEPAD][i]))
						{
							return true;
						}
					}
					break;
				}
			
				i++;
			}
		}
		
		return false;
	}
	
	static GetReleased = function()
	{
		var i = 0;
		repeat (array_length(array[KEYBOARD]))
		{
			if (keyboard_check_released(array[KEYBOARD][i++]))
			{
				return true;
			}
		}
		
		i = 0;
		
		if (gamepad_is_connected(global.device))
		{
			repeat (array_length(array[GAMEPAD]))
			{
				var value = array[GAMEPAD][i];
				var deadzone = GAMEPAD_DEADZONE;
				var device = global.device;
				var check = min(value, GP_AXIS.TOTAL - 1);
				var index = 1;
				switch (value)
				{
					case GP_AXIS.LDOWN:
					{
						if (gamepad_axis_value(device, gp_axislv) < deadzone && checks[index][check])
						{
							checks[index][check] = true;
						}
						else if (abs(gamepad_axis_value(device, gp_axislv)) > deadzone)
						{
							checks[index][check] = false;
							return true;
						}
					}
					break;
				
					case GP_AXIS.LLEFT:
					{
						if (gamepad_axis_value(device, gp_axislh) < -deadzone)
						{
							checks[index][check] = true;
						}
						else if (abs(gamepad_axis_value(device, gp_axislh)) < deadzone && checks[index][check])
						{
							checks[index][check] = false;
							return true;
						}
					}
					break;
				
					case GP_AXIS.LRIGHT:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axislh) < deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axislh)) > deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.LUP:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axislv) < -deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axislv)) > deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.RDOWN:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axisrv) < deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axisrv)) > deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.RLEFT:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axisrh) > -deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axisrh)) > deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.RRIGHT:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axisrh) < deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axisrh)) > deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					case GP_AXIS.RUP:
					{
						if (checks[index][check])
						{
							if (gamepad_axis_value(device, gp_axisrv) > -deadzone)
							{
								checks[index][check] = false;
								return true;
							}
						}
						else if (abs(gamepad_axis_value(device, gp_axisrv)) > deadzone)
						{
							checks[index][check] = true;
						}
					}
					break;
				
					default:
					{
						if (gamepad_button_check_released(device, array[GAMEPAD][i]))
						{
							return true;
						}
					}
					break;
				}
			
				i++;
			}
		}
		
		return false;
	}
}

function InputAdd(name, keyboard, gamepad)
{
	with (INPUT)
	{
		Add(name, keyboard, gamepad);
	}
}

function InputPush(name, keyboard = undefined, gamepad = undefined)
{
	with (INPUT)
	{
		Push(name, keyboard, gamepad);
	}
}

function InputRebind(name, keyboard, gamepad)
{
	with (INPUT)
	{
		Rebind(name, keyboard, gamepad);
	}
}

function InputRemove(name, keyboard, gamepad)
{
	with (INPUT)
	{
		Remove(name, keyboard, gamepad);
	}
}

function InputCheck(name)
{
	return INPUT[$ name].GetDown();
}

function InputCheckPressed(name)
{
	return INPUT[$ name].GetPressed();
}

function InputCheckReleased(name)
{
	return INPUT[$ name].GetReleased();
}