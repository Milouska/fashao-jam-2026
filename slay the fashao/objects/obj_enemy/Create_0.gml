//enemies
enum EnemyType {
	BABY,
	GIANT,
	MANTICORE,
	NIGHTMARE,
	FIRELORD,
	CLOUD_MONKEY,
	
} 

death_callback = undefined

enum EnemyState {
	APPEAR,
	IDLE,
	ATTACK,
	DEATH
}

// Collection of enemy damage per turn. Damage is displayed by an amount of icons corresponding to the dmg
enemy_attacks = []
enemy_turn_index = 0
enemy_hp = 0

enemy_state = EnemyState.APPEAR;
type = choose(EnemyType.BABY,
			  EnemyType.GIANT,
			  EnemyType.MANTICORE,
			  EnemyType.NIGHTMARE,
			  EnemyType.FIRELORD,
			  EnemyType.CLOUD_MONKEY);

// Always fight this tall ass head baby in first combat
if (obj_control.stats.enemies_killed == 0) {
    type = EnemyType.BABY;
}

switch (type) {
	case EnemyType.BABY:
		enemy_attacks = [1, 1];
		enemy_hp = 6
	break;
	case EnemyType.GIANT:
		enemy_attacks = [0, 1, 2, 3, 4, 5, 6];
		enemy_hp = 15
	break;
	case EnemyType.MANTICORE:
		enemy_attacks = [2, 0];
		enemy_hp = 8
	break;
	case EnemyType.NIGHTMARE:
		enemy_attacks = [0, 0, 3];
		enemy_hp = 13
	break;
	case EnemyType.FIRELORD:
		enemy_attacks = [2, 3];
		enemy_hp = 7
	break;
	case EnemyType.CLOUD_MONKEY:
		enemy_attacks = [1, 1, 2, 0];
		enemy_hp = 6
	break;
}

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