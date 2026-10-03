repeat(6) {
	instance_create_depth(room_width / 2, room_height / 2 + 64, choose(1, -1), obj_fire);
}
instance_create_depth(room_width / 2, room_height / 2 + 64, -1, obj_explosion);
