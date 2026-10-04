image_xscale = lerp(image_xscale, 2, 0.1);
image_yscale = lerp(image_yscale, 2, 0.1);

if (image_xscale > 1.5) {
	image_alpha -= 0.005;
	
	if (image_alpha <= 0) instance_destroy();
}

depth = -100;