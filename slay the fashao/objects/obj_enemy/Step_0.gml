x = room_width / 2;
y = room_height / 2;

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
			if (type = EnemyType.CLOUD_MONKEY) {
				var target_ang = random(360);
				var target_len = obj_barier.radius * 0.6;
				
				repeat(clouds) {
					var cang = random(360);
					var clen = random_range(0,32);
					
					instance_create_depth(x+lengthdir_x(target_len,target_ang)+lengthdir_x(clen,cang),y+lengthdir_y(target_len,target_ang)+lengthdir_y(clen,cang),-1000,obj_cloud);
				}
			}
			
			if (type = EnemyType.THORNS) {
				with(obj_barier) {
					thorned = true;
				}
			}
		}
	break;
	case EnemyState.IDLE:
		intention_alpha = approach(intention_alpha, 1, 0.05);
		enemy_a += 0.02;
		enemy_rot = sin(enemy_a) * 5;
	break;
	case EnemyState.ATTACK:
		if (enemy_attacks[turn_count] > 0) {
			enemy_attack_a = approach(enemy_attack_a, pi / 4 * 3, 0.15);
			enemy_y = sin(abs(enemy_attack_a) + pi/4) * 64;
			enemy_scale = 1.4 - 0.4 * abs(enemy_attack_a / (pi/4*3));
		
			//attack player
			if (enemy_attack_a > 0) and (attacked = false) {
				var damage = enemy_attacks[turn_count];
				
				with(obj_shield) {
					if (damage > 0) {
						image_index = 1;
						image_xscale = 2;
						image_yscale = 2;
						damage --;
					}
				}
				
				obj_control.take_damage(damage);
                
                obj_control.stats.damage_taken += damage
				with(obj_camera) hshake = 20;
				attacked = true;
				
				if (type = EnemyType.LEECH) {
					repeat(leech) {
						var stats = [];
						if (obj_control.strength > 0) array_push(stats, 0);
						if (obj_control.endurance > 0) array_push(stats, 1);
						if (obj_control.wisdom > 0) array_push(stats, 3);
						if (obj_control.stamina > 0) array_push(stats, 2);
						if (obj_control.inteligence > 0) array_push(stats, 4);
						
						array_shuffle(stats);
						
						var choice = stats[0];
						if (choice != undefined) {
							switch(choice) {
								case 0:
									obj_control.strength --;
								break;
								case 1:
									obj_control.endurance --;
								break;
								case 2:
									obj_control.stamina --;
								break;
								case 3:
									obj_control.wisdom --;
								break;
								case 4:
									obj_control.inteligence --;
								break;
							}
						}
					}
				}
				
				if (type = EnemyType.SPLIT_SCREEN) {
					var slash = instance_create_depth(room_width / 2, room_height / 2, -1000, obj_screen_slash);
					slash.image_angle = random(360);
					with(obj_camera) {
						hshake = 40;
						vshake = 40;
					}
					obj_control.impact_timer = 4;
				}
			}
		}
		
		if (enemy_attack_a = pi / 4 * 3) or (enemy_attacks[turn_count] = 0) {
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
				
				with(obj_shield) {
					gone = true;
				}
            }))
		}
	break;
	case EnemyState.DEATH:
		enemy_alpha = approach(enemy_alpha, 0, 0.05);
		if (enemy_alpha = 0) {
			instance_destroy();
			with(obj_shield) {
				gone = true;
			}
		}
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