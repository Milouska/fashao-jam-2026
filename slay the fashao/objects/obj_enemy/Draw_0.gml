var damage_offset = 48;

if (enemy_state != EnemyState.APPEAR) {
	var damage = enemy_attacks[turn_count]
	if (damage > 0) {
		for (var i = 0; i < damage; i++) {
			draw_sprite_ext(spr_damage, 1, room_width / 2 - (damage / 2) * damage_offset + i * damage_offset + damage_offset / 2, room_height / 2 - 128, 0.2, 0.2, -45, c_white, intention_alpha);
			if (i > 0) {
				draw_sprite_ext(spr_damage_border, 1, room_width / 2 - (damage / 2) * damage_offset + i * damage_offset, room_height / 2 - 128, 0.172, 0.172, 0, c_white, 1);
			}
		}
		for (var i = 0; i < damage; i++) {
			draw_sprite_ext(spr_damage, 0, room_width / 2 - (damage / 2) * damage_offset + i * damage_offset + damage_offset / 2, room_height / 2 - 128, 0.2, 0.2, -45, c_white, intention_alpha);
		}
	}
}

draw_sprite_ext(sprite_index, type, room_width / 2 + shake_x, room_height / 2 - enemy_y + shake_y, enemy_scale, enemy_scale, enemy_rot, c_white, enemy_alpha);