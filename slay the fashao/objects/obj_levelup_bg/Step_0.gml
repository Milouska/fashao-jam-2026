switch(state) {
	case 0:
		image_xscale = lerp(image_xscale, 1, 0.2);
		image_yscale = lerp(image_yscale, 1, 0.2);
		image_alpha = lerp(image_alpha, 1, 0.2);
	break;
	case 1:
		image_alpha = lerp(image_alpha, 0, 0.2);
		image_xscale = lerp(image_xscale, 2, 0.2);
		image_yscale = lerp(image_yscale, 2, 0.2);
		
		if (image_alpha < 0.01) instance_destroy();
	break;
}

depth = 50;