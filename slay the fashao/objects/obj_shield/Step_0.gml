image_xscale = lerp(image_xscale, 0.5, 0.2);
image_yscale = lerp(image_yscale, 0.5, 0.2);

depth = -100;

shield_a += 0.02;

image_angle = sin(shield_a) * 2;

if (image_index = 1) or (gone) {
	image_alpha = approach(image_alpha, 0, 0.05);
	y += 1;
	if (image_alpha = 0) instance_destroy();
} else {
	image_alpha = lerp(image_alpha, 1, 0.2);
	y = approach(y, room_height - 24 - row * 64, spd);
}