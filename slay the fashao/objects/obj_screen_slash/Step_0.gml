if (gone = false) {
	image_xscale = lerp(image_xscale, 2, 0.4);
	image_yscale = lerp(image_yscale, 1, 0.2);
} else {
	image_yscale = lerp(image_yscale, 0, 0.2);
	if (image_yscale < 0.01) instance_destroy();
}

shake = approach(shake, 0, 1);