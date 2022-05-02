// Inherit the parent event
event_inherited();

life = 4;

tangible = false;

shadowType = SHADOW_TYPES.HUGE;

// Placeholder
xScale = 2;
yScale = 2;
maxXScale = 2;
maxYScale = 2;

fly = false;

image_blend = c_red;

Explode = function()
{
	instance_create_depth(x - 16, y, depth, oEnemy1);
	instance_create_depth(x + 16, y, depth, oEnemy1);
}
