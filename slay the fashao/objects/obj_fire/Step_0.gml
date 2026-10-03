life --;
if(life < 0) {
	image_yscale -= 0.02;
	if (image_yscale <= 0) instance_destroy();
}

if (vspeed != 0)
	depth = -sign(vspeed);