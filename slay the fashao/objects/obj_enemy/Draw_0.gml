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
	
	var max_hp_row = 6;
	var hp_deg_offset = 10;
	var hp_len_offset = 18;
	for (var i = 0; i < max_enemy_hp; i++) {
		var hp_dir = 210 + min(max_hp_row, max_enemy_hp) / 2 * hp_deg_offset - floor(i/max_hp_row) * max_hp_row * hp_deg_offset + hp_deg_offset / 2;
		var len = 96 + hp_len_offset * floor(i/max_hp_row);
		
		draw_sprite_ext(spr_enemy_hp, 1, x + lengthdir_x(len, hp_dir + i * hp_deg_offset), y + lengthdir_y(len, hp_dir + i * hp_deg_offset), 0.3, 0.3, 0, c_white, enemy_alpha * 0.75);
		
		if (i < enemy_hp) {
			draw_sprite_ext(spr_enemy_hp, 0, x + lengthdir_x(len, hp_dir + i * hp_deg_offset), y + lengthdir_y(len, hp_dir + i * hp_deg_offset), 0.3, 0.3, random(360), c_white, enemy_alpha * 0.75);
		}
	}
}

draw_sprite_ext(sprite_index, type, room_width / 2 + shake_x, room_height / 2 - enemy_y + shake_y, enemy_scale, enemy_scale, enemy_rot, c_white, enemy_alpha);