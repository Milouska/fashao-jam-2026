gpu_set_blendmode(bm_add);

with(obj_token_select) {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
}

with(obj_screen_slash) {
	repeat(40)
		draw_sprite_ext(sprite_index, image_index, x + random_range(-3,3) + random_range(-shake/2, shake/2), y + random_range(-3,3)+random_range(-shake/2, shake/2), image_xscale, image_yscale, image_angle+random_range(-shake/4, shake/4), c_white, 0.08);
}

gpu_set_blendmode(bm_normal);