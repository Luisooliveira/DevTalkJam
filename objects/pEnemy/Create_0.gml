event_inherited();

tangible = true;
resistence = 50;
ectoplasm = 5;

stunned = false;
stunTime = room_speed * 5;
stunTimer = 0;

areaRadius = 64;
areaOverlapping = false;

tryingToEscape = false;
escapeSpeed = 0.5;

purified = false;

siner = random(360);

areaRadius = 128;

purifyTimer = global.purifyTime;

xBuff = 0;

fly = true;

invincible = false;
invincibleTime = room_speed * 0.5;
invincibleTimer = 0;

spriteY = 0;

OnAreaOverlap = function()
{
	
}

OnAreaNotOverlap = function()
{
	
}

Onpurified = function()
{
	
}

Die = function()
{
	
}

EndStep = function()
{
	
}
