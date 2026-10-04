alarm[0] = 3;


if (instance_exists(obj_token)) {
	var nearest = instance_nearest(x, y, obj_token);
	var dist = point_distance(x,y,nearest.x,nearest.y);
	var a = 160 / dist / 96;
	a = clamp(a, 0, 180);
	image_alpha = a;
}