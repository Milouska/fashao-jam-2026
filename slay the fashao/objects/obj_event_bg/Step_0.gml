switch (state) {
	case 0:
		len_target = 180;
		image_alpha = lerp(image_alpha, 0.6, 0.2);
		image_xscale = lerp(image_xscale, 1, 0.2);
		image_yscale = lerp(image_yscale, 1, 0.2);
	break;
	case 1:
		len_target = 240;
		image_alpha = lerp(image_alpha, 0, 0.2);
		image_xscale = lerp(image_xscale, 2, 0.2);
		image_yscale = lerp(image_yscale, 2, 0.2);
		if (image_alpha < 0.01) instance_destroy();
	break;
}

x = room_width / 2 + lengthdir_x(len, dir);
y = room_height / 2 + lengthdir_y(len, dir);
len = lerp(len, len_target, 0.2);

depth = 50;