// Purify the enemy
if (global.capturedEnemy == other.id)
{
	if (global.ectoplasm < global.maxEctoplasm)
	{
		global.ectoplasm += global.capturedEnemy.ectoplasm;
	}
	
	global.capturedEnemy.captured = true;
	global.capturedEnemy = noone;
}
