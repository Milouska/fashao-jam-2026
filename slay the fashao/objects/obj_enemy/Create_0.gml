//enemies
enum EnemyType {
	BABY,
	GIANT,
	MANTICORE,
	NIGHTMARE,
	FIRELORD,
	CLOUD_MONKEY,
	SPLIT_SCREEN,
	THORNS,
	LEECH,
	
} 

death_callback = undefined

enum EnemyState {
	APPEAR,
	IDLE,
	ATTACK,
	DEATH
}

// Collection of enemy damage per turn. Damage is displayed by an amount of icons corresponding to the dmg
enemy_turn_index = 0

enemy_state = EnemyState.APPEAR;
type = choose(EnemyType.BABY,
			  EnemyType.GIANT,
			  EnemyType.MANTICORE,
			  EnemyType.NIGHTMARE,
			  EnemyType.FIRELORD,
			  EnemyType.CLOUD_MONKEY,
			  EnemyType.SPLIT_SCREEN,
			  EnemyType.THORNS,
			  EnemyType.LEECH);
			  

// Always fight this tall ass head baby in first combat
if (obj_control.stats.enemies_killed == 0) {
    type = EnemyType.BABY;
}
type = EnemyType.THORNS;

var attacks_data = global.enemy_attacks[type]

enemy_attacks = attacks_data.attacks
enemy_hp = attacks_data.hp
leech = 0;
if (EnemyType.LEECH) leech = attacks_data.leech;

tokens_spawn = struct_get(attacks_data, "tokens") ?? 0
clouds = struct_get(attacks_data, "clouds") ?? 0

max_enemy_hp = enemy_hp;


turn_count = 0; //which attack from enemy_attacks array to use this turn
attacked = false; //if already attacked this is set to true
intention_alpha = 0; //show intention of next attack

// attack effect
attack_a = pi/2;
enemy_scale = 0.5;
enemy_rot = 0;
enemy_a = pi / 4;
enemy_attack_a = - pi / 4 * 3;

// hit effect
enemy_shake = 0;
shake_x = 0;
shake_y = 0;

// enemy appear effect
enemy_alpha = 0;

// getting attacked
pending_slash = 0;
pending_fireball = 0;

// Shape
shape_size = 0