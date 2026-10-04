depth = -10000;

if (gone = false) {
	image_xscale = lerp(image_xscale, 1, 0.2);
	image_yscale = lerp(image_yscale, 1, 0.2);
} else {
	image_xscale = approach(image_xscale, 0, 0.05);
	image_yscale = approach(image_yscale, 0, 0.05);
	
	if (image_xscale = 0) instance_destroy();
}


angle_a += 0.02;

image_angle += sin(angle_a) * 0.02;