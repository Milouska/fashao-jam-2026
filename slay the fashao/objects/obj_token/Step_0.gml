image_xscale = lerp(image_xscale, 1, 0.2);
image_yscale = lerp(image_yscale, 1, 0.2);

if (selected) and (select_cd > 0) {
	var token_flash = instance_create_depth(x,y,-100,obj_token_select);
	token_flash.image_index = type;
	token_flash.image_speed = 0;
	token_flash.sprite_index = sprite_index;
	token_flash.image_angle = image_angle;
	select_cd --;
}