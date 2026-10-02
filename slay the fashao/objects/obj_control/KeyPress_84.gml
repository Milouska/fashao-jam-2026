repeat(10) {
	var ang = random(360);
	var len = random_range(0,16);
	instance_create_depth(room_width / 2 + lengthdir_x(len, ang), room_height / 2 + lengthdir_y(len, ang), 0, obj_token);
}