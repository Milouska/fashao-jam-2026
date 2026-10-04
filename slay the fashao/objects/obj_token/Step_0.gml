image_xscale = lerp(image_xscale, 1, 0.2);
image_yscale = lerp(image_yscale, 1, 0.2);

if (selected) {
	var token_flash = instance_create_depth(x,y,-100,obj_token_select);
	token_flash.image_index = type;
	token_flash.image_speed = 0;
	token_flash.sprite_index = sprite_index;
	token_flash.image_angle = image_angle;
	
	if (selected_once = false) {
		var token_flash = instance_create_depth(x,y,-100,obj_token_quickflash);
		token_flash.image_index = type;
		token_flash.image_speed = 0;
		token_flash.sprite_index = sprite_index;
		token_flash.image_angle = image_angle;
		selected_once = true;
	}
}

var token_flash = instance_create_depth(x,y,-100,obj_token_select);
token_flash.image_index = type;
token_flash.image_speed = 0;
token_flash.sprite_index = sprite_index;
token_flash.image_angle = image_angle;
token_flash.image_alpha = 0.02;