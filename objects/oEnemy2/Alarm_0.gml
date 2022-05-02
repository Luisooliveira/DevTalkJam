if (stunned || purified){
	exit;
}

var dir = point_direction(x, y, oPlayer.x, oPlayer.y);
var blt = instance_create_depth(x, y + bulletYOffset, depth, oEnemy2Bullet);
blt.direction = dir;
blt.image_angle = dir;
blt.speed = 3.0;
blt.owner = id;
