if (dissapear = false) {
	image_yscale = lerp(image_yscale, 1, 0.2);
} else {
	image_yscale = lerp(image_yscale, 4, 0.2);
	image_alpha -= 0.05;
	if (image_alpha <= 0) instance_destroy();
}