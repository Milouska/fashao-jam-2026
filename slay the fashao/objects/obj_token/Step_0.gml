image_xscale = lerp(image_xscale, 1, 0.2);
image_yscale = lerp(image_yscale, 1, 0.2);

image_angle += spin * speed;


if (selected) {
	if (type < 5) {
		var token_flash = instance_create_depth(x,y,-100,obj_token_select);
		token_flash.image_index = type;
		token_flash.image_speed = 0;
		token_flash.sprite_index = sprite_index;
		token_flash.image_angle = image_angle;
	}
	if (selected_once = false) {
		var token_flash = instance_create_depth(x,y,-100,obj_token_quickflash);
		token_flash.image_index = type;
		token_flash.image_speed = 0;
		token_flash.sprite_index = sprite_index;
		token_flash.image_angle = image_angle;
		selected_once = true;
	}
}
if (type < 5) {
	var token_flash = instance_create_depth(x,y,-100,obj_token_select);
	token_flash.image_index = type;
	token_flash.image_speed = 0;
	token_flash.sprite_index = sprite_index;
	token_flash.image_angle = image_angle;
	token_flash.image_alpha = 0.02;
}

var token_width = 16;
if (type > 4) token_width = 24;
if (point_distance(x,y,room_width/2,room_height/2) > obj_control.barier_radius - token_width) {
	direction = direction - 180 - angle_difference(direction-180,point_direction(x,y,room_width/2,room_height/2));
	motion_add(point_direction(x,y,room_width/2,room_height/2), friction * 2);
}