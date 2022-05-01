var dir = image_angle;
var rand = random_range(-1, 1);
x0 = attackXTo + lengthdir_x(attackWidth * 3, dir + 90) * rand;

y0 = attackYTo + lengthdir_y(attackWidth * 3, dir + 90) * rand;

// Update the particle direction
part_type_direction(attackParticle, global.inputDirection - 180 + (20 * rand), global.inputDirection - 180, 0, 0);

part_particles_create(global.particleSystem, x0, y0, attackParticle, 1);
