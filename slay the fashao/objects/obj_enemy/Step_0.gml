switch (enemy_state) {
	case EnemyState.APPEAR:
		enemy_alpha = approach(enemy_alpha, 1, 0.02 * 2);
		enemy_a = approach(enemy_a, pi, pi / 75 * 2);
		enemy_y = sin(enemy_a) * 64;
		enemy_scale = approach(enemy_scale, 1, 0.5 / 50 * 2);
		
		if (enemy_a = pi) {
			enemy_state = EnemyState.IDLE;
			enemy_scale = 1;
			enemy_alpha = 1;
		}
	break;
	case EnemyState.IDLE:
		intention_alpha = approach(intention_alpha, 1, 0.05);
		enemy_a += 0.02;
		enemy_rot = sin(enemy_a) * 5;
	break;
	case EnemyState.ATTACK:
		enemy_attack_a = approach(enemy_attack_a, pi / 4 * 3, 0.15);
		enemy_y = sin(abs(enemy_attack_a) + pi/4) * 64;
		enemy_scale = 1.4 - 0.4 * abs(enemy_attack_a / (pi/4*3));
		
		//attack player
		if (enemy_attack_a > 0) and (attacked = false) {
			obj_control.player_hp -= enemy_attacks[turn_count];
			with(obj_camera) hshake = 20;
			attacked = true;
		}
		
		if (enemy_attack_a = pi / 4 * 3) {
			enemy_attack_a = - pi / 4 * 3;
			enemy_state = EnemyState.IDLE;
			enemy_scale = 1;
			attacked = false;
			if (turn_count < array_length(enemy_attacks) - 1) {
				turn_count ++;
			} else {
				turn_count = 0;
			}
            
            // Attack ended. We have to make sure player's turn starts again
            call_later(1, time_source_units_seconds, method(self, function() {
                obj_control.start_player_turn()
            }))
		}
	break;
	case EnemyState.DEATH:
		enemy_alpha = approach(enemy_alpha, 0, 0.05);
		if (enemy_alpha = 0) instance_destroy();
	break;
}

if (enemy_shake > 0) {
	enemy_shake = approach(enemy_shake, 0, 2);
	var ang = random(360);
	shake_x = lengthdir_x(enemy_shake, ang);
	shake_y = lengthdir_y(enemy_shake, ang);
} else {
	shake_x = 0;
	shake_y = 0;
}