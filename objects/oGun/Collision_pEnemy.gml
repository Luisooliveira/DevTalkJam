// Purify the enemy
if (global.capturedEnemy == other.id)
{
	if (global.ectoplasm < global.maxEctoplasm)
	{
		global.ectoplasm += global.capturedEnemy.ectoplasm;
	}
	
	instance_destroy(global.capturedEnemy);
	global.capturedEnemy = noone;
}
