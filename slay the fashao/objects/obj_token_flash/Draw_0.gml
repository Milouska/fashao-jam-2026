gpu_set_blendmode(bm_add);

with(obj_token_select) {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
}

gpu_set_blendmode(bm_normal);