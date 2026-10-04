alarm[0] = 3;
if (instance_exists(obj_token)) {
	var nearest = instance_nearest(x, y, obj_token);
	var dist = point_distance(x,y,nearest.x,nearest.y);
	var a = 255 / dist / 32 - 0.1;
	a = clamp(a, 0, 180);
	image_alpha = lerp(image_alpha, a, 0.2);
} else {
	image_alpha = lerp(image_alpha, 0, 0.2);
}