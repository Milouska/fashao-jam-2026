alarm[0] = 15;

if (pending_slash > 0) {
	var ang = random(360);
	var len = random_range(0,48);
	instance_create_depth(x + lengthdir_x(len, ang), y + lengthdir_y(len, ang), -5, obj_slash);
	call_later(10, time_source_units_frames, method(self, function() {
                    enemy_hp --;
                    if (enemy_hp <= 0) {
						enemy_state = EnemyState.DEATH;
					}
					enemy_shake = 24;
                }))
	pending_slash = approach(pending_slash, 0, 1);
}